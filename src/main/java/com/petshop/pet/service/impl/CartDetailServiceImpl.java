package com.petshop.pet.service.impl;

import com.petshop.pet.domain.Cart;
import com.petshop.pet.domain.CartDetail;
import com.petshop.pet.enums.ErrorCode;
import com.petshop.pet.exception.BusinessException;
import com.petshop.pet.repository.CartDetailRepository;
import com.petshop.pet.repository.CartRepository;
import com.petshop.pet.service.CartDetailService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class CartDetailServiceImpl implements CartDetailService {

    private final CartDetailRepository cartDetailRepository;

    private final CartRepository cartRepository;

    public CartDetailServiceImpl(CartDetailRepository cartDetailRepository,
                                 CartRepository cartRepository){
        this.cartDetailRepository = cartDetailRepository;
        this.cartRepository = cartRepository;
    }

    @Override
    public List<CartDetail> getAllProductsInCartByUser(String username){
        Cart cart = cartRepository.findByUserUsername(username);
        return cart == null ?
                new ArrayList<>() : cartDetailRepository.findAllByCart(cart);
    }

    @Override
    public void updateQuantity(Long id, Integer quantity) {
        CartDetail cartDetail = cartDetailRepository.findById(id)
                .orElseThrow(() -> new BusinessException(ErrorCode.CART_NOT_FOUND));

        cartDetail.setQuantity(quantity);
        cartDetailRepository.save(cartDetail);
    }

    @Override
    @Transactional
    public void deleteProductInCartDetail(String slug, String username) {
        Cart cart = cartRepository.findByUserUsername(username);
        cart.setQuantity(cart.getQuantity() - 1);
        cartRepository.save(cart);

        cartDetailRepository.deleteByProductSlug(slug);
    }

    @Override
    @Transactional
    public void deleteAllProductInCartByCartId(Cart cart){
        cartDetailRepository.deleteAllByCart(cart);
    }

}
