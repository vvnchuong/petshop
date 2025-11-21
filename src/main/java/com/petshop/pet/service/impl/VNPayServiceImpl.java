package com.petshop.pet.service.impl;

import com.petshop.pet.config.VNPayConfig;
import com.petshop.pet.domain.Order;
import com.petshop.pet.domain.dto.PaymentCallbackResponse;
import com.petshop.pet.domain.dto.PaymentInitiationResponse;
import com.petshop.pet.service.PaymentService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Service;

import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class VNPayServiceImpl implements PaymentService {

    private final OrderService orderService;

    public VNPayServiceImpl(OrderService orderService){
        this.orderService = orderService;;
    }

    @Override
    public String getProviderName() {
        return "VNPAY";
    }

    @Override
    public PaymentInitiationResponse initiatePayment(Order order) {

        Map<String, String> vnp_Params = new HashMap<>();

        vnp_Params.put("vnp_Version", "2.1.0");
        vnp_Params.put("vnp_Command", "pay");
        vnp_Params.put("vnp_TmnCode", VNPayConfig.vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf((long)(order.getTotalAmount() * 100)));
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_TxnRef", VNPayConfig.getRandomNumber(8));
        vnp_Params.put("vnp_OrderInfo", "Thanh toán đơn hàng #" + order.getId());
        vnp_Params.put("vnp_OrderType", "billpayment");
        vnp_Params.put("vnp_Locale", "vn");
        vnp_Params.put("vnp_ReturnUrl", VNPayConfig.vnp_ReturnUrl + "?orderId=" + order.getId());
        vnp_Params.put("vnp_IpAddr", "127.0.0.1");

        String vnp_CreateDate = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

        Calendar expire = Calendar.getInstance();
        expire.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = new SimpleDateFormat("yyyyMMddHHmmss").format(expire.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);

        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();

        for (String fieldName : fieldNames) {
            String fieldValue = vnp_Params.get(fieldName);
            if (fieldValue != null && !fieldValue.isEmpty()) {
                if (!hashData.isEmpty()) {
                    hashData.append('&');
                }

                hashData.append(fieldName).append('=')
                        .append(java.net.URLEncoder.encode(fieldValue, StandardCharsets.UTF_8));

                if (!query.isEmpty()) {
                    query.append('&');
                }
                query.append(fieldName).append('=')
                        .append(java.net.URLEncoder.encode(fieldValue, StandardCharsets.UTF_8));
            }
        }

        String vnp_SecureHash = VNPayConfig.hmacSHA512(VNPayConfig.secretKey, hashData.toString());
        query.append("&vnp_SecureHash=").append(vnp_SecureHash);
        String paymentUrl = VNPayConfig.vnp_PayUrl + "?" + query.toString();

        return new PaymentInitiationResponse(paymentUrl);
    }

    @Override
    public PaymentCallbackResponse handlePaymentResponse(Map<String, String> params, HttpServletRequest request) {
        boolean valid = VNPayConfig.validateSignature(params);
        Long orderId = Long.parseLong(params.getOrDefault("orderId", "0"));

        if(!(valid && "00".equals(params.get("vnp_ResponseCode")))){
            orderService.failOrderPayment(orderId);
            return new PaymentCallbackResponse(orderId, false, "Thanh toán thất bại");
        }

        String sessionId = request.getSession().getId();
        orderService.confirmOrderPayment(orderId, params, sessionId);

        return new PaymentCallbackResponse(orderId, true, "Thanh toán thành công");
    }
}