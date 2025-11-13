package com.petshop.pet.controller.admin;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.petshop.pet.service.impl.OrderService;
import com.petshop.pet.service.impl.ProductService;
import com.petshop.pet.service.impl.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class DashboardController {

    private final OrderService orderService;

    private final ProductService productService;

    private final UserService userService;

    private final ObjectMapper objectMapper;

    public DashboardController(OrderService orderService,
                               ProductService productService,
                               UserService userService,
                               ObjectMapper objectMapper){
        this.orderService = orderService;
        this.productService = productService;
        this.userService = userService;
        this.objectMapper = objectMapper;
    }

    @GetMapping
    public String getDashboardPage(Model model) throws JsonProcessingException {

        // total
        model.addAttribute("totalUser", userService.countTotalUsers());
        model.addAttribute("totalProduct", productService.countTotalProducts());
        model.addAttribute("totalOrder", orderService.countTotalOrders());

        // daily static
        model.addAttribute("revenueToday", orderService.getRevenueToday());
        model.addAttribute("ordersToday", orderService.countOrdersToday());
        model.addAttribute("newUsersToday", userService.countNewUsersToday());

        // data for a week
        Map<LocalDate, Double> revenueDataMap = orderService.getRevenueDataForLast7Days();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM");
        List<String> dateLabels = new ArrayList<>();
        List<Double> revenueValues = new ArrayList<>();

        for (Map.Entry<LocalDate, Double> entry : revenueDataMap.entrySet()) {
            dateLabels.add(entry.getKey().format(formatter));
            revenueValues.add(entry.getValue());
        }

        model.addAttribute("dateLabelsJson", objectMapper.writeValueAsString(dateLabels));
        model.addAttribute("revenueValuesJson", objectMapper.writeValueAsString(revenueValues));

        // recent orders
        model.addAttribute("recentOrders", orderService.findTop10RecentOrders());

        return "admin/dashboard/index";
    }

}
