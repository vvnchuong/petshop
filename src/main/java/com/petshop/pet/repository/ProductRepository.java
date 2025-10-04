package com.petshop.pet.repository;

import com.petshop.pet.domain.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Long>,
        JpaSpecificationExecutor<Product> {

    Page<Product> findBySubcategoryPetTypeSlug(String pet,
                                               Specification<Product> spec,
                                               Pageable page);

    List<Product> findBySubcategoryPetTypeSlugAndSubcategorySlug(String pet, String subcategory);

    Product findBySlug(String slug);

}
