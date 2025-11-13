package com.petshop.pet.controller.client;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.CartDetail;
import com.petshop.pet.domain.Product;
import com.petshop.pet.domain.User;
import com.petshop.pet.service.impl.CartDetailService;
import com.petshop.pet.service.impl.CartService;
import com.petshop.pet.service.impl.ProductService;
import com.petshop.pet.service.impl.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/cart")
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

    @PostMapping("/{productSlug}")
    @ResponseBody
    public Map<String, Object> addProductToCart(@PathVariable("productSlug") String slug,
                                                @AuthenticationPrincipal CustomUserDetails currentUser,
                                                @RequestParam("quantity") Integer quantity,
                                                HttpSession session){

        Map<String, Object> response = new HashMap<>();

        if (currentUser != null) {
            cartService.addProductToCart(currentUser.getUsername(), slug, quantity);
            User user = userService.getUserByUserName(currentUser.getUsername());
            int cartQuantity = cartService.getCartQuantity(user);
            response.put("cartQuantity", cartQuantity);
        }else{
            Map<String, Integer> sessionCart = (Map<String, Integer>) session.getAttribute("guestCart");
            if(sessionCart == null)
                sessionCart = new HashMap<>();

            sessionCart.put(slug, sessionCart.getOrDefault(slug, 0) + quantity);
            session.setAttribute("guestCart", sessionCart);

            int totalQuantity = sessionCart.size();
            response.put("cartQuantity", totalQuantity);
        }

        response.put("message", "Added to cart");
        return response;
    }

    @GetMapping
    public String getCartPage(Model model,
                              @AuthenticationPrincipal CustomUserDetails currentUser,
                              HttpSession session){

        List<CartDetail> cartDetails;
        double totalPrice = 0;

        if(currentUser != null){
            cartDetails = cartDetailService.getAllProductsInCartByUser(currentUser.getUsername());
        }else{
            Map<String, Integer> sessionCart = (Map<String, Integer>) session.getAttribute("guestCart");
            cartDetails = new ArrayList<>();
            if(sessionCart != null){
                for (Map.Entry<String, Integer> entry : sessionCart.entrySet()) {
                    Product product = productService.getProductBySlug(entry.getKey());
                    CartDetail temp = new CartDetail();
                    temp.setProduct(product);
                    temp.setPrice(product.getPrice());
                    temp.setQuantity(entry.getValue());
                    cartDetails.add(temp);
                }
            }
        }

        for(CartDetail c : cartDetails){
            totalPrice += c.getPrice() * c.getQuantity();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
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
            Map<String, Integer> sessionCart = (Map<String, Integer>) session.getAttribute("guestCart");
            sessionCart.put(slug, quantity);
            session.setAttribute("guestCart", sessionCart);
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
            Map<String, Integer> sessionCart = (Map<String, Integer>) session.getAttribute("guestCart");
            sessionCart.remove(slug);
            session.setAttribute("guestCart", sessionCart);
        }
    }

}
