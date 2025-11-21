package com.petshop.pet.service;

import com.petshop.pet.domain.User;

public interface CartService {

    void addProductToCart(String username, String productSlug, Integer quantity);

    int getCartQuantity(User user);

    void resetCart(User user);

}
