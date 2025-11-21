package com.petshop.pet.service.impl;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.CartDetail;
import com.petshop.pet.domain.Product;
import com.petshop.pet.domain.User;
import com.petshop.pet.domain.dto.CartDataDTO;
import com.petshop.pet.service.CartDetailService;
import com.petshop.pet.service.ProductService;
import com.petshop.pet.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CartFacadeService {

    private final CartDetailService cartDetailService;

    private final ProductService productService;

    private final UserService userService;

    public CartFacadeService(CartDetailService cartDetailService,
                             ProductService productService,
                             UserService userService){
        this.cartDetailService = cartDetailService;
        this.productService = productService;
        this.userService = userService;
    }

    public CartDataDTO getCart(CustomUserDetails currentUser, HttpSession session){

        List<CartDetail> details;
        User user = null;

        if(currentUser != null){
            user = userService.getUserByUserName(currentUser.getUsername());
            details = cartDetailService.getAllProductsInCartByUser(currentUser.getUsername());
        }else{
            details = buildGuestCart(session);
        }

        double total = details.stream()
                .mapToDouble(d -> d.getPrice() * d.getQuantity())
                .sum();

        return CartDataDTO.builder()
                .cartDetails(details)
                .total(total)
                .user(user)
                .build();
    }

    private List<CartDetail> buildGuestCart(HttpSession session){
        Map<String, Integer> guestCart = (Map<String, Integer>) session.getAttribute("guestCart");
        if (guestCart == null) return new ArrayList<>();

        List<CartDetail> list = new ArrayList<>();
        for(var entry : guestCart.entrySet()){
            Product p = productService.getProductBySlug(entry.getKey());
            CartDetail cd = new CartDetail();
            cd.setProduct(p);
            cd.setPrice(p.getPrice());
            cd.setQuantity(entry.getValue());
            list.add(cd);
        }
        return list;
    }

    public void addGuestProduct(String slug, int quantity, HttpSession session){
        Map<String, Integer> guestCart = (Map<String, Integer>) session.getAttribute("guestCart");

        if (guestCart == null)
            guestCart = new HashMap<>();

        guestCart.put(slug, guestCart.getOrDefault(slug, 0) + quantity);
        session.setAttribute("guestCart", guestCart);
    }

    public void updateGuestCart(String slug, int quantity, HttpSession session){
        Map<String, Integer> guestCart =
                (Map<String, Integer>) session.getAttribute("guestCart");
        if(guestCart == null)
            return;

        guestCart.put(slug, quantity);
        session.setAttribute("guestCart", guestCart);
    }

    public void deleteGuestProduct(String slug, HttpSession session){
        Map<String, Integer> guestCart =
                (Map<String, Integer>) session.getAttribute("guestCart");

        if (guestCart != null){
            guestCart.remove(slug);
            session.setAttribute("guestCart", guestCart);
        }
    }


}
