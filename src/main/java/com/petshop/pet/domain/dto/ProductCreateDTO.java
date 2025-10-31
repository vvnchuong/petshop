package com.petshop.pet.domain.dto;

import com.petshop.pet.domain.Brand;
import com.petshop.pet.domain.Subcategory;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@AllArgsConstructor
@NoArgsConstructor
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ProductCreateDTO {

    @NotBlank(message = "Product name is required")
    String name;

    @NotBlank(message = "Description is required")
    String description;

    @NotBlank(message = "Short description is required")
    String shortDesc;

    @NotNull(message = "Price is required")
    @Positive(message = "Price must be positive")
    Double price;

    @NotNull(message = "Stock is required")
    @Min(value = 1, message = "Stock must be >= 1")
    Integer stock;

    String imageUrl;

    Subcategory subcategory;

    Brand brand;

}
