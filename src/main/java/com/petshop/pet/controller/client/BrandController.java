package com.petshop.pet.controller.client;

import com.petshop.pet.domain.Brand;
import com.petshop.pet.service.BrandService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/brands")
public class BrandController {

    private final BrandService brandService;

    public BrandController(BrandService brandService){
        this.brandService = brandService;
    }

    @GetMapping
    public String getBrandsPage(Model model){
        List<Brand> brands = brandService.getListBrands();
        model.addAttribute("brands", brands);

        return "client/brand/index";
    }

}
