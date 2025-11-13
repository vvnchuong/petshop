package com.petshop.pet.service;

import com.petshop.pet.domain.Order;
import com.petshop.pet.domain.dto.PaymentCallbackResponse;
import com.petshop.pet.domain.dto.PaymentInitiationResponse;
import jakarta.servlet.http.HttpServletRequest;

import java.util.Map;

public interface PaymentService {

    String getProviderName();

    PaymentInitiationResponse initiatePayment(Order order);

    PaymentCallbackResponse handlePaymentResponse(Map<String, String> params, HttpServletRequest request);

}
