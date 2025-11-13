package com.petshop.pet.controller.payment;

import com.petshop.pet.domain.dto.PaymentCallbackResponse;
import com.petshop.pet.service.impl.PaymentProcessingService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
@RequestMapping("/payment/callback")
public class PaymentController {

    private final PaymentProcessingService paymentProcessingService;

    public PaymentController(PaymentProcessingService paymentProcessingService){
        this.paymentProcessingService = paymentProcessingService;
    }

    @GetMapping("/{provider}")
    public String handlePaymentCallback(@PathVariable String provider,
                                        @RequestParam Map<String, String> allParams,
                                        HttpServletRequest request,
                                        Model model){

        PaymentCallbackResponse callbackResponse =
                paymentProcessingService.handleCallback(provider, allParams, request);

        if(callbackResponse.isSuccess()) {
            model.addAttribute("orderId", callbackResponse.getOrderId());
            return "client/cart/thanks";
        }else{
//            model.addAttribute("error", callbackResponse.getMessage());
            return "redirect:/cart";
        }
    }
}