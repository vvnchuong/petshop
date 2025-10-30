package com.petshop.pet.controller.admin;

import com.petshop.pet.domain.Product;
import com.petshop.pet.domain.dto.ProductCreateDTO;
import com.petshop.pet.domain.dto.ProductUpdateDTO;
import com.petshop.pet.service.ProductService;
import com.petshop.pet.service.UploadService;
import com.turkraft.springfilter.boot.Filter;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/admin/products")
public class ProductController {

    private final ProductService productService;

    private final UploadService uploadService;

    public ProductController(ProductService productService,
                             UploadService uploadService){
        this.productService = productService;
        this.uploadService = uploadService;
    }

    @GetMapping("")
    public String getProductPage(Model model,
                                 @Filter Specification<Product> spec,
                                 @RequestParam(name = "page", defaultValue = "1") int page,
                                 @PageableDefault(size = 5) Pageable pageableDefault){

        Pageable pageable = PageRequest.of(page - 1,
                pageableDefault.getPageSize(),
                pageableDefault.getSort());

        Page<Product> products = productService.getAllProducts(spec, pageable);

        model.addAttribute("products", products.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", products.getTotalPages());
        model.addAttribute("totalElements", products.getTotalElements());

        return "admin/product/index";
    }

    @GetMapping("/{id}")
    public String getProductDetailPage(Model model,
                                       @PathVariable("id") long productId){
        Product product = productService.getProductById(productId);
        model.addAttribute("product", product);
        return "admin/product/detail";
    }

    @GetMapping("/create")
    public String getCreateProductPage(Model model){
        model.addAttribute("newProduct", new ProductCreateDTO());
        return "admin/product/create";
    }

    @PostMapping("/create")
    public String createProduct(@Valid @ModelAttribute("newProduct")
                                    ProductCreateDTO productCreateDTO,
                                BindingResult bindingResult,
                                @RequestParam("productFile") MultipartFile file){

        if(bindingResult.hasErrors())
            return "admin/product/create";

        String image = uploadService.handleUploadFile(file, "product", true);
        productCreateDTO.setImageUrl(image);

        productService.createProduct(productCreateDTO);

        return "redirect:/admin/products";
    }

    @GetMapping("/update/{id}")
    public String getUpdateProductPage(Model model,
                                       @PathVariable("id") long productId){
        Product product = productService.getProductById(productId);
        model.addAttribute("newProduct", product);
        return "admin/product/update";
    }

    @PostMapping("/update/{id}")
    public String updateProduct(@PathVariable("id") long productId,
                                @Valid @ModelAttribute("newProduct") ProductUpdateDTO productUpdateDTO,
                                BindingResult bindingResult,
                                @RequestParam("productFile") MultipartFile file,
                                Model model){

        if(bindingResult.hasErrors())
            return "admin/product/update";

        String imageUpdate = uploadService.handleUploadFile(file, "product", false);
        productUpdateDTO.setImageUrl(imageUpdate);

        productService.updateProduct(productId, productUpdateDTO);

        return "redirect:/admin/products";
    }

    @GetMapping("/delete/{id}")
    public String getDeleteProductPage(@PathVariable("id") long id){
        return "admin/product/delete";
    }

    @PostMapping("/delete/{id}")
    public String deleteProduct(@PathVariable("id") long productId,
                                Model model){

        productService.deleteProduct(productId);

        return "redirect:/admin/products";
    }

}
