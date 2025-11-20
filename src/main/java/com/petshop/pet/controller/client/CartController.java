package com.petshop.pet.controller.client;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.User;
import com.petshop.pet.domain.dto.CartDataDTO;
import com.petshop.pet.service.UserService;
import com.petshop.pet.service.impl.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/cart")
public class CartController {

    private final CartService cartService;

    private final UserService userService;

    private final CartDetailService cartDetailService;

    private final CartFacadeService cartFacadeService;

    public CartController(CartService cartService,
                          UserService userService,
                          CartDetailService cartDetailService,
                          CartFacadeService cartFacadeService){
        this.cartService = cartService;
        this.userService = userService;
        this.cartDetailService = cartDetailService;
        this.cartFacadeService = cartFacadeService;
    }

    @PostMapping("/{productSlug}")
    @ResponseBody
    public Map<String, Object> addProductToCart(@PathVariable("productSlug") String slug,
                                                @AuthenticationPrincipal CustomUserDetails currentUser,
                                                @RequestParam("quantity") Integer quantity,
                                                HttpSession session){

        Map<String, Object> response = new HashMap<>();

        if(currentUser != null){
            cartService.addProductToCart(currentUser.getUsername(), slug, quantity);
            User user = userService.getUserByUserName(currentUser.getUsername());
            response.put("cartQuantity", cartService.getCartQuantity(user));
        }else{
            cartFacadeService.addGuestProduct(slug, quantity, session);
            Map<String, Integer> guestCart = (Map<String, Integer>) session.getAttribute("guestCart");

            response.put("cartQuantity", guestCart != null ? guestCart.size() : 0);
        }

        response.put("message", "Added to cart");

        return response;
    }

    @GetMapping
    public String getCartPage(Model model,
                              @AuthenticationPrincipal CustomUserDetails currentUser,
                              HttpSession session){

        CartDataDTO cartDataDTO = cartFacadeService.getCart(currentUser, session);

        model.addAttribute("cartDetails", cartDataDTO.getCartDetails());
        model.addAttribute("totalPrice", cartDataDTO.getTotal());

        return "client/cart/index";
    }

    @PostMapping("/update")
    @ResponseBody
    public void updateCart(@RequestParam(value = "id", required = false) Long cardDetailId,
                           @RequestParam(value = "slug", required = false) String slug,
                           @RequestParam("quantity") Integer quantity,
                           @AuthenticationPrincipal CustomUserDetails currentUser,
                           HttpSession session){

        if(currentUser != null) {
            cartDetailService.updateQuantity(cardDetailId, quantity);
        }else{
            cartFacadeService.updateGuestCart(slug, quantity, session);
        }

    }

    @PostMapping("/delete/{productSlug}")
    @ResponseBody
    public void deleteProduct(@PathVariable("productSlug") String slug,
                              @AuthenticationPrincipal CustomUserDetails currentUser,
                              HttpSession session){

        if(currentUser != null){
            cartDetailService.deleteProductInCartDetail(slug, currentUser.getUsername());
        }else{
            cartFacadeService.deleteGuestProduct(slug, session);
        }
    }

}
