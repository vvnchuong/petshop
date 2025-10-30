package com.petshop.pet.controller.client;

import com.petshop.pet.domain.Product;
import com.petshop.pet.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/product")
public class ItemController {

    private final ProductService productService;

    public ItemController(ProductService productService){
        this.productService = productService;
    }

    @GetMapping("/{productName}")
    public String getProductDetail(Model model,
                                   @PathVariable("productName") String productName){
        Product productDetail = productService.getProductBySlug(productName);
        model.addAttribute("product", productDetail);
        return "client/product/detail";
    }

}
