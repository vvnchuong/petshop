package com.petshop.pet.controller.client;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.*;
import com.petshop.pet.domain.dto.CheckoutRequestDTO;

import com.petshop.pet.domain.dto.PaymentInitiationResponse;
import com.petshop.pet.service.impl.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class OrderController {

    private final OrderService orderService;

    private final OrderDetailService orderDetailService;

    private final UserService userService;

    private final VoucherService voucherService;

    private final CartDetailService cartDetailService;

    private final ProductService productService;

    private final PaymentProcessingService paymentProcessingService;

    public OrderController(OrderService orderService,
                           OrderDetailService orderDetailService,
                           UserService userService,
                           VoucherService voucherService,
                           CartDetailService cartDetailService,
                           ProductService productService,
                           PaymentProcessingService paymentProcessingService){
        this.orderService = orderService;
        this.orderDetailService = orderDetailService;
        this.userService = userService;
        this.voucherService = voucherService;
        this.cartDetailService = cartDetailService;
        this.productService = productService;
        this.paymentProcessingService = paymentProcessingService;
    }

    @GetMapping("/checkout")
    public String getCheckoutPage(Model model,
                                  @AuthenticationPrincipal CustomUserDetails currentUser,
                                  HttpSession session){

        List<CartDetail> cartDetails;
        double totalPrice = 0;
        User user = null;
        if(currentUser != null){
            cartDetails = cartDetailService.
                    getAllProductsInCartByUser(currentUser.getUsername());

            user = userService.getUserByUserName(currentUser.getUsername());
        }else{
            Map<String, Integer> guestCart = (Map<String, Integer>) session.getAttribute("guestCart");
            cartDetails = new ArrayList<>();
            if (guestCart != null) {
                for (Map.Entry<String, Integer> entry : guestCart.entrySet()) {
                    Product product = productService.getProductBySlug(entry.getKey());
                    CartDetail temp = new CartDetail();
                    temp.setProduct(product);
                    temp.setPrice(product.getPrice());
                    temp.setQuantity(entry.getValue());
                    cartDetails.add(temp);
                }
            }
        }

        for(CartDetail cartDetail : cartDetails){
            totalPrice += cartDetail.getQuantity() * cartDetail.getPrice();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("currentUser", user);
        return "client/cart/checkout";
    }

    @PostMapping("/checkout")
    public String placeOrder(@ModelAttribute CheckoutRequestDTO checkoutRequestDTO,
                             @AuthenticationPrincipal CustomUserDetails currentUser,
                             HttpSession session){

        Map<String, Integer> guestCart = (Map<String, Integer>) session.getAttribute("guestCart");
        String sessionId = session.getId();

        Order order = orderService.createOrder(checkoutRequestDTO, currentUser, guestCart, sessionId);

        if(currentUser == null)
            session.removeAttribute("guestCart");

        PaymentInitiationResponse paymentResponse = paymentProcessingService.initiatePayment(order);

        session.setAttribute("orderId", order.getId());

        return "redirect:" + paymentResponse.getRedirectUrl();
    }

    @GetMapping("/thanks")
    public String getThanksPage(HttpSession session, Model model){
        Long orderId = (Long) session.getAttribute("orderId");
        model.addAttribute("orderId", orderId);

        session.removeAttribute("orderId");
        return "client/cart/thanks";
    }

    @GetMapping("/orders/history")
    public String getOrderHistoryPage(Model model,
                                      @AuthenticationPrincipal CustomUserDetails currentUser){

        List<Order> orders = orderService.getAllOrderByUser(currentUser.getUsername());
        model.addAttribute("orders", orders);

        return "client/order/index";
    }

    @GetMapping("/orders/detail/{id}")
    public String getOrderDetailPage(Model model,
                                     @PathVariable("id") long orderId,
                                     @AuthenticationPrincipal CustomUserDetails currentUser,
                                     HttpSession session){

        Order order;
        if(currentUser != null){
            order = orderService.getOrderByIdAndUser(orderId, currentUser.getUsername());
        }else{
            order = orderService.getOrderByGuess(orderId, session.getId());
        }

        List<OrderDetail> orderDetails = orderDetailService.getAllByOrder(order);
        double totalPrice = 0;
        for(OrderDetail orderDetail : orderDetails){
            totalPrice += orderDetail.getPrice() * orderDetail.getQuantity();
        }

        totalPrice = totalPrice != 0 ? totalPrice : order.getTotalAmount();

        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("order", order);
        return "client/order/detail";
    }

    @PostMapping("/apply")
    public ResponseEntity<?> applyVoucher(
            @RequestParam String code,
            @AuthenticationPrincipal CustomUserDetails currentUser,
            HttpSession session) {

        List<CartDetail> cartDetails;

        if(currentUser != null){
            cartDetails = cartDetailService.getAllProductsInCartByUser(currentUser.getUsername());

        }else{
            Map<String, Integer> guestCart = (Map<String, Integer>) session.getAttribute("guestCart");
            cartDetails = new ArrayList<>();
            if (guestCart != null) {
                for (Map.Entry<String, Integer> entry : guestCart.entrySet()) {
                    Product product = productService.getProductBySlug(entry.getKey());
                    CartDetail temp = new CartDetail();
                    temp.setProduct(product);
                    temp.setPrice(product.getPrice());
                    temp.setQuantity(entry.getValue());
                    cartDetails.add(temp);
                }
            }
        }

        double total = cartDetails.stream()
                .mapToDouble(cd -> cd.getQuantity() * cd.getPrice()).sum();

        Voucher voucher = voucherService.getVoucherByCode(code);
        if(voucher == null){
            return ResponseEntity.badRequest().body(Map.of("error", "Voucher không tồn tại"));
        }else if(!voucher.isActive()){
            return ResponseEntity.badRequest().body(Map.of("error", "Voucher không tồn tại"));
        }else if(voucher.getUsedCount() >= voucher.getMaxUsage()){
            return ResponseEntity.badRequest().body(Map.of("error", "Số lượng sử dụng đã đạt giới hạn"));
        }else if(voucher.getMinOrder() > total){
            return ResponseEntity.badRequest().body(Map.of("error", "Giá trị đơn hàng phải lơn hơn "+
                    voucher.getMinOrder()));
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
