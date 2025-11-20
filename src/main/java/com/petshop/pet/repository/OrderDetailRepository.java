package com.petshop.pet.repository;

import com.petshop.pet.domain.Order;
import com.petshop.pet.domain.OrderDetail;
import com.petshop.pet.domain.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Map;

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

    @Query(value = """
        SELECT 
            od.product_id AS productId,
            p.name AS name,
            p.stock AS stock,
            SUM(od.quantity) AS totalSold
        FROM order_detail od
        JOIN products p ON p.id = od.product_id
        JOIN orders o ON o.id = od.order_id
        WHERE o.status = 'DELIVERED'
        GROUP BY od.product_id, p.name, p.stock
        ORDER BY totalSold DESC
        LIMIT 10
        """, nativeQuery = true)
    List<Map<String, Object>> findTopSellingProducts();

    boolean existsByProductId(long productId);

    List<OrderDetail> findAllByOrder(Order order);

}
