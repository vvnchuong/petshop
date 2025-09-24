package com.petshop.pet.repository;

import com.petshop.pet.domain.Product;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Long> {

    List<Product> findBySubcategoryPetTypeSlug(String pet);
    List<Product> findBySubcategoryPetTypeSlugAndSubcategorySlug(String pet, String subcategory);

}
