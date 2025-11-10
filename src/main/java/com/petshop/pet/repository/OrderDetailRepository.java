package com.petshop.pet.repository;

import com.petshop.pet.domain.Order;
import com.petshop.pet.domain.OrderDetail;
import com.petshop.pet.domain.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {

    @Query(value = "SELECT p.* " +
            "FROM products p " +
            "JOIN order_detail od " +
            "ON p.id = od.product_id " +
            "GROUP BY p.id " +
            "ORDER BY SUM(od.quantity) DESC " +
            "LIMIT 8",
    nativeQuery = true)
    List<Product> findBestSellingProducts();

    boolean existsByProductId(long productId);

    List<OrderDetail> findAllByOrder(Order order);

}
