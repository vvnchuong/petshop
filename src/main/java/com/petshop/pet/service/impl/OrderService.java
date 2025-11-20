package com.petshop.pet.service.impl;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.*;
import com.petshop.pet.domain.dto.CheckoutRequestDTO;
import com.petshop.pet.enums.ErrorCode;
import com.petshop.pet.enums.Status;
import com.petshop.pet.exception.BusinessException;
import com.petshop.pet.repository.OrderRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.SecureRandom;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class OrderService {

    private final OrderRepository orderRepository;

    private final CartDetailService cartDetailService;

    private final UserService userService;

    private final VoucherService voucherService;

    private final CartService cartService;

    private final StockService stockService;

    private final PricingService pricingService;

    private final OrderDetailService orderDetailService;

    private final ProductService productService;

    public OrderService(OrderRepository orderRepository,
                        CartDetailService cartDetailService,
                        UserService userService,
                        VoucherService voucherService,
                        CartService cartService,
                        StockService stockService,
                        PricingService pricingService,
                        OrderDetailService orderDetailService,
                        ProductService productService){
        this.orderRepository = orderRepository;
        this.cartDetailService = cartDetailService;
        this.userService = userService;
        this.voucherService = voucherService;
        this.cartService = cartService;
        this.stockService = stockService;
        this.pricingService = pricingService;
        this.orderDetailService = orderDetailService;
        this.productService = productService;
    }


    @Transactional
    public Order createOrder(CheckoutRequestDTO dto,
                             CustomUserDetails currentUser,
                             Map<String, Integer> guestCart,
                             String sessionId){

        User user = currentUser != null ? userService.getUserByUserName(currentUser.getUsername()) : null;
        List<CartDetail> cartDetails;

        if(currentUser != null){
            cartDetails = cartDetailService.getAllProductsInCartByUser(currentUser.getUsername());
        }else{
            cartDetails = guestCart.entrySet().stream().map(e -> {
                Product p = productService.getProductBySlug(e.getKey());
                CartDetail cd = new CartDetail();
                cd.setProduct(p);
                cd.setPrice(p.getPrice());
                cd.setQuantity(e.getValue());
                cd.setCart(null);
                return cd;
            }).collect(Collectors.toList());
        }

        Voucher voucher = voucherService.checkVoucher(dto.getVoucherCode());
        voucherService.increaseUsedCount(voucher);
        double finalPrice = pricingService.calculateFinalPrice(cartDetails, voucher);

        Order order = buildOrder(dto, user, finalPrice);
        order.setOrderCode(generateOrderCode());
        order.setSessionId(sessionId);

        order.setStatus(Status.PENDING);
        orderRepository.save(order);

        orderDetailService.saveOrderDetails(order, cartDetails);

        return order;
    }

    @Transactional
    public void confirmOrderPayment(long orderId, Map<String, String> paymentFields, String sessionId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new BusinessException(ErrorCode.ORDER_NOT_FOUND));

        if (order.getStatus() != Status.PENDING)
            return;

        if (paymentFields != null) {
            String responseCode = paymentFields.get("vnp_ResponseCode");
            String transactionNo = paymentFields.get("vnp_TransactionNo");
            order.setResponseCode(responseCode);
            order.setTransactionCode(transactionNo);
        }

        order.setStatus(Status.PENDING);
        orderRepository.save(order);

        List<OrderDetail> orderDetails = orderDetailService.getAllByOrder(order);

        stockService.reserveStock(orderDetails);

        if(order.getUser() != null){
            User user = order.getUser();
            cartDetailService.deleteAllProductInCartByCartId(user.getCart());
            cartService.resetCart(user);
        }
    }

    @Transactional
    public void failOrderPayment(long orderId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new BusinessException(ErrorCode.ORDER_NOT_FOUND));

        if (order.getStatus() == Status.PENDING) {
            order.setStatus(Status.FAILED);
            orderRepository.save(order);
        }
    }

    private String generateOrderCode() {
        SecureRandom random = new SecureRandom();

        String datePart = LocalDateTime.now()
                .format(DateTimeFormatter.ofPattern("yyMMdd"));

        long randomNumber = 10000000L + random.nextInt(90000000);

        return datePart + randomNumber;
    }

    private Order buildOrder(CheckoutRequestDTO dto, User user, double finalPrice){
        Order order = new Order();
        order.setReceiverName(dto.getReceiverName());
        order.setReceiverPhone(dto.getReceiverPhone());
        order.setShippingAddress(dto.getReceiverAddress());
        order.setPaymentMethod(dto.getPaymentMethod());
        order.setStatus(dto.getStatus());
        order.setCreatedAt(Instant.now());
        order.setTotalAmount(finalPrice);
        order.setUser(user);

        return order;
    }

    public List<Order> getAllOrderByUser(String username) {
        return orderRepository.findByUserUsernameAndStatusInOrderByCreatedAtDesc(
                username,
                List.of(Status.PENDING, Status.SHIPPING, Status.DELIVERED, Status.CANCELLED));
    }

    public Order getOrderByIdAndUser(long orderId, String username){
        return orderRepository.findByIdAndUserUsername(orderId, username);
    }

    public Order getOrderByGuess(long orderId, String session){
        return orderRepository.findByIdAndSessionId(orderId, session)
                .orElseThrow(() -> new BusinessException(ErrorCode.ORDER_NOT_FOUND));
    }

    public Page<Order> getAllOrdersByAdmin(Specification<Order> spec,
                                           Pageable page){
        return orderRepository.findAll(spec, page);
    }

    public Order getOrderById(long orderId){
        return orderRepository.findById(orderId).
                orElseThrow(() -> new BusinessException(ErrorCode.ORDER_NOT_FOUND));
    }

    public void updateOrder(long orderId, Order orderUpdate){
        Order order = getOrderById(orderId);
        order.setStatus(orderUpdate.getStatus());
        order.setUpdatedAt(Instant.now());

        orderRepository.save(order);
    }

}
