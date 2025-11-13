package com.petshop.pet.service.impl;

import com.petshop.pet.domain.Order;
import com.petshop.pet.domain.dto.PaymentCallbackResponse;
import com.petshop.pet.domain.dto.PaymentInitiationResponse;
import com.petshop.pet.enums.ErrorCode;
import com.petshop.pet.exception.BusinessException;
import com.petshop.pet.service.PaymentService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class PaymentProcessingService {

    private final Map<String, PaymentService> paymentServices;

    public PaymentProcessingService(List<PaymentService> paymentServices){
        this.paymentServices = paymentServices.stream()
                .collect(Collectors.toMap(PaymentService::getProviderName, Function.identity()));
    }

    private PaymentService getPaymentService(String providerName){
        PaymentService paymentService = paymentServices.get(providerName.toUpperCase());
        if(paymentService == null)
            throw new BusinessException(ErrorCode.PAYMENT_METHOD_NOT_SUPPORTED);

        return paymentService;
    }

    public PaymentInitiationResponse initiatePayment(Order order){
        try {
            String providerName = order.getPaymentMethod().toString();
            PaymentService service = getPaymentService(providerName);
            return service.initiatePayment(order);
        } catch (BusinessException e) {
            throw new BusinessException(ErrorCode.PAYMENT_FAILED);
        }
    }

    public PaymentCallbackResponse handleCallback(String providerName,
                                                  Map<String, String> params,
                                                  HttpServletRequest request){
        PaymentService service = getPaymentService(providerName);
        return service.handlePaymentResponse(params, request);
    }

}
