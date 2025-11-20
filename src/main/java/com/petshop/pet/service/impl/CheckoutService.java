package com.petshop.pet.service.impl;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.Order;
import com.petshop.pet.domain.dto.CheckoutRequestDTO;
import com.petshop.pet.domain.dto.OrderCreationResultDTO;
import com.petshop.pet.domain.dto.PaymentInitiationResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class CheckoutService {

    private final OrderService orderService;
    private final PaymentProcessingService paymentProcessingService;

    public CheckoutService(OrderService orderService,
                           PaymentProcessingService paymentProcessingService){
        this.orderService = orderService;
        this.paymentProcessingService = paymentProcessingService;
    }

    public OrderCreationResultDTO createOrderAndInitPayment(CheckoutRequestDTO request,
                                                            CustomUserDetails currentUser,
                                                            HttpSession session) {

        Map<String, Integer> guestCart = (Map<String, Integer>) session.getAttribute("guestCart");

        Order order = orderService.createOrder(request, currentUser, guestCart, session.getId());

        if(currentUser == null)
            session.removeAttribute("guestCart");

        PaymentInitiationResponse payment = paymentProcessingService.initiatePayment(order);

        return new OrderCreationResultDTO(order.getOrderCode(), payment.getRedirectUrl());
    }

}
