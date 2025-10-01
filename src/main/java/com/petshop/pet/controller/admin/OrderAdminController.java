package com.petshop.pet.controller.admin;

import com.petshop.pet.domain.Order;
import com.petshop.pet.service.OrderService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@Controller
public class OrderAdminController {

    private final OrderService orderService;

    public OrderAdminController(OrderService orderService){
        this.orderService = orderService;
    }

    @GetMapping("/admin/order")
    public String getOrderAdminPage(Model model){

        List<Order> orders = orderService.getAllOrdersByAdmin();
        model.addAttribute("orders", orders);

        return "admin/order/index";
    }

    @GetMapping("/admin/order/{orderId}")
    public String getOrderDetailPage(Model model,
                                     @PathVariable("orderId") long id){

        Order order = orderService.getOrderById(id);
        model.addAttribute("order", order);

        return "admin/order/detail";
    }

    @GetMapping("/admin/order/update/{orderId}")
    public String getOrderUpdatePage(Model model,
                                     @PathVariable("orderId") long id){

        Order order = orderService.getOrderById(id);
        model.addAttribute("order", order);

        return "admin/order/update";
    }

    @PostMapping("/admin/order/update/{orderId}")
    public String updateOrder(@ModelAttribute("order") Order newOrder,
                              @PathVariable("orderId") long id){

        orderService.updateOrder(id, newOrder);

        return "redirect:/admin/order";
    }

}
