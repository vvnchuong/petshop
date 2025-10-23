package com.petshop.pet.controller.client;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.Cart;
import com.petshop.pet.domain.CartDetail;
import com.petshop.pet.domain.Product;
import com.petshop.pet.domain.User;
import com.petshop.pet.service.CartDetailService;
import com.petshop.pet.service.CartService;
import com.petshop.pet.service.ProductService;
import com.petshop.pet.service.UserService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CartController {

    private final CartService cartService;

    private final ProductService productService;

    private final UserService userService;

    private final CartDetailService cartDetailService;

    public CartController(CartService cartService,
                          ProductService productService,
                          UserService userService,
                          CartDetailService cartDetailService){
        this.cartService = cartService;
        this.productService = productService;
        this.userService = userService;
        this.cartDetailService = cartDetailService;
    }

    @PostMapping("/cart/{productSlug}")
    @ResponseBody
    public Map<String, Object> addProductToCart(@PathVariable("productSlug") String slug,
                                                @AuthenticationPrincipal CustomUserDetails currentUser,
                                                @RequestParam("quantity") Integer quantity){

        cartService.addProductToCart(currentUser.getUsername(), slug, quantity);

        User user = userService.getUserByUserName(currentUser.getUsername());
        int cartQuantity = cartService.getCartQuantity(user);

        Product product = productService.getProductBySlug(slug);

        Map<String, Object> response = new HashMap<>();
        response.put("message", "Added to cart");
        response.put("cartQuantity", cartQuantity);

        return response;
    }

    @GetMapping("/cart")
    public String getCartPage(Model model,
                              @AuthenticationPrincipal CustomUserDetails currentUser){

        List<CartDetail> cartDetails = cartDetailService.
                getAllProductsInCartByUser(currentUser.getUsername());

        double totalPrice = 0;
        for(CartDetail cartDetail : cartDetails){
            totalPrice += cartDetail.getQuantity() * cartDetail.getPrice();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);

        return "client/cart/index";
    }

    @PostMapping("/cart/update")
    @ResponseBody
    public void updateCart(@RequestParam("id") Long cardDetailId,
                           @RequestParam("quantity") Integer quantity){
        cartDetailService.updateQuantity(cardDetailId, quantity);
    }

    @PostMapping("/cart/delete/{productSlug}")
    @ResponseBody
    public void deleteProduct(@PathVariable("productSlug") String slug,
                              @AuthenticationPrincipal CustomUserDetails currentUser){

        cartDetailService.deleteProductInCartDetail(slug, currentUser.getUsername());
    }

}
