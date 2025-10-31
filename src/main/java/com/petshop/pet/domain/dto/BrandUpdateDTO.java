package com.petshop.pet.domain.dto;

import com.petshop.pet.domain.Product;
import jakarta.validation.constraints.NotBlank;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.util.ArrayList;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class BrandUpdateDTO {

    @NotBlank(message = "Name is required")
    String name;

    @NotBlank(message = "description is required")
    String description;

    String logoUrl;

    List<Product> products = new ArrayList<>();

}
