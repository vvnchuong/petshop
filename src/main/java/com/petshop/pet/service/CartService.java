package com.petshop.pet.service;

import com.petshop.pet.domain.Cart;
import com.petshop.pet.domain.CartDetail;
import com.petshop.pet.domain.Product;
import com.petshop.pet.domain.User;
import com.petshop.pet.repository.CartDetailRepository;
import com.petshop.pet.repository.CartRepository;
import com.petshop.pet.repository.ProductRepository;
import com.petshop.pet.repository.UserRepository;
import org.springframework.stereotype.Service;

@Service
public class CartService {

    private final CartRepository cartRepository;

    private final CartDetailRepository cartDetailRepository;

    private final ProductRepository productRepository;

    private final UserRepository userRepository;

    public CartService(CartRepository cartRepository,
                       CartDetailRepository cartDetailRepository,
                       ProductRepository productRepository,
                       UserRepository userRepository){
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.productRepository = productRepository;
        this.userRepository = userRepository;
    }

    public void addProductToCart(String username, String productSlug) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found"));

        Cart cart = cartRepository.findByUser(user);
        if (cart == null) {
            cart = new Cart();
            cart.setUser(user);
            cart.setQuantity(0);
            cart = cartRepository.save(cart);
        }

        Product product = productRepository.findBySlug(productSlug);
        if (product == null) {
            throw new RuntimeException("Product not found");
        }

        CartDetail cartDetail = cartDetailRepository.findByCartAndProduct(cart, product);
        if (cartDetail == null) {
            cartDetail = new CartDetail();
            cartDetail.setCart(cart);
            cartDetail.setProduct(product);
            cartDetail.setQuantity(1);
            cartDetail.setPrice(product.getPrice());

            cart.setQuantity(cart.getQuantity() + 1);
        } else {
            cartDetail.setQuantity(cartDetail.getQuantity() + 1);
        }

        cartDetailRepository.save(cartDetail);
        cartRepository.save(cart);
    }

    public int getCartQuantity(User user){
        Cart cart = cartRepository.findByUser(user);
        return cart != null ? cart.getQuantity() : 0;
    }

}
