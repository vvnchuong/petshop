package com.petshop.pet.service;

import com.petshop.pet.domain.*;
import com.petshop.pet.repository.*;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.List;

@Service
public class ProductService {

    private final ProductRepository productRepository;

    private final BrandRepository brandRepository;

    private final SubcategoryRepository subcategoryRepository;

    private final CategoryRepository categoryRepository;

    private final PetTypeRepository petTypeRepository;

    public ProductService(ProductRepository productRepository,
                          BrandRepository brandRepository,
                          SubcategoryRepository subcategoryRepository,
                          CategoryRepository categoryRepository,
                          PetTypeRepository petTypeRepository){
        this.productRepository = productRepository;
        this.brandRepository = brandRepository;
        this.subcategoryRepository = subcategoryRepository;
        this.categoryRepository = categoryRepository;
        this.petTypeRepository = petTypeRepository;
    }

    public List<Product> getAllProducts(){
        return productRepository.findAll();
    }

    public Product getProductById(long id){
        return productRepository.findById(id).get();
    }

    public Product createProduct(Product product){
        Brand brand = brandRepository.findById(product.getBrand().getId());
        product.setBrand(brand);

        Subcategory subcategory = subcategoryRepository.findById(
                product.getSubcategory().getId());
        product.setSubcategory(subcategory);

        Category category = categoryRepository.findById(
                product.getSubcategory().getCategory().getId());
        product.getSubcategory().setCategory(category);

        PetType petType = petTypeRepository.findById(
                product.getSubcategory().getPetType().getId());
        product.getSubcategory().setPetType(petType);

        product.setCreatedAt(Instant.now());

        return productRepository.save(product);
    }

    public Product updateProduct(long id, Product productUpdate){
        Product product = productRepository.findById(id).get();

        product.setName(productUpdate.getName());
        product.setDescription(productUpdate.getDescription());
        product.setPrice(productUpdate.getPrice());
        product.setStock(productUpdate.getStock());

        Brand brand = brandRepository.findById(productUpdate.getBrand().getId());
        product.setBrand(brand);

        Subcategory subcategory = subcategoryRepository.findById(
                productUpdate.getSubcategory().getId());
        product.setSubcategory(subcategory);

        Category category = categoryRepository.findById(
                productUpdate.getSubcategory().getCategory().getId());
        product.getSubcategory().setCategory(category);

        PetType petType = petTypeRepository.findById(
                productUpdate.getSubcategory().getPetType().getId());
        product.getSubcategory().setPetType(petType);

        product.setUpdatedAt(Instant.now());

        return productRepository.save(product);
    }

    public void deleteProduct(long id){
        productRepository.deleteById(id);
    }

}
