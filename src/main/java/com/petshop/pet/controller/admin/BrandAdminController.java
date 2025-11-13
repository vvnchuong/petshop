package com.petshop.pet.controller.admin;

import com.petshop.pet.domain.Brand;
import com.petshop.pet.domain.dto.BrandCreateDTO;
import com.petshop.pet.domain.dto.BrandUpdateDTO;
import com.petshop.pet.service.impl.BrandService;
import com.petshop.pet.service.impl.UploadService;
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
@RequestMapping("/admin/brands")
public class BrandAdminController {

    private final BrandService brandService;

    private final UploadService uploadService;

    public BrandAdminController(BrandService brandService,
                                UploadService uploadService){
        this.brandService = brandService;
        this.uploadService = uploadService;
    }

    @GetMapping
    public String getBrandAdminPage(Model model,
                                @Filter Specification<Brand> spec,
                                @RequestParam(name = "page", defaultValue = "1") int page,
                                @PageableDefault(size = 5)Pageable pageableDefault){

        Pageable pageable = PageRequest.of(page - 1,
                pageableDefault.getPageSize(),
                pageableDefault.getSort());

        Page<Brand> brands = brandService.getAllBrands(spec, pageable);

        model.addAttribute("brands", brands.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", brands.getTotalPages());
        model.addAttribute("totalElements", brands.getTotalElements());

        return "admin/brand/index";
    }

    @GetMapping("/{id}")
    public String getBrandDetailAdminPage(@PathVariable("id") long brandId,
                                     Model model){

        Brand brand = brandService.getBrandById(brandId);
        model.addAttribute("brand", brand);

        return "admin/brand/detail";
    }

    @GetMapping("/create")
    public String getCreateBrandPage(Model model){
        model.addAttribute("newBrand", new BrandCreateDTO());
        return "admin/brand/create";
    }

    @PostMapping("/create")
    public String createBrand(@Valid @ModelAttribute("newBrand") BrandCreateDTO brandCreateDTO,
                              BindingResult bindingResult,
                              @RequestParam("logoFile") MultipartFile file){

        if(bindingResult.hasErrors())
            return "admin/brand/create";

        String brandUrl = uploadService.handleUploadFile(file, "brands", true);
        brandCreateDTO.setLogoUrl(brandUrl);

        brandService.createBrand(brandCreateDTO);

        return "redirect:/admin/brands";
    }

    @GetMapping("/update/{id}")
    public String getUpdateBrandPage(@PathVariable("id") long brandId,
                                     Model model){

        Brand brand = brandService.getBrandById(brandId);
        model.addAttribute("newBrand", brand);

        return "admin/brand/update";
    }

    @PostMapping("/update/{id}")
    public String updateBrand(@PathVariable("id") long brandId,
                              @Valid @ModelAttribute("newBrand") BrandUpdateDTO brandUpdateDTO,
                              BindingResult bindingResult,
                              @RequestParam("logoFile") MultipartFile file){

        if(bindingResult.hasErrors())
            return "admin/brand/update";

        String brandUrl = uploadService.handleUploadFile(file, "brands", false);
        brandUpdateDTO.setLogoUrl(brandUrl);

        brandService.updateBrand(brandId, brandUpdateDTO);

        return "redirect:/admin/brands";
    }

    @GetMapping("/delete/{id}")
    public String getDeleteBrandPage(@PathVariable("id") long brandId){
        return "admin/brand/delete";
    }

    @PostMapping("/delete/{id}")
    public String deleteBrand(@PathVariable("id") long brandId){
        brandService.deleteBrand(brandId);

        return "redirect:/admin/brands";
    }

}
