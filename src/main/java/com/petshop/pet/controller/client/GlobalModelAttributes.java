package com.petshop.pet.controller.client;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.User;
import com.petshop.pet.service.UserService;
import com.petshop.pet.service.impl.CartServiceImpl;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.security.Principal;
import java.util.Map;

@ControllerAdvice
public class GlobalModelAttributes {

    private final CartServiceImpl cartService;

    private final UserService userService;

    public GlobalModelAttributes(CartServiceImpl cartService,
                                 UserService userService){
        this.cartService = cartService;
        this.userService = userService;
    }

    @ModelAttribute("cartQuantity")
    public int addCartQuantityToModel(Principal principal, HttpSession session){
        if(principal != null){
            User user = userService.getUserByUserName(principal.getName());
            return cartService.getCartQuantity(user);
        }else{
            Map<String, Integer> sessionCart = (Map<String, Integer>) session.getAttribute("guestCart");
            if (sessionCart != null)
                return sessionCart.size();
        }
        return 0;
    }

    @ModelAttribute("user")
    public User addUserToModel(Authentication authentication){
        if(authentication != null && authentication.isAuthenticated()){
            CustomUserDetails currentUser = (CustomUserDetails) authentication.getPrincipal();
            return userService.getUserByUserName(currentUser.getUsername());
        }
        return null;
    }

}
