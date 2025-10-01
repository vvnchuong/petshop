package com.petshop.pet.service;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.*;
import com.petshop.pet.domain.dto.CheckoutRequestDTO;
import com.petshop.pet.repository.CartRepository;
import com.petshop.pet.repository.OrderDetailRepository;
import com.petshop.pet.repository.OrderRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.List;

@Service
public class OrderService {

    private final OrderRepository orderRepository;

    private final OrderDetailRepository orderDetailRepository;

    private final CartRepository cartRepository;

    private final CartDetailService cartDetailService;

    private final UserService userService;

    public OrderService(OrderRepository orderRepository,
                        OrderDetailRepository orderDetailRepository,
                        CartRepository cartRepository,
                        CartDetailService cartDetailService,
                        UserService userService){
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
        this.cartRepository = cartRepository;
        this.cartDetailService = cartDetailService;
        this.userService = userService;
    }

    @Transactional
    public void placeOrder(CheckoutRequestDTO checkoutRequestDTO,
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
    }

    public List<Order> getAllOrderByUser(String username) {
        return orderRepository.findByUserUsername(username);
    }

    public Order getOrderByIdAndUser(long orderId, String username){
        return orderRepository.findByIdAndUserUsername(orderId, username);
    }

    public List<Order> getAllOrdersByAdmin(){
        return orderRepository.findAll();
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

}
