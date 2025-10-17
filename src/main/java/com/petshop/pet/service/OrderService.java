package com.petshop.pet.service;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.*;
import com.petshop.pet.domain.dto.CheckoutRequestDTO;
import com.petshop.pet.repository.CartRepository;
import com.petshop.pet.repository.OrderDetailRepository;
import com.petshop.pet.repository.OrderRepository;
import com.petshop.pet.repository.ProductRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class OrderService {

    private final OrderRepository orderRepository;

    private final OrderDetailRepository orderDetailRepository;

    private final CartRepository cartRepository;

    private final CartDetailService cartDetailService;

    private final UserService userService;

    private final ProductRepository productRepository;

    public OrderService(OrderRepository orderRepository,
                        OrderDetailRepository orderDetailRepository,
                        CartRepository cartRepository,
                        CartDetailService cartDetailService,
                        UserService userService,
                        ProductRepository productRepository){
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
        this.cartRepository = cartRepository;
        this.cartDetailService = cartDetailService;
        this.userService = userService;
        this.productRepository = productRepository;
    }

    @Transactional
    public Order placeOrder(CheckoutRequestDTO checkoutRequestDTO,
                           CustomUserDetails currentUser){

        Order order = new Order();
        order.setReceiverName(checkoutRequestDTO.getReceiverName());
        order.setReceiverPhone(checkoutRequestDTO.getReceiverPhone());
        order.setShippingAddress(checkoutRequestDTO.getReceiverAddress());
        order.setStatus(checkoutRequestDTO.getStatus());
        order.setPaymentMethod(checkoutRequestDTO.getPaymentMethod());
        order.setCreatedAt(Instant.now());

        List<CartDetail> cartDetails = cartDetailService.
                getAllProductsInCartByUser(currentUser.getUsername());

        List<Long> productIds = cartDetails.stream()
                .map(cd -> cd.getProduct().getId())
                .collect(Collectors.toList());

        List<Product> products = productRepository.findByIdIn(productIds);

        for(Product product : products){
            product.setStock(product.getStock() - 1);
            if(product.getStock() < 0)
                throw new RuntimeException("Stock must be greater than 0");

            productRepository.save(product);
        }

        double totalPrice = 0;
        for(CartDetail cartDetail : cartDetails){
            totalPrice += cartDetail.getQuantity() * cartDetail.getPrice();
        }
        order.setTotalAmount(totalPrice);

        User user = userService.getUserByUserName(currentUser.getUsername());
        order.setUser(user);

        orderRepository.save(order);

        for(CartDetail cartDetail : cartDetails){
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrder(order);
            orderDetail.setProduct(cartDetail.getProduct());
            orderDetail.setQuantity(cartDetail.getQuantity());
            orderDetail.setPrice(cartDetail.getPrice());
            orderDetailRepository.save(orderDetail);
        }

        Cart cart = cartRepository.findByUser(user);
        cart.setQuantity(0);
        cartRepository.save(cart);

        cartDetailService.deleteAllProductInCartByCartId(user.getCart());

        return order;
    }

    public List<Order> getAllOrderByUser(String username) {
        return orderRepository.findByUserUsername(username);
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
                orElseThrow(() -> new RuntimeException("Order not found"));
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
