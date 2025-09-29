package com.petshop.pet.service;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.Cart;
import com.petshop.pet.domain.CartDetail;
import com.petshop.pet.domain.Order;
import com.petshop.pet.domain.User;
import com.petshop.pet.domain.dto.CheckoutRequestDTO;
import com.petshop.pet.enums.PaymentMethod;
import com.petshop.pet.enums.Status;
import com.petshop.pet.repository.CartRepository;
import com.petshop.pet.repository.OrderRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.List;

@Service
public class OrderService {

    private final OrderRepository orderRepository;

    private final CartRepository cartRepository;

    private final CartDetailService cartDetailService;

    private final UserService userService;

    public OrderService(OrderRepository orderRepository,
                        CartRepository cartRepository,
                        CartDetailService cartDetailService,
                        UserService userService){
        this.orderRepository = orderRepository;
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

        createOrderByUser(order);

        Cart cart = cartRepository.findByUser(user);
        cart.setQuantity(0);
        cartRepository.save(cart);

        cartDetailService.deleteAllProductInCartByCartId(user.getCart());
    }

    public void createOrderByUser(Order order) {
        orderRepository.save(order);
    }
}
