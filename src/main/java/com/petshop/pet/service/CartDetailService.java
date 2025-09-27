package com.petshop.pet.service;

import com.petshop.pet.domain.Cart;
import com.petshop.pet.domain.CartDetail;
import com.petshop.pet.repository.CartDetailRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartDetailService {

    private final CartDetailRepository cartDetailRepository;

    public CartDetailService(CartDetailRepository cartDetailRepository){
        this.cartDetailRepository = cartDetailRepository;
    }

    public List<CartDetail> getAllProductsInCart(Cart cart){
        return cartDetailRepository.findAllByCart(cart);
    }

    public void updateQuantity(Long id, Integer quantity) {
        CartDetail cartDetail = cartDetailRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Cart not found with id: " + id));

        cartDetail.setQuantity(quantity);
        cartDetailRepository.save(cartDetail);
    }
}
