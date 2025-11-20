package com.petshop.pet.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.petshop.pet.domain.Order;
import com.petshop.pet.domain.dto.DashboardViewDTO;
import com.petshop.pet.enums.DashboardRange;
import com.petshop.pet.enums.Status;
import com.petshop.pet.repository.OrderDetailRepository;
import com.petshop.pet.repository.OrderRepository;
import com.petshop.pet.repository.ProductRepository;
import com.petshop.pet.repository.UserRepository;
import com.petshop.pet.service.DashboardService;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class DashboardServiceImpl implements DashboardService {

    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final ProductRepository productRepository;
    private final UserRepository userRepository;
    private final ObjectMapper objectMapper;

    private static final ZoneId ZONE_ID = ZoneId.of("Asia/Ho_Chi_Minh");

    public DashboardServiceImpl(OrderRepository orderRepository,
                                OrderDetailRepository orderDetailRepository,
                                ProductRepository productRepository,
                                UserRepository userRepository,
                                ObjectMapper objectMapper){
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
        this.productRepository = productRepository;
        this.userRepository = userRepository;
        this.objectMapper = objectMapper;
    }

    @Override
    public int countByCreatedAtBetween(Instant start, Instant end) {
        return orderRepository.countByCreatedAtBetween(start, end);
    }

    @Override
    public double getRevenueBetween(Instant start, Instant end) {
        return orderRepository.sumRevenueDeliveredBetween(start, end);
    }

    @Override
    public List<Order> getTop10ByCreatedAtBetweenOrderByCreatedAtDesc(Instant start, Instant end) {
        return orderRepository.findTop10ByCreatedAtBetweenOrderByCreatedAtDesc(start, end);
    }

    @Override
    public Map<LocalDate, Double> getRevenueDataForPeriod(Instant start, Instant end) {
        List<Order> orders = orderRepository.findByStatusAndCreatedAtBetween(Status.DELIVERED, start, end);

        Map<LocalDate, Double> revenueMap = orders.stream()
                .collect(Collectors.groupingBy(
                        order -> order.getCreatedAt().atZone(ZONE_ID).toLocalDate(),
                        Collectors.summingDouble(Order::getTotalAmount)
                ));

        return revenueMap.entrySet().stream()
                .sorted(Map.Entry.comparingByKey())
                .collect(Collectors.toMap(
                        Map.Entry::getKey,
                        Map.Entry::getValue,
                        (e1, e2) -> e1,
                        LinkedHashMap::new
                ));
    }

    @Override
    public long countTotalOrders() {
        return orderRepository.count();
    }

    @Override
    public double getTotalRevenue() {
        return orderRepository.sumTotalRevenueDelivered();
    }

    @Override
    public long countTotalProducts() {
        return productRepository.count();
    }

    @Override
    public long countTotalUsers() {
        return userRepository.count();
    }

    @Override
    public List<Map<String, Object>> getAllNumberStatus() {
        return orderRepository.findAllNumberStatus();
    }

    @Override
    public List<Map<String, Object>> getBestSellingProducts() {
        return orderDetailRepository.findTopSellingProducts();
    }

    @Override
    public long countOrderByStatus(Status status) {
        return orderRepository.countByStatus(status);
    }

    @Override
    public DashboardViewDTO getDashboardData(DashboardRange range) {
        var timeFrame = range.calculateTimeFrame();
        Instant start = timeFrame.start();
        Instant end = timeFrame.end();

        // Revenue Chart
        Map<LocalDate, Double> revenueMap = getRevenueDataForPeriod(start, end);
        List<String> dateLabels = new ArrayList<>();
        List<Double> revenueValues = new ArrayList<>();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM");

        revenueMap.forEach((date, revenue) -> {
            dateLabels.add(date.format(formatter));
            revenueValues.add(revenue);
        });

        //  Status Chart
        List<Map<String, Object>> statusRawData = getAllNumberStatus();
        List<String> statusLabels = new ArrayList<>();
        List<Integer> statusValues = new ArrayList<>();

        for (Map<String, Object> row : statusRawData) {
            statusLabels.add(row.get("status").toString());
            statusValues.add(Integer.parseInt(row.get("total").toString()));
        }

        return DashboardViewDTO.builder()
                .labelTime(range.getLabel())
                .currentRange(range.name())
                .ordersPeriod(countByCreatedAtBetween(start, end))
                .newUsersPeriod(0)
                .pendingOrders(countOrderByStatus(Status.PENDING))
                .revenuePeriod(getRevenueBetween(start, end))
                .totalUser(countTotalUsers())
                .totalProduct(countTotalProducts())
                .totalOrder(countTotalOrders())
                .totalRevenue(getTotalRevenue())
                .dateLabelsJson(convertToJson(dateLabels))
                .revenueValuesJson(convertToJson(revenueValues))
                .orderStatusLabelsJson(convertToJson(statusLabels))
                .orderStatusValuesJson(convertToJson(statusValues))
                .recentOrders(getTop10ByCreatedAtBetweenOrderByCreatedAtDesc(start, end))
                .topSellingProducts(getBestSellingProducts())
                .build();
    }

    // Helper Json
    private String convertToJson(Object data) {
        try {
            return objectMapper.writeValueAsString(data);
        } catch (JsonProcessingException e) {
            return "[]";
        }
    }

}