package com.petshop.pet.repository;

import com.petshop.pet.domain.Order;
import com.petshop.pet.enums.Status;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.Instant;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order, Long>,
        JpaSpecificationExecutor<Order> {

    List<Order> findByUserUsernameAndStatusInOrderByCreatedAtDesc(String username, List<Status> statuses);

    Order findByOrderCodeAndUserUsername(String orderId, String username);

    Optional<Order> findByOrderCodeAndSessionId(String orderId, String session);

    @Query(value = """
            SELECT status, COUNT(status) as total
            FROM orders
            group by status
        """, nativeQuery = true)
    List<Map<String, Object>> findAllNumberStatus();

    long countByStatus(Status status);

    List<Order> findTop10ByCreatedAtBetweenOrderByCreatedAtDesc(Instant start, Instant end);

    int countByCreatedAtBetween(Instant start, Instant end);

    List<Order> findByStatusAndCreatedAtBetween(Status status, Instant start, Instant end);

    @Query(value = """
        SELECT COALESCE(SUM(total_amount), 0)
        FROM orders
        WHERE status = 'DELIVERED'
          AND created_at BETWEEN :start AND :end
        """, nativeQuery = true)
    double sumRevenueDeliveredBetween(@Param("start") Instant start, @Param("end") Instant end);

    @Query(value = """
        SELECT COALESCE(SUM(total_amount), 0)
        FROM orders
        WHERE status = 'DELIVERED'
        """, nativeQuery = true)
    double sumTotalRevenueDelivered();

}
