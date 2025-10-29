package com.petshop.pet.controller.client;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.CartDetail;
import com.petshop.pet.domain.Order;
import com.petshop.pet.domain.User;
import com.petshop.pet.domain.Voucher;
import com.petshop.pet.domain.dto.CheckoutRequestDTO;

import com.petshop.pet.service.CartDetailService;
import com.petshop.pet.service.OrderService;
import com.petshop.pet.service.UserService;
import com.petshop.pet.service.VoucherService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.Instant;
import java.util.List;
import java.util.Map;

@Controller
public class OrderController {

    private final OrderService orderService;

    private final UserService userService;

    private final VoucherService voucherService;

    private final CartDetailService cartDetailService;

    public OrderController(OrderService orderService,
                           UserService userService,
                           VoucherService voucherService,
                           CartDetailService cartDetailService){
        this.orderService = orderService;
        this.userService = userService;
        this.voucherService = voucherService;
        this.cartDetailService = cartDetailService;
    }

    @GetMapping("/checkout")
    public String getCheckoutPage(Model model,
                                  @AuthenticationPrincipal CustomUserDetails currentUser){

        List<CartDetail> cartDetails = cartDetailService.
                getAllProductsInCartByUser(currentUser.getUsername());

        double totalPrice = 0;
        for(CartDetail cartDetail : cartDetails){
            totalPrice += cartDetail.getQuantity() * cartDetail.getPrice();
        }

        User user = userService.getUserByUserName(currentUser.getUsername());

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("currentUser", user);
        return "client/cart/checkout";
    }

    @PostMapping("/checkout")
    public String placeOrder(@ModelAttribute CheckoutRequestDTO checkoutRequestDTO,
                             @AuthenticationPrincipal CustomUserDetails currentUser,
                             Model model) {

        Order order = orderService.placeOrder(checkoutRequestDTO, currentUser);

        model.addAttribute("orderId", order.getId());

        return "client/cart/thanks";
    }

    @GetMapping("/order/history")
    public String getOrderHistoryPage(Model model,
                                      @AuthenticationPrincipal CustomUserDetails currentUser){

        List<Order> orders = orderService.getAllOrderByUser(currentUser.getUsername());
        model.addAttribute("orders", orders);

        return "client/order/index";
    }

    @GetMapping("/order/detail/{id}")
    public String getOrderDetailPage(Model model,
                                     @PathVariable("id") long orderId,
                                     @AuthenticationPrincipal CustomUserDetails currentUser){

        Order order = orderService.getOrderByIdAndUser(orderId, currentUser.getUsername());

        model.addAttribute("order", order);
        return "client/order/detail";
    }

    @PostMapping("/apply")
    public ResponseEntity<?> applyVoucher(
            @RequestParam String code,
            @AuthenticationPrincipal CustomUserDetails currentUser) {

        List<CartDetail> cartDetails =
                cartDetailService.getAllProductsInCartByUser(currentUser.getUsername());

        double total = cartDetails.stream()
                .mapToDouble(cd -> cd.getQuantity() * cd.getPrice())
                .sum();

        Voucher voucher = voucherService.getVoucherByCode(code);
        if(voucher == null){
            return ResponseEntity.badRequest().body(Map.of("error", "Voucher không tồn tại"));
        }else if(!voucher.isActive()){
            return ResponseEntity.badRequest().body(Map.of("error", "Voucher không tồn tại"));
        }else if(voucher.getUsedCount() >= voucher.getMaxUsage()){
            return ResponseEntity.badRequest().body(Map.of("error", "Số lượng sử dụng đã đạt giới hạn"));
        }else if(voucher.getMinOrder() > total){
            return ResponseEntity.badRequest().body(Map.of("error", "Giá trị đơn hàng phải lơn hơn "+ total));
        }else if(voucher.getEndDate().isBefore(Instant.now())){
            return ResponseEntity.badRequest().body(Map.of("error", "Voucher đã hết hạn"));
        }

        double discount;
        if (voucher.getDiscountAmount() != null) {
            discount = voucher.getDiscountAmount();
        } else {
            discount = total * voucher.getDiscountPercent() * 0.01;
        }

        double finalPrice = total - discount;
        if (finalPrice < 0) finalPrice = 0;

        return ResponseEntity.ok(Map.of(
                "discount", discount,
                "finalPrice", finalPrice
        ));
    }

}
