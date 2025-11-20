package com.petshop.pet.service;

import com.petshop.pet.domain.Order;
import com.petshop.pet.domain.dto.DashboardViewDTO;
import com.petshop.pet.enums.DashboardRange;
import com.petshop.pet.enums.Status;

import java.time.Instant;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

public interface DashboardService {
    // Total
    long countTotalOrders();
    double getTotalRevenue();
    long countTotalProducts();
    long countTotalUsers();

    // Time-statics
    int countByCreatedAtBetween(Instant start, Instant end);
    double getRevenueBetween(Instant start, Instant end);
    List<Order> getTop10ByCreatedAtBetweenOrderByCreatedAtDesc(Instant start, Instant end);
    Map<LocalDate, Double> getRevenueDataForPeriod(Instant start, Instant end);

    // Others
    List<Map<String, Object>> getAllNumberStatus();
    List<Map<String, Object>> getBestSellingProducts();
    long countOrderByStatus(Status status);

    DashboardViewDTO getDashboardData(DashboardRange range);

}