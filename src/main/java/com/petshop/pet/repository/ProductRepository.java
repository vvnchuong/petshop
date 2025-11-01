package com.petshop.pet.repository;

import com.petshop.pet.domain.CartDetail;
import com.petshop.pet.domain.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface ProductRepository extends JpaRepository<Product, Long>,
        JpaSpecificationExecutor<Product> {

    Optional<Product> findBySlug(String slug);

//    List<Product> findByCartDetails(List<CartDetail> cartDetails);

    List<Product> findByCartDetails_IdIn(List<Long> cartDetailIds);

    List<Product> findByIdIn(List<Long> productIds);

    @Query(value = "SELECT p.id, p.name, p.description, p.short_desc, " +
            "p.price, p.stock, p.image_url, p.created_at, " +
            "p.updated_at, p.slug, p.subcategory_id, p.brand_id " +
            "FROM products p " +
            "JOIN subcategories s ON p.subcategory_id = s.id " +
            "WHERE s.pet_type_id = (SELECT pt.id FROM pet_types pt WHERE pt.slug = :petSlug) " +
            "AND (:maxPrice IS NULL OR p.price <= :maxPrice) " +
            "AND (:keyword IS NULL OR LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%')))",
            countQuery = "SELECT COUNT(*) " +
                    "FROM products p " +
                    "JOIN subcategories s ON p.subcategory_id = s.id " +
                    "WHERE s.pet_type_id = (SELECT pt.id FROM pet_types pt WHERE pt.slug = :petSlug) " +
                    "AND (:maxPrice IS NULL OR p.price <= :maxPrice) " +
                    "AND (:keyword IS NULL OR LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%')))",
            nativeQuery = true)
    Page<Product> searchPetProductsByPet(@Param("petSlug") String petSlug,
                                         @Param("keyword") String keyword,
                                         @Param("maxPrice") Double maxPrice,
                                         Pageable pageable);

    @Query(value = "SELECT p.id, p.name, p.description, p.short_desc, " +
            "p.price, p.stock, p.image_url, p.created_at, " +
            "p.updated_at, p.slug, p.subcategory_id, p.brand_id " +
            "FROM products p " +
            "JOIN subcategories s ON p.subcategory_id = s.id " +
            "WHERE s.pet_type_id = (SELECT pt.id FROM pet_types pt WHERE pt.slug = :petSlug) " +
            "AND s.slug = :subSlug " +
            "AND (:maxPrice IS NULL OR p.price <= :maxPrice) " +
            "AND (:keyword IS NULL OR LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%')))",
            countQuery = "SELECT COUNT(*) " +
                    "FROM products p " +
                    "JOIN subcategories s ON p.subcategory_id = s.id " +
                    "WHERE s.pet_type_id = (SELECT pt.id FROM pet_types pt WHERE pt.slug = :petSlug) " +
                    "AND s.slug = :subSlug " +
                    "AND (:maxPrice IS NULL OR p.price <= :maxPrice) " +
                    "AND (:keyword IS NULL OR LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%')))",
            nativeQuery = true)
    Page<Product> searchPetProductsBySubcategory(@Param("petSlug") String petSlug,
                                                 @Param("subSlug") String subSlug,
                                                 @Param("keyword") String keyword,
                                                 @Param("maxPrice") Double maxPrice,
                                                 Pageable pageable);

    boolean existsBySlug(String productSlug);

    Page<Product> findByBrandSlug(Specification<Product> spec, Pageable page, String brandSlug);

}
