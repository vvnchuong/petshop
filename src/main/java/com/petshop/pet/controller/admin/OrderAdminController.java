package com.petshop.pet.controller.admin;

import com.petshop.pet.domain.Order;
import com.petshop.pet.service.OrderService;
import com.turkraft.springfilter.boot.Filter;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/orders")
public class OrderAdminController {

    private final OrderService orderService;

    public OrderAdminController(OrderService orderService){
        this.orderService = orderService;
    }

    @GetMapping
    public String getOrderAdminPage(Model model,
                                    @Filter Specification<Order> spec,
                                    @RequestParam(name = "page", defaultValue = "1") int page,
                                    @PageableDefault(size = 5) Pageable pageableDefault){

        Pageable pageable = PageRequest.of(page - 1,
                pageableDefault.getPageSize(),
                pageableDefault.getSort());

        Page<Order> orders = orderService.getAllOrdersByAdmin(spec, pageable);

        model.addAttribute("orders", orders.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", orders.getTotalPages());
        model.addAttribute("totalElements", orders.getTotalElements());

        return "admin/order/index";
    }

    @GetMapping("/{orderId}")
    public String getOrderDetailPage(Model model,
                                     @PathVariable("orderId") long id){

        Order order = orderService.getOrderById(id);
        model.addAttribute("order", order);

        return "admin/order/detail";
    }

    @GetMapping("/update/{orderId}")
    public String getOrderUpdatePage(Model model,
                                     @PathVariable("orderId") long id){

        Order order = orderService.getOrderById(id);
        model.addAttribute("order", order);

        return "admin/order/update";
    }

    @PostMapping("/update/{orderId}")
    public String updateOrder(@ModelAttribute("order") Order newOrder,
                              @PathVariable("orderId") long id){

        orderService.updateOrder(id, newOrder);

        return "redirect:/admin/orders";
    }

}
