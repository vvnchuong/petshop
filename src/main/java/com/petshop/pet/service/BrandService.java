package com.petshop.pet.service;

import com.petshop.pet.domain.Brand;
import com.petshop.pet.domain.dto.BrandCreateDTO;
import com.petshop.pet.domain.dto.BrandUpdateDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;

public interface BrandService {

    Page<Brand> getAllBrands(Specification<Brand> spec, Pageable page);

    List<Brand> getListBrands();

    Brand getBrandById(long brandId);

    void createBrand(BrandCreateDTO brandCreateDTO);

    void updateBrand(long brandId, BrandUpdateDTO brandUpdateDTO);

    void deleteBrand(long brandId);

}
