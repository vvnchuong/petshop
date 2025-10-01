package com.petshop.pet.controller.client;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.Product;
import com.petshop.pet.domain.User;
import com.petshop.pet.service.ProductService;
import com.petshop.pet.service.UserService;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class HomePageController {

    private final UserService userService;

    private final ProductService productService;

    public HomePageController(UserService userService,
                              ProductService productService){
        this.userService = userService;
        this.productService = productService;
    }

    @GetMapping("/")
    public String getHomePage(Model model){
        Map<Long, List<Product>> products = productService.getAllProducts()
                .stream().collect(Collectors.groupingBy(
                        p -> p.getSubcategory().getCategory().getId()));

        model.addAttribute("products", products);
        return "client/homepage/index";
    }

    @GetMapping("/{pet}")
    public String getShopPetPage(Model model,
                                 @PathVariable("pet") String pet){
        List<Product> petProducts = productService.getAllPetProducts(pet);
        model.addAttribute("products", petProducts);
        return "client/product/index";
    }

    @GetMapping("/{pet}/{subcategory}")
    public String getSubPetPage(Model model,
                                @PathVariable("pet") String pet,
                                @PathVariable("subcategory") String sub){
        List<Product> subProducts = productService.getAllProductsByPetAndSubcategory(pet, sub);
        model.addAttribute("products", subProducts);
        return "client/product/index";
    }

}
