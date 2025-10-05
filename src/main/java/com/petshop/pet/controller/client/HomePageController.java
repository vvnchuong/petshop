package com.petshop.pet.controller.client;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.PetType;
import com.petshop.pet.domain.Product;
import com.petshop.pet.domain.User;
import com.petshop.pet.service.PetTypeService;
import com.petshop.pet.service.ProductService;
import com.petshop.pet.service.UserService;
import com.petshop.pet.utils.PageableUtil;
import com.turkraft.springfilter.boot.Filter;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
        Map<Long, List<Product>> products = productService.getAllProductsHomePage()
                .stream().collect(Collectors.groupingBy(
                        p -> p.getSubcategory().getCategory().getId()));

        model.addAttribute("products", products);
        return "client/homepage/index";
    }

    @GetMapping("/{pet}")
    public String getShopPetPage(Model model,
                                 @PathVariable("pet") String pet,
                                 @Filter Specification<Product> spec,
                                 @RequestParam(defaultValue = "0") int page,
                                 @RequestParam(defaultValue = "4") int size,
                                 @RequestParam(defaultValue = "default") String sort){

        Pageable pageable = PageableUtil.createPageable(page, size, sort);

        Page<Product> petProducts = productService.getAllPetProducts(pet, spec, pageable);

        model.addAttribute("products", petProducts.getContent());
        model.addAttribute("currentPage", petProducts.getNumber());
        model.addAttribute("totalPages", petProducts.getTotalPages());
        model.addAttribute("totalElements", petProducts.getTotalElements());
        model.addAttribute("petSlug", pet);
        model.addAttribute("currentSort", sort);


        return "client/product/index";
    }

    @GetMapping("/{pet}/{subcategory}")
    public String getSubPetPage(Model model,
                                @PathVariable("pet") String pet,
                                @PathVariable("subcategory") String sub,
                                @RequestParam(defaultValue = "0") int page,
                                @RequestParam(defaultValue = "4") int size,
                                @RequestParam(defaultValue = "default") String sort) {

        Pageable pageable = PageableUtil.createPageable(page, size, sort);
        Page<Product> subProducts = productService.getAllProductsByPetAndSubcategory(pet, sub, pageable);

        model.addAttribute("products", subProducts.getContent());
        model.addAttribute("currentPage", subProducts.getNumber());
        model.addAttribute("totalPages", subProducts.getTotalPages());
        model.addAttribute("totalElements", subProducts.getTotalElements());
        model.addAttribute("petSlug", pet);
        model.addAttribute("subcategorySlug", sub);
        model.addAttribute("currentSort", sort);

        return "client/product/index";
    }

}
