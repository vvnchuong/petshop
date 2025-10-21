package com.petshop.pet.mapper;

import com.petshop.pet.domain.Product;
import com.petshop.pet.domain.dto.ProductCreateDTO;
import com.petshop.pet.domain.dto.ProductUpdateDTO;
import org.mapstruct.AfterMapping;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

import java.time.Instant;

@Mapper(componentModel = "spring")
public interface ProductMapper {

    Product toProduct(ProductCreateDTO productCreateDTO);

    @AfterMapping
    default void setCreatedAt(@MappingTarget Product product){
        if(product.getCreatedAt() == null)
            product.setCreatedAt(Instant.now());
    }

    @Mapping(target = "imageUrl", ignore = true)
    void updateProduct(@MappingTarget Product product,
                       ProductUpdateDTO productUpdateDTO);

    @AfterMapping
    default void setImageUrl(@MappingTarget Product product,
                        ProductUpdateDTO productUpdateDTO){
        if(productUpdateDTO.getImageUrl() != null &&
                !productUpdateDTO.getImageUrl().isEmpty()){
            product.setImageUrl(productUpdateDTO.getImageUrl());
        }
    }

    @AfterMapping
    default void setUpdatedAt(@MappingTarget Product product){
        product.setUpdatedAt(Instant.now());
    }

}
