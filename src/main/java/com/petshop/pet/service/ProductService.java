package com.petshop.pet.service;

import com.petshop.pet.domain.*;
import com.petshop.pet.repository.*;
import com.petshop.pet.utils.SlugUtil;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
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

    private final OrderDetailRepository orderDetailRepository;

    public ProductService(ProductRepository productRepository,
                          BrandRepository brandRepository,
                          SubcategoryRepository subcategoryRepository,
                          CategoryRepository categoryRepository,
                          PetTypeRepository petTypeRepository,
                          OrderDetailRepository orderDetailRepository){
        this.productRepository = productRepository;
        this.brandRepository = brandRepository;
        this.subcategoryRepository = subcategoryRepository;
        this.categoryRepository = categoryRepository;
        this.petTypeRepository = petTypeRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    public List<Product> getAllProductsHomePage(){
        return productRepository.findAll();
    }

    public Page<Product> getAllProducts(Specification<Product> spec,
                                        Pageable page){
        return productRepository.findAll(spec, page);
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
                product.getSubcategory().getPetType().getId())
                .orElseThrow(() -> new RuntimeException("Pet type not found"));
        product.getSubcategory().setPetType(petType);

        product.setCreatedAt(Instant.now());

        if(product.getSlug() == null || product.getSlug().isEmpty()){
            product.setSlug(SlugUtil.toSlug(product.getName()));
        }

        return productRepository.save(product);
    }

    public Product updateProduct(long id, Product productUpdate){
        Product product = productRepository.findById(id).get();

        product.setName(productUpdate.getName());
        product.setDescription(productUpdate.getDescription());
        product.setShortDesc(productUpdate.getShortDesc());
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
                productUpdate.getSubcategory().getPetType().getId())
                .orElseThrow(() -> new RuntimeException("Pet type not found"));
        product.getSubcategory().setPetType(petType);

        product.setUpdatedAt(Instant.now());

        product.setSlug(SlugUtil.toSlug(productUpdate.getName()));

        if(productUpdate.getImageUrl() != null)
            product.setImageUrl(productUpdate.getImageUrl());

        return productRepository.save(product);
    }

    public void deleteProduct(long id){
        productRepository.deleteById(id);
    }

    public Page<Product> getAllPetProducts(String pet,
                                           Specification<Product> spec,
                                           Pageable page,
                                           Double maxPrice){
        Specification<Product> petSpec = (root, query, cb) ->
                cb.equal(root.get("subcategory").get("petType").get("slug"), pet);

        if(spec != null) {
            petSpec = petSpec.and(spec);
        }

        if (maxPrice != null && maxPrice > 0) {
            Specification<Product> priceSpec = (root, query, cb) ->
                    cb.lessThanOrEqualTo(root.get("price"), maxPrice);
            petSpec = petSpec.and(priceSpec);
        }

        return productRepository.findAll(petSpec, page);
    }

    public Page<Product> getAllProductsByPetAndSubcategory(String pet,
                                                           String sub,
                                                           Pageable page,
                                                           Double maxPrice) {
        Specification<Product> petSpec = (root, query, cb) -> cb.and(
                cb.equal(root.get("subcategory").get("petType").get("slug"), pet),
                cb.equal(root.get("subcategory").get("slug"), sub)
        );

        if (maxPrice != null && maxPrice > 0) {
            Specification<Product> priceSpec = (root, query, cb) ->
                    cb.lessThanOrEqualTo(root.get("price"), maxPrice);
            petSpec = petSpec.and(priceSpec);
        }

        return productRepository.findAll(petSpec, page);
    }


    public Product getProductNameBySlug(String slug){
        return productRepository.findBySlug(slug);
    }

    public long countTotalProducts(){
        return productRepository.count();
    }

    public List<Product> getBestSellingProduct(){
        return orderDetailRepository.findBestSellingProducts();
    }

    public Page<Product> searchPetProductsByPet(String pet, String keyword,
                                                Double maxPrice,
                                                Pageable pageable) {
        return productRepository.searchPetProductsByPet(pet, keyword, maxPrice, pageable);
    }

    public Page<Product> searchPetProductsBySubcategory(String pet, String sub,
                                                        String keyword,
                                                        Double maxPrice,
                                                        Pageable pageable) {
        return productRepository.searchPetProductsBySubcategory(pet, sub, keyword, maxPrice, pageable);
    }

}
