package com.petshop.pet.repository;

import com.petshop.pet.domain.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {

    List<Order> findByUserUsername(String username);

    Order findByIdAndUserUsername(long orderId, String username);

}
