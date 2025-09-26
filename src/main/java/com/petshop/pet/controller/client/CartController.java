package com.petshop.pet.controller.client;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.Product;
import com.petshop.pet.domain.User;
import com.petshop.pet.service.CartService;
import com.petshop.pet.service.ProductService;
import com.petshop.pet.service.UserService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
public class CartController {

    private final CartService cartService;

    private final ProductService productService;

    private final UserService userService;

    public CartController(CartService cartService,
                          ProductService productService,
                          UserService userService){
        this.cartService = cartService;
        this.productService = productService;
        this.userService = userService;
    }

    @PostMapping("/cart/{productSlug}")
    @ResponseBody
    public Map<String, Object> addProductToCart(@PathVariable("productSlug") String slug,
                                                @AuthenticationPrincipal CustomUserDetails currentUser){

        cartService.addProductToCart(currentUser.getUsername(), slug);

        User user = userService.getUserByUserName(currentUser.getUsername());
        int cartQuantity = cartService.getCartQuantity(user);

        Product product = productService.getProductNameBySlug(slug);

        Map<String, Object> response = new HashMap<>();
        response.put("message", "Added to cart");
        response.put("cartQuantity", cartQuantity);

        return response;
    }

}
