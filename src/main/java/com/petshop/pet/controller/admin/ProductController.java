package com.petshop.pet.controller.admin;

import com.petshop.pet.domain.Product;
import com.petshop.pet.service.ProductService;
import com.petshop.pet.service.UploadService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Controller
public class ProductController {

    private final ProductService productService;

    private final UploadService uploadService;

    public ProductController(ProductService productService,
                             UploadService uploadService){
        this.productService = productService;
        this.uploadService = uploadService;
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
    public String createProduct(@ModelAttribute("newProduct") Product product,
                                @RequestParam("productFile") MultipartFile file){
        String image = uploadService.handleUploadFile(file, "product", true);
        product.setImageUrl(image);

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
                                @ModelAttribute("newProduct") Product product,
                                @RequestParam("productFile") MultipartFile file){
        String imageUpdate = uploadService.handleUploadFile(file, "product", false);
        product.setImageUrl(imageUpdate);

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
