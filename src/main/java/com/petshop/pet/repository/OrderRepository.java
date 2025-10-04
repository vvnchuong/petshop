package com.petshop.pet.repository;

import com.petshop.pet.domain.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long>,
        JpaSpecificationExecutor<Order> {

    List<Order> findByUserUsername(String username);

    Order findByIdAndUserUsername(long orderId, String username);

}
