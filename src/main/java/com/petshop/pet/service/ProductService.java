package com.petshop.pet.service;

import com.petshop.pet.domain.*;
import com.petshop.pet.domain.dto.ProductCreateDTO;
import com.petshop.pet.domain.dto.ProductUpdateDTO;
import com.petshop.pet.mapper.ProductMapper;
import com.petshop.pet.repository.*;
import com.petshop.pet.utils.SlugUtil;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {

    private final ProductRepository productRepository;

    private final OrderDetailRepository orderDetailRepository;

    private final ProductMapper productMapper;

    public ProductService(ProductRepository productRepository,
                          BrandRepository brandRepository,
                          SubcategoryRepository subcategoryRepository,
                          OrderDetailRepository orderDetailRepository,
                          ProductMapper productMapper){
        this.productRepository = productRepository;
        this.orderDetailRepository = orderDetailRepository;
        this.productMapper = productMapper;
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

    public void createProduct(ProductCreateDTO productCreateDTO){

        Product product = productMapper.toProduct(productCreateDTO);

        if(product.getSlug() == null || product.getSlug().isEmpty()){
            product.setSlug(SlugUtil.toSlug(product.getName()));
        }

        productRepository.save(product);
    }

    public void updateProduct(long productId, ProductUpdateDTO productUpdateDTO){
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        productMapper.updateProduct(product, productUpdateDTO);

        productRepository.save(product);
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
