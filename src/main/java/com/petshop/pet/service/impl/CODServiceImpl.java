package com.petshop.pet.service.impl;

import com.petshop.pet.domain.Order;
import com.petshop.pet.domain.dto.PaymentCallbackResponse;
import com.petshop.pet.domain.dto.PaymentInitiationResponse;
import com.petshop.pet.service.PaymentService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
class CODServiceImpl implements PaymentService {

    private final OrderService orderService;

    public CODServiceImpl(OrderService orderService){
        this.orderService = orderService;
    }

    @Override
    public String getProviderName() {
        return "COD";
    }

    @Override
    public PaymentInitiationResponse initiatePayment(Order order) {
        orderService.confirmOrderPayment(order.getId(), null, order.getSessionId());

        String redirectUrl = "/thanks";
        return new PaymentInitiationResponse(redirectUrl);
    }

    @Override
    public PaymentCallbackResponse handlePaymentResponse(Map<String, String> params, HttpServletRequest request) {
        Long orderId = Long.parseLong(params.getOrDefault("orderId", "0"));
        return new PaymentCallbackResponse(orderId, true, "Thanh toán thành công");
    }
}
