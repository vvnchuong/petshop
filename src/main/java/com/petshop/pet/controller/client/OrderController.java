package com.petshop.pet.controller.client;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.Cart;
import com.petshop.pet.domain.CartDetail;
import com.petshop.pet.domain.Order;
import com.petshop.pet.domain.User;
import com.petshop.pet.domain.dto.CheckoutRequestDTO;
import com.petshop.pet.enums.PaymentMethod;
import com.petshop.pet.enums.Status;
import com.petshop.pet.service.CartDetailService;
import com.petshop.pet.service.CartService;
import com.petshop.pet.service.OrderService;
import com.petshop.pet.service.UserService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
public class OrderController {

    private final OrderService orderService;

    private final UserService userService;

    private final CartService cartService;

    private final CartDetailService cartDetailService;

    public OrderController(OrderService orderService,
                           UserService userService,
                           CartService cartService,
                           CartDetailService cartDetailService){
        this.orderService = orderService;
        this.userService = userService;
        this.cartService = cartService;
        this.cartDetailService = cartDetailService;
    }

    @PostMapping("/checkout")
    public String placeOrder(@ModelAttribute CheckoutRequestDTO checkoutRequestDTO,
                             @AuthenticationPrincipal CustomUserDetails currentUser) {

        orderService.placeOrder(checkoutRequestDTO, currentUser);

        return "client/cart/thanks";
    }

    @GetMapping("/order/history")
    public String getOrderHistoryPage(Model model,
                                      @AuthenticationPrincipal CustomUserDetails currentUser){

        List<Order> orders = orderService.getAllOrderByUser(currentUser.getUsername());
        model.addAttribute("orders", orders);

        return "client/order/index";
    }

}
