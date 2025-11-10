package com.petshop.pet.service;

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
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
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

    public OrderService(OrderRepository orderRepository,
                        CartDetailService cartDetailService,
                        UserService userService,
                        VoucherService voucherService,
                        CartService cartService,
                        StockService stockService,
                        PricingService pricingService,
                        OrderDetailService orderDetailService){
        this.orderRepository = orderRepository;
        this.cartDetailService = cartDetailService;
        this.userService = userService;
        this.voucherService = voucherService;
        this.cartService = cartService;
        this.stockService = stockService;
        this.pricingService = pricingService;
        this.orderDetailService = orderDetailService;
    }

    @Transactional
    public Order createOrder(CheckoutRequestDTO dto, CustomUserDetails currentUser){
        User user = userService.getUserByUserName(currentUser.getUsername());
        List<CartDetail> cartDetails = cartDetailService.getAllProductsInCartByUser(currentUser.getUsername());

        Voucher voucher = voucherService.checkVoucher(dto.getVoucherCode());
        double finalPrice = pricingService.calculateFinalPrice(cartDetails, voucher);

        Order order = buildOrder(dto, user, finalPrice);
        String orderCode = generateOrderCode();
        order.setOrderCode(orderCode);
        if("COD".equalsIgnoreCase(dto.getPaymentMethod().toString())){
            stockService.reserveStock(cartDetails);
            orderRepository.save(order);

            orderDetailService.saveOrderDetails(order, cartDetails);
            cartDetailService.deleteAllProductInCartByCartId(user.getCart());
            cartService.resetCart(user);
        }else{
            order.setStatus(Status.FAILED);
            orderRepository.save(order);
        }

        return order;
    }

    @Transactional
    public void confirmOrderPayment(String username, long orderId, Map<String, String> fields){
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new BusinessException(ErrorCode.ORDER_NOT_FOUND));

        List<CartDetail> cartDetails = cartDetailService.getAllProductsInCartByUser(username);
        stockService.reserveStock(cartDetails);
        orderDetailService.saveOrderDetails(order, cartDetails);

        User user = userService.getUserByUserName(username);
        cartDetailService.deleteAllProductInCartByCartId(user.getCart());
        cartService.resetCart(user);

        String responseCode = fields.get("vnp_ResponseCode");
        String transactionNo = fields.get("vnp_TransactionNo");
        order.setResponseCode(responseCode);
        order.setTransactionCode(transactionNo);

        order.setStatus(Status.PENDING);
        orderRepository.save(order);
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

    private Instant getStartOfToday() {
        return LocalDate.now(ZoneId.of("Asia/Ho_Chi_Minh"))
                .atStartOfDay(ZoneId.of("Asia/Ho_Chi_Minh"))
                .toInstant();
    }

    public long countTotalOrders(){
        return orderRepository.count();
    }

    public long countOrdersToday(){
        return orderRepository.countByCreatedAtAfter(getStartOfToday());
    }

    public List<Order> findTop10RecentOrders(){
        return orderRepository.findTop10ByOrderByCreatedAtDesc();
    }

    public double getRevenueToday(){
        List<Order> ordersToday = orderRepository.findByCreatedAtAfter(getStartOfToday());
        return ordersToday.stream().mapToDouble(Order::getTotalAmount).sum();
    }

    public Map<LocalDate, Double> getRevenueDataForLast7Days(){
        Instant sevenDaysAgo = Instant.now().minus(7, ChronoUnit.DAYS);
        List<Order> recentOrders = orderRepository.findByCreatedAtAfter(sevenDaysAgo);

        Map<LocalDate, Double> revenueByDate = recentOrders.stream()
                .collect(Collectors.groupingBy(
                        order -> order.getCreatedAt().atZone(ZoneId.of("Asia/Ho_Chi_Minh")).toLocalDate(),
                        Collectors.summingDouble(Order::getTotalAmount)
                ));

        return revenueByDate.entrySet().stream()
                .sorted(Map.Entry.comparingByKey())
                .collect(Collectors.toMap(
                        Map.Entry::getKey, Map.Entry::getValue,
                        (oldValue, newValue) -> oldValue, LinkedHashMap::new
                ));
    }

}
