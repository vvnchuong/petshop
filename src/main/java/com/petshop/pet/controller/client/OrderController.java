package com.petshop.pet.controller.client;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.*;
import com.petshop.pet.domain.dto.*;

import com.petshop.pet.service.impl.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class OrderController {

    private final OrderService orderService;

    private final CartFacadeService cartFacadeService;

    private final CheckoutService checkoutService;

    private final VoucherApplicationService voucherApplicationService;

    public OrderController(OrderService orderService,
                           CartFacadeService cartFacadeService,
                           VoucherApplicationService voucherApplicationService,
                           CheckoutService checkoutService){
        this.orderService = orderService;
        this.cartFacadeService = cartFacadeService;
        this.voucherApplicationService = voucherApplicationService;
        this.checkoutService = checkoutService;
    }

    @GetMapping("/checkout")
    public String getCheckoutPage(Model model,
                                  @AuthenticationPrincipal CustomUserDetails currentUser,
                                  HttpSession session){

        CartDataDTO cartDataDTO = cartFacadeService.getCart(currentUser, session);

        model.addAttribute("cartDetails", cartDataDTO.getCartDetails());
        model.addAttribute("totalPrice", cartDataDTO.getTotal());
        model.addAttribute("currentUser", cartDataDTO.getUser());

        return "client/cart/checkout";
    }

    @PostMapping("/checkout")
    public String placeOrder(@ModelAttribute CheckoutRequestDTO checkoutRequestDTO,
                             @AuthenticationPrincipal CustomUserDetails currentUser,
                             HttpSession session){

        OrderCreationResultDTO orderCreationResultDTO = checkoutService
                .createOrderAndInitPayment(checkoutRequestDTO, currentUser, session);

        session.setAttribute("orderCode", orderCreationResultDTO.getOrderCode());

        return "redirect:" + orderCreationResultDTO.getRedirectUrl();
    }

    @GetMapping("/thanks")
    public String getThanksPage(HttpSession session, Model model){
        String orderCode = (String) session.getAttribute("orderCode");
        model.addAttribute("orderCode", orderCode);

        session.removeAttribute("orderCode");
        return "client/cart/thanks";
    }

    @GetMapping("/orders/history")
    public String getOrderHistoryPage(Model model,
                                      @AuthenticationPrincipal CustomUserDetails currentUser){

        List<Order> orders = orderService.getAllOrderByUser(currentUser.getUsername());
        model.addAttribute("orders", orders);

        return "client/order/index";
    }

    @GetMapping("/orders/detail/{orderCode}")
    public String getOrderDetailPage(Model model,
                                     @PathVariable("orderCode") String orderCode,
                                     @AuthenticationPrincipal CustomUserDetails currentUser,
                                     HttpSession session){

        OrderDetailViewDTO orderDetailViewDTO = orderService
                .getOrderDetail(orderCode, currentUser, session);

        model.addAttribute("totalPrice", orderDetailViewDTO.getTotalPrice());
        model.addAttribute("order", orderDetailViewDTO.getOrder());

        return "client/order/detail";
    }

    @PostMapping("/apply")
    public ResponseEntity<?> applyVoucher(
            @RequestParam String code,
            @AuthenticationPrincipal CustomUserDetails currentUser,
            HttpSession session) {

        VoucherResultDTO result = voucherApplicationService.applyVoucher(code, currentUser, session);

        return result.isSuccess()
                ? ResponseEntity.ok(Map.of("discount", result.getDiscount(),
                "finalPrice", result.getFinalPrice()))
                : ResponseEntity.badRequest().body(Map.of("error", result.getMessage()));
    }

}
