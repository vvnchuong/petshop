package com.petshop.pet.controller.payments;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.service.OrderService;
import com.petshop.pet.config.VNPayConfig;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/vnpay")
public class VNPayController {

    private final OrderService orderService;

    public VNPayController(OrderService orderService){
        this.orderService = orderService;
    }

    @GetMapping("/create")
    public void createPayment(@RequestParam("orderId") Long orderId,
                              @RequestParam("amount") double amount,
                              HttpServletResponse response) throws IOException {

        String orderType = "billpayment";
        String vnp_Amount = String.valueOf((long)(amount * 100));
        String vnp_TxnRef = VNPayConfig.getRandomNumber(8);
        String vnp_IpAddr = "127.0.0.1";
        String vnp_TmnCode = VNPayConfig.vnp_TmnCode;

        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", "2.1.0");
        vnp_Params.put("vnp_Command", "pay");
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", vnp_Amount);
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", "Thanh toán đơn hàng #" + orderId);
        vnp_Params.put("vnp_OrderType", orderType);
        vnp_Params.put("vnp_Locale", "vn");
        vnp_Params.put("vnp_ReturnUrl", VNPayConfig.vnp_ReturnUrl + "?orderId=" + orderId);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

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

        response.sendRedirect(paymentUrl);
    }

    @GetMapping("/return")
    public String vnpayReturn(@RequestParam Map<String, String> allParams,
                              @AuthenticationPrincipal CustomUserDetails currentUser,
                              @RequestParam("orderId") Long orderId,
                              Model model) {
        boolean valid = VNPayConfig.validateSignature(allParams);

        if (!(valid && "00".equals(allParams.get("vnp_ResponseCode")))) {
            return "redirect:/cart";
        }

        orderService.confirmOrderPayment(currentUser.getUsername(), orderId, allParams);
        model.addAttribute("orderId", orderId);
        return "client/cart/thanks";

    }
}
