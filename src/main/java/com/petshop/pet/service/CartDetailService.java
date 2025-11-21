package com.petshop.pet.service;

import com.petshop.pet.domain.Cart;
import com.petshop.pet.domain.CartDetail;

import java.util.List;

public interface CartDetailService {

    List<CartDetail> getAllProductsInCartByUser(String username);

    void updateQuantity(Long id, Integer quantity);

    void deleteProductInCartDetail(String slug, String username);

    void deleteAllProductInCartByCartId(Cart cart);

}
