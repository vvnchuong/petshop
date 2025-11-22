package com.petshop.pet.service.impl;

import com.petshop.pet.domain.*;
import com.petshop.pet.domain.dto.ProductCreateDTO;
import com.petshop.pet.domain.dto.ProductUpdateDTO;
import com.petshop.pet.enums.ErrorCode;
import com.petshop.pet.exception.BusinessException;
import com.petshop.pet.mapper.ProductMapper;
import com.petshop.pet.repository.*;
import com.petshop.pet.service.ProductService;
import com.petshop.pet.utils.SlugUtil;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {

    private final ProductRepository productRepository;

    private final OrderDetailRepository orderDetailRepository;

    private final ProductMapper productMapper;

    public ProductServiceImpl(ProductRepository productRepository,
                              OrderDetailRepository orderDetailRepository,
                              ProductMapper productMapper){
        this.productRepository = productRepository;
        this.orderDetailRepository = orderDetailRepository;
        this.productMapper = productMapper;
    }

    @Override
    public Page<Product> getAllProducts(Specification<Product> spec,
                                        Pageable page){
        return productRepository.findAll(spec, page);
    }

    @Override
    public Product getProductById(long id){
        return productRepository.findById(id).
                orElseThrow(() -> new BusinessException(ErrorCode.PRODUCT_NOT_FOUND));
    }

    @Override
    public void createProduct(ProductCreateDTO productCreateDTO){

        Product product = productMapper.toProduct(productCreateDTO);

        if(product.getSlug() == null || product.getSlug().isEmpty())
            product.setSlug(SlugUtil.toSlug(product.getName()));

        if(productRepository.existsBySlug(product.getSlug()))
            throw new BusinessException(ErrorCode.PRODUCT_ALREADY_EXISTS);

        productRepository.save(product);
    }

    @Override
    public void updateProduct(long productId, ProductUpdateDTO productUpdateDTO){
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new BusinessException(ErrorCode.PRODUCT_NOT_FOUND));

        productMapper.updateProduct(product, productUpdateDTO);

        String newSlug = SlugUtil.toSlug(product.getName());

        if(!newSlug.equals(product.getSlug()) && productRepository.existsBySlug(newSlug))
            throw new BusinessException(ErrorCode.PRODUCT_ALREADY_EXISTS);

        product.setSlug(newSlug);

        productRepository.save(product);
    }

    @Override
    public void deleteProduct(long productId){
        boolean existsInOrder = orderDetailRepository.existsByProductId(productId);
        if(existsInOrder)
            throw new BusinessException(ErrorCode.PRODUCT_ALREADY_ORDERED);
        productRepository.deleteById(productId);
    }

    public Page<Product> getAllPetProducts(String pet,
                                           Specification<Product> spec,
                                           Pageable page,
                                           Double maxPrice){
        Specification<Product> petSpec = (root, query, cb) ->
                cb.equal(root.get("subcategory").get("petType").get("slug"), pet);

        if(spec != null)
            petSpec = petSpec.and(spec);

        if(maxPrice != null && maxPrice > 0){
            Specification<Product> priceSpec = (root, query, cb) ->
                    cb.lessThanOrEqualTo(root.get("price"), maxPrice);
            petSpec = petSpec.and(priceSpec);
        }

        return productRepository.findAll(petSpec, page);
    }

    @Override
    public Page<Product> getAllProductsByPetAndSubcategory(String pet,
                                                           String sub,
                                                           Pageable page,
                                                           Double maxPrice) {
        Specification<Product> petSpec = (root, query, cb) -> cb.and(
                cb.equal(root.get("subcategory").get("petType").get("slug"), pet),
                cb.equal(root.get("subcategory").get("slug"), sub)
        );

        if(maxPrice != null && maxPrice > 0){
            Specification<Product> priceSpec = (root, query, cb) ->
                    cb.lessThanOrEqualTo(root.get("price"), maxPrice);
            petSpec = petSpec.and(priceSpec);
        }

        return productRepository.findAll(petSpec, page);
    }

    @Override
    public Product getProductBySlug(String slug){
        return productRepository.findBySlug(slug)
                .orElseThrow(() -> new BusinessException(ErrorCode.PRODUCT_NOT_FOUND));
    }

    @Override
    public List<Product> getBestSellingProduct(){
        return productRepository.findBestSellingProducts();
    }

    @Override
    public Page<Product> searchPetProductsByPet(String pet, String keyword,
                                                Double maxPrice,
                                                Pageable pageable){
        return productRepository.searchPetProductsByPet(pet, keyword, maxPrice, pageable);
    }

    @Override
    public Page<Product> searchPetProductsBySubcategory(String pet, String sub,
                                                        String keyword,
                                                        Double maxPrice,
                                                        Pageable pageable){
        return productRepository.searchPetProductsBySubcategory(pet, sub, keyword, maxPrice, pageable);
    }

    @Override
    public Page<Product> searchPetProductByBrand(String brandSlug, String keyword, Pageable pageable, Double maxPrice) {
        return productRepository.searchPetProductByBrand(brandSlug, keyword,maxPrice, pageable);
    }

    @Override
    public Page<Product> getAllProductsByBrand(Specification<Product> spec,
                                               Pageable pageable,
                                               String brandSlug,
                                               Double maxPrice){

        Specification<Product> brandSpec = (root, query, cb) ->
                cb.equal(root.get("brand").get("slug"), brandSlug);

        if (maxPrice != null && maxPrice > 0) {
            Specification<Product> priceSpec = (root, query, cb) ->
                    cb.lessThanOrEqualTo(root.get("price"), maxPrice);

            brandSpec = brandSpec.and(priceSpec);
        }

        return productRepository.findAll(brandSpec, pageable);
    }

    @Override
    public List<Product> getRelatedProducts(Product productDetail) {
        String categoryName = productDetail.getSubcategory().getCategory().getName();
        Long productId = productDetail.getId();

        return productRepository.findRelatedProducts(categoryName, productId);
    }


}
