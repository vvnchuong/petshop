package com.petshop.pet.controller.client;

import com.petshop.pet.domain.Product;
import com.petshop.pet.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class HomePageController {

    private final ProductService productService;

    public HomePageController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping
    public String getHomePage(Model model){
        Map<Long, List<Product>> products = productService.getBestSellingProduct()
                .stream().collect(Collectors.groupingBy(
                        p -> p.getSubcategory().getCategory().getId()));

        model.addAttribute("products", products);
        return "client/homepage/index";
    }

}
