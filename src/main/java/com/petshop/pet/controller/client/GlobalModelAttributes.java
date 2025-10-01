package com.petshop.pet.controller.client;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.User;
import com.petshop.pet.service.CartService;
import com.petshop.pet.service.UserService;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.security.Principal;

@ControllerAdvice
public class GlobalModelAttributes {

    private final CartService cartService;

    private final UserService userService;

    public GlobalModelAttributes(CartService cartService,
                                 UserService userService){
        this.cartService = cartService;
        this.userService = userService;
    }

    @ModelAttribute("cartQuantity")
    public int addCartQuantityToModel(Principal principal) {
        if (principal != null) {
            User user = userService.getUserByUserName(principal.getName());
            return cartService.getCartQuantity(user);
        }
        return 0;
    }

    @ModelAttribute("user")
    public User addUserToModel(Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            CustomUserDetails currentUser = (CustomUserDetails) authentication.getPrincipal();
            return userService.getUserByUserName(currentUser.getUsername());
        }
        return null;
    }

}
