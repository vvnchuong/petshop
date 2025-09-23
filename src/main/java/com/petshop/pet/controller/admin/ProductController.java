package com.petshop.pet.controller.admin;

import com.petshop.pet.domain.Product;
import com.petshop.pet.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@Controller
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService){
        this.productService = productService;
    }

    @GetMapping("/admin/product")
    public String getProductPage(Model model){
        List<Product> products = productService.getAllProducts();
        model.addAttribute("products", products);
        return "admin/product/index";
    }

    @GetMapping("/admin/product/{id}")
    public String getProductDetailPage(Model model,
                                       @PathVariable("id") long id){
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        return "admin/product/detail";
    }

    @GetMapping("/admin/product/create")
    public String getCreateProductPage(Model model){
        model.addAttribute("newProduct", new Product());
        return "admin/product/create";
    }

    @PostMapping("/admin/product/create")
    public String createProduct(@ModelAttribute("newProduct") Product product){
        productService.createProduct(product);
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/update/{id}")
    public String getUpdateProductPage(Model model,
                                       @PathVariable("id") long id){
        Product product = productService.getProductById(id);
        model.addAttribute("newProduct", product);
        return "admin/product/update";
    }

    @PostMapping("/admin/product/update/{id}")
    public String updateProduct(@PathVariable("id") long id,
                                @ModelAttribute("newProduct") Product product){
        productService.updateProduct(id, product);
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/delete/{id}")
    public String getDeleteProductPage(@PathVariable("id") long id){
        return "admin/product/delete";
    }

    @PostMapping("/admin/product/delete/{id}")
    public String deleteProduct(@PathVariable("id") long id){
        productService.deleteProduct(id);
        return "redirect:/admin/product";
    }

}
