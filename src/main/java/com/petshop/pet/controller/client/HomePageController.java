package com.petshop.pet.controller.client;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.Category;
import com.petshop.pet.domain.PetType;
import com.petshop.pet.domain.Product;
import com.petshop.pet.domain.User;
import com.petshop.pet.service.CategoryService;
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

    private final ProductService productService;

    private final PetTypeService petTypeService;

    private final CategoryService categoryService;

    public HomePageController(ProductService productService,
                              PetTypeService petTypeService,
                              CategoryService categoryService){
        this.productService = productService;
        this.petTypeService = petTypeService;
        this.categoryService = categoryService;
    }

    @GetMapping("/")
    public String getHomePage(Model model){
        Map<Long, List<Product>> products = productService.getBestSellingProduct()
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
                                 @RequestParam(defaultValue = "default") String sort,
                                 @RequestParam(required = false) Double maxPrice,
                                 @RequestParam(required = false) String keyword){

        Pageable pageable = PageableUtil.createPageable(page, size, sort);

        PetType petType = petTypeService.getPetTypeBySlug(pet);

        List<Category> categories = categoryService.getAllByPetTypeByPetTypeId(petType.getId());

        Page<Product> petProducts;
        if(keyword != null && !keyword.isBlank()){
            petProducts = productService.searchPetProductsByPet(pet, keyword, maxPrice, pageable);
        }else {
            petProducts = productService.getAllPetProducts(pet, spec, pageable, maxPrice);
        }

        model.addAttribute("products", petProducts.getContent());
        model.addAttribute("currentPage", petProducts.getNumber());
        model.addAttribute("totalPages", petProducts.getTotalPages());
        model.addAttribute("totalElements", petProducts.getTotalElements());
        model.addAttribute("petSlug", pet);
        model.addAttribute("currentSort", sort);
        model.addAttribute("petType", petType);
        model.addAttribute("categories", categories);
        model.addAttribute("maxPrice", maxPrice);

        return "client/product/index";
    }

    @GetMapping("/{pet}/{subcategory}")
    public String getSubPetPage(Model model,
                                @PathVariable("pet") String pet,
                                @PathVariable("subcategory") String sub,
                                @RequestParam(defaultValue = "0") int page,
                                @RequestParam(defaultValue = "4") int size,
                                @RequestParam(defaultValue = "default") String sort,
                                @RequestParam(required = false) Double maxPrice,
                                @RequestParam(required = false) String keyword) {

        Pageable pageable = PageableUtil.createPageable(page, size, sort);

        PetType petType = petTypeService.getPetTypeBySlug(pet);

        List<Category> categories = categoryService.getAllByPetTypeByPetTypeId(petType.getId());

        Page<Product> subProducts;
        if(keyword != null && !keyword.isBlank()){
            subProducts = productService.searchPetProductsBySubcategory(pet, sub, keyword, maxPrice, pageable);
        }else{
            subProducts = productService.getAllProductsByPetAndSubcategory(pet, sub, pageable, maxPrice);
        }


        model.addAttribute("products", subProducts.getContent());
        model.addAttribute("currentPage", subProducts.getNumber());
        model.addAttribute("totalPages", subProducts.getTotalPages());
        model.addAttribute("totalElements", subProducts.getTotalElements());
        model.addAttribute("petSlug", pet);
        model.addAttribute("subcategorySlug", sub);
        model.addAttribute("currentSort", sort);
        model.addAttribute("petType", petType);
        model.addAttribute("categories", categories);
        model.addAttribute("maxPrice", maxPrice);

        return "client/product/index";
    }

}
