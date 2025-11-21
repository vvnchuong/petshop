package com.petshop.pet.service.impl;

import com.petshop.pet.domain.Cart;
import com.petshop.pet.domain.CartDetail;
import com.petshop.pet.domain.Product;
import com.petshop.pet.domain.User;
import com.petshop.pet.enums.ErrorCode;
import com.petshop.pet.exception.BusinessException;
import com.petshop.pet.repository.CartDetailRepository;
import com.petshop.pet.repository.CartRepository;
import com.petshop.pet.repository.ProductRepository;
import com.petshop.pet.repository.UserRepository;
import com.petshop.pet.service.CartService;
import org.springframework.stereotype.Service;

@Service
public class CartServiceImpl implements CartService {

    private final CartRepository cartRepository;

    private final CartDetailRepository cartDetailRepository;

    private final ProductRepository productRepository;

    private final UserRepository userRepository;

    public CartServiceImpl(CartRepository cartRepository,
                           CartDetailRepository cartDetailRepository,
                           ProductRepository productRepository,
                           UserRepository userRepository){
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.productRepository = productRepository;
        this.userRepository = userRepository;
    }

    @Override
    public void addProductToCart(String username, String productSlug, Integer quantity){
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new BusinessException(ErrorCode.USER_NOT_FOUND));

        Cart cart = cartRepository.findByUser(user);
        if(cart == null){
            cart = new Cart();
            cart.setUser(user);
            cart.setQuantity(0);
            cart = cartRepository.save(cart);
        }

        Product product = productRepository.findBySlug(productSlug)
                .orElseThrow(() -> new BusinessException(ErrorCode.PRODUCT_NOT_FOUND));

        CartDetail cartDetail = cartDetailRepository.findByCartAndProduct(cart, product);
        if(cartDetail == null){
            cartDetail = new CartDetail();
            cartDetail.setCart(cart);
            cartDetail.setProduct(product);
            cartDetail.setQuantity(quantity);
            cartDetail.setPrice(product.getPrice());

            cart.setQuantity(cart.getQuantity() + 1);
        }else{
            cartDetail.setQuantity(cartDetail.getQuantity() + quantity);
        }

        cartDetailRepository.save(cartDetail);
        cartRepository.save(cart);
    }

    @Override
    public int getCartQuantity(User user){
        Cart cart = cartRepository.findByUser(user);
        return cart != null ? cart.getQuantity() : 0;
    }

    @Override
    public void resetCart(User user){
        Cart cart = cartRepository.findByUser(user);
        cart.setQuantity(0);

        cartRepository.save(cart);
    }

}
