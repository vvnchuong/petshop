package com.petshop.pet.mapper;

import com.petshop.pet.domain.Brand;
import com.petshop.pet.domain.dto.BrandCreateDTO;
import com.petshop.pet.domain.dto.BrandUpdateDTO;
import org.mapstruct.AfterMapping;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

import java.time.Instant;

@Mapper(componentModel = "spring")
public interface BrandMapper {

    Brand toBrand(BrandCreateDTO brandCreateDTO);

    @Mapping(target = "logoUrl", ignore = true)
    void updateBrand(@MappingTarget Brand brand, BrandUpdateDTO brandUpdateDTO);

    @AfterMapping
    default void setCreatedAt(@MappingTarget Brand brand){
        if(brand.getCreatedAt() == null)
            brand.setCreatedAt(Instant.now());
    }

    @AfterMapping
    default void setUpdatedAt(@MappingTarget Brand brand){
        brand.setUpdatedAt(Instant.now());
    }

    @AfterMapping
    default void setBrandUrl(@MappingTarget Brand brand,
                             BrandUpdateDTO brandUpdateDTO){
        if(brandUpdateDTO.getLogoUrl() != null &&
                !brandUpdateDTO.getLogoUrl().isEmpty()){
            brand.setLogoUrl(brandUpdateDTO.getLogoUrl());
        }
    }

}
