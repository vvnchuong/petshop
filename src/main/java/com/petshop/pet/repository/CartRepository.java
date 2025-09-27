package com.petshop.pet.repository;

import com.petshop.pet.domain.Cart;
import com.petshop.pet.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CartRepository extends JpaRepository<Cart, Long> {

    Cart findByUser(User user);

    Cart findByUserUsername(String username);

}
