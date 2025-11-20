package com.petshop.pet.domain.dto;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class DashboardViewDTO {
    String labelTime;
    String currentRange;
    long ordersPeriod;
    long newUsersPeriod;
    long pendingOrders;
    double revenuePeriod;
    long totalUser;
    long totalProduct;
    long totalOrder;
    double totalRevenue;
    String dateLabelsJson;
    String revenueValuesJson;
    String orderStatusLabelsJson;
    String orderStatusValuesJson;

    List<?> recentOrders;
    List<?> topSellingProducts;
}
