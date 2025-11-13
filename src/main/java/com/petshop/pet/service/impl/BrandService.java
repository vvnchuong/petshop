package com.petshop.pet.service.impl;

import com.petshop.pet.domain.Brand;
import com.petshop.pet.domain.dto.BrandCreateDTO;
import com.petshop.pet.domain.dto.BrandUpdateDTO;
import com.petshop.pet.enums.ErrorCode;
import com.petshop.pet.exception.BusinessException;
import com.petshop.pet.mapper.BrandMapper;
import com.petshop.pet.repository.BrandRepository;
import com.petshop.pet.utils.SlugUtil;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BrandService {

    private final BrandRepository brandRepository;

    private final BrandMapper brandMapper;

    public BrandService(BrandRepository brandRepository,
                        BrandMapper brandMapper){
        this.brandRepository = brandRepository;
        this.brandMapper = brandMapper;
    }

    public Page<Brand> getAllBrands(Specification<Brand> spec,
                                    Pageable page){
        return brandRepository.findAll(spec, page);
    }

    public List<Brand> getListBrands(){
        return brandRepository.findAll();
    }

    public Brand getBrandById(long brandId){
        return brandRepository.findById(brandId)
                .orElseThrow(() -> new BusinessException(ErrorCode.BRAND_NOT_FOUND));
    }

    public void createBrand(BrandCreateDTO brandCreateDTO){
        Brand brand = brandMapper.toBrand(brandCreateDTO);

        if(brand.getSlug() == null || brand.getName().isEmpty()){
            brand.setSlug(SlugUtil.toSlug(brand.getName()));
        }

        if(brandRepository.existsBySlug(brand.getSlug()))
            throw new BusinessException(ErrorCode.BRAND_ALREADY_EXISTS);

        brandRepository.save(brand);
    }

    public void updateBrand(long brandId, BrandUpdateDTO brandUpdateDTO){
        Brand brand = brandRepository.findById(brandId)
                .orElseThrow(() -> new BusinessException(ErrorCode.BRAND_NOT_FOUND));

        brandMapper.updateBrand(brand, brandUpdateDTO);

        String newSlug = SlugUtil.toSlug(brand.getName());

        if(!newSlug.equals(brand.getSlug()) &&
                brandRepository.existsBySlug(newSlug))
            throw new BusinessException(ErrorCode.BRAND_ALREADY_EXISTS);

        brandRepository.save(brand);
    }

    public void deleteBrand(long brandId){
        brandRepository.findById(brandId)
                .orElseThrow(() -> new BusinessException(ErrorCode.BRAND_NOT_FOUND));

        brandRepository.deleteById(brandId);
    }

}
