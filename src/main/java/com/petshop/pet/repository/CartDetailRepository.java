package com.petshop.pet.repository;

import com.petshop.pet.domain.Cart;
import com.petshop.pet.domain.CartDetail;
import com.petshop.pet.domain.Product;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {

    CartDetail findByCartAndProduct(Cart cart, Product product);

    List<CartDetail> findAllByCart(Cart cart);

    void deleteByProductSlug(String slug);

    CartDetail findByCartUserUsernameAndProductId(String username, Long productId);

}
