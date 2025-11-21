package com.petshop.pet.service;

import com.petshop.pet.domain.Product;
import com.petshop.pet.domain.dto.ProductCreateDTO;
import com.petshop.pet.domain.dto.ProductUpdateDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;

public interface ProductService {

    Page<Product> getAllProducts(Specification<Product> spec, Pageable page);

    Product getProductById(long id);

    void createProduct(ProductCreateDTO productCreateDTO);

    void updateProduct(long productId, ProductUpdateDTO productUpdateDTO);

    void deleteProduct(long productId);

    Page<Product> getAllPetProducts(String pet, Specification<Product> spec, Pageable page, Double maxPrice);

    Page<Product> getAllProductsByPetAndSubcategory(String pet, String sub, Pageable page, Double maxPrice);

    Product getProductBySlug(String slug);

    List<Product> getBestSellingProduct();

    Page<Product> searchPetProductsByPet(String pet, String keyword, Double maxPrice, Pageable pageable);

    Page<Product> searchPetProductsBySubcategory(String pet, String sub, String keyword, Double maxPrice, Pageable pageable);

    Page<Product> searchPetProductByBrand(String brandSlug, String keyword, Pageable pageable, Double maxPrice);

    Page<Product> getAllProductsByBrand(Specification<Product> spec, Pageable pageable, String brandSlug, Double maxPrice);

}
