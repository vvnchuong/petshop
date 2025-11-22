package com.petshop.pet.controller.client;

import com.petshop.pet.domain.Brand;
import com.petshop.pet.domain.PetType;
import com.petshop.pet.domain.Product;
import com.petshop.pet.service.BrandService;
import com.petshop.pet.service.CategoryService;
import com.petshop.pet.service.ProductService;
import com.petshop.pet.service.impl.PetTypeService;
import com.petshop.pet.utils.PageableUtil;
import com.turkraft.springfilter.boot.Filter;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class ProductController {

    private final ProductService productService;

    private final PetTypeService petTypeService;

    private final BrandService brandService;

    public ProductController(ProductService productService,
                             PetTypeService petTypeService,
                             CategoryService categoryService,
                             BrandService brandService){
        this.productService = productService;
        this.petTypeService = petTypeService;
        this.brandService = brandService;
    }

    @GetMapping("/{pet}")
    public String getShopPetPage(Model model,
                                 @PathVariable("pet") String pet,
                                 @Filter Specification<Product> spec,
                                 @RequestParam(defaultValue = "0") int page,
                                 @RequestParam(defaultValue = "12") int size,
                                 @RequestParam(defaultValue = "default") String sort,
                                 @RequestParam(required = false) Double maxPrice,
                                 @RequestParam(required = false) String keyword){

        Pageable pageable = PageableUtil.createPageable(page, size, sort);

        PetType petType = petTypeService.getPetTypeBySlug(pet);

        Page<Product> petProducts;
        if(keyword != null && !keyword.isBlank()){
            petProducts = productService.searchPetProductsByPet(pet, keyword, maxPrice, pageable);
        }else{
            petProducts = productService.getAllPetProducts(pet, spec, pageable, maxPrice);
        }

        List<Brand> brands = brandService.getListBrands();

        model.addAttribute("products", petProducts.getContent());
        model.addAttribute("currentPage", petProducts.getNumber());
        model.addAttribute("totalPages", petProducts.getTotalPages());
        model.addAttribute("totalElements", petProducts.getTotalElements());
        model.addAttribute("petSlug", pet);
        model.addAttribute("currentSort", sort);
        model.addAttribute("petType", petType);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("brands", brands);

        return "client/product/index";
    }

    @GetMapping("/{pet}/{subcategory}")
    public String getSubPetPage(Model model,
                                @PathVariable("petType") String pet,
                                @PathVariable("subcategory") String sub,
                                @RequestParam(defaultValue = "0") int page,
                                @RequestParam(defaultValue = "12") int size,
                                @RequestParam(defaultValue = "default") String sort,
                                @RequestParam(required = false) Double maxPrice,
                                @RequestParam(required = false) String keyword) {

        Pageable pageable = PageableUtil.createPageable(page, size, sort);

        PetType petType = petTypeService.getPetTypeBySlug(pet);

        Page<Product> subProducts;
        if(keyword != null && !keyword.isBlank()){
            subProducts = productService.searchPetProductsBySubcategory(pet, sub, keyword, maxPrice, pageable);
        }else{
            subProducts = productService.getAllProductsByPetAndSubcategory(pet, sub, pageable, maxPrice);
        }

        List<Brand> brands = brandService.getListBrands();

        model.addAttribute("products", subProducts.getContent());
        model.addAttribute("currentPage", subProducts.getNumber());
        model.addAttribute("totalPages", subProducts.getTotalPages());
        model.addAttribute("totalElements", subProducts.getTotalElements());
        model.addAttribute("petSlug", pet);
        model.addAttribute("subcategorySlug", sub);
        model.addAttribute("currentSort", sort);
        model.addAttribute("petType", petType);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("brands", brands);

        return "client/product/index";
    }

    @GetMapping("/products/{productName}")
    public String getProductDetail(Model model,
                                   @PathVariable("productName") String productName){
        Product productDetail = productService.getProductBySlug(productName);

        List<Product> relatedProducts = productService.getRelatedProducts(productDetail); // temp -> Apriori

        model.addAttribute("product", productDetail);
        model.addAttribute("relatedProducts", relatedProducts);

        return "client/product/detail";
    }

    @GetMapping("/brands/{brandSlug}")
    public String getProductsByBrandPage(Model model,
                                         @PathVariable("brandSlug") String slug,
                                         @Filter Specification<Product> spec,
                                         @RequestParam(defaultValue = "0") int page,
                                         @RequestParam(defaultValue = "12") int size,
                                         @RequestParam(defaultValue = "default") String sort,
                                         @RequestParam(required = false) Double maxPrice,
                                         @RequestParam(required = false) String keyword){

        Pageable pageable = PageableUtil.createPageable(page, size, sort);

        Page<Product> brandProducts;

        if(keyword != null && !keyword.isBlank()){
            brandProducts = productService.searchPetProductByBrand(slug, keyword, pageable, maxPrice);
        }else{
            brandProducts = productService.getAllProductsByBrand(spec, pageable, slug, maxPrice);
        }

        List<Brand> brands = brandService.getListBrands();

        model.addAttribute("products", brandProducts.getContent());
        model.addAttribute("currentPage", brandProducts.getNumber());
        model.addAttribute("totalPages", brandProducts.getTotalPages());
        model.addAttribute("totalElements", brandProducts.getTotalElements());
        model.addAttribute("brandSlug", slug);
        model.addAttribute("currentSort", sort);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("brandSlug", slug);
        model.addAttribute("brands", brands);

        return "client/brand/product-list";
    }

}
