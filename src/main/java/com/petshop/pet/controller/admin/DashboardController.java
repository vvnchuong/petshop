package com.petshop.pet.controller.admin;

import com.petshop.pet.domain.dto.DashboardViewDTO;
import com.petshop.pet.enums.DashboardRange;
import com.petshop.pet.service.DashboardService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin")
public class DashboardController {

    private final DashboardService dashboardService;

    public DashboardController(DashboardService dashboardService) {
        this.dashboardService = dashboardService;
    }

    @GetMapping
    public String getDashboardPage(Model model,
                                   @RequestParam(value = "range", defaultValue = "TODAY") DashboardRange range){

        DashboardViewDTO dashboardData = dashboardService.getDashboardData(range);
        model.addAttribute("data", dashboardData);

        return "admin/dashboard/index";
    }
}