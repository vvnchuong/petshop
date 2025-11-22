package com.petshop.pet.repository;

import com.petshop.pet.domain.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface ProductRepository extends JpaRepository<Product, Long>,
        JpaSpecificationExecutor<Product> {

    Optional<Product> findBySlug(String slug);

    List<Product> findByIdIn(List<Long> productIds);

    @Query(value = "SELECT p.* " +
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

    @Query(value = "SELECT p.* " +
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

    @Query(value = "SELECT p.* " +
            "FROM products p " +
            "JOIN brands b " +
            "ON p.brand_id = b.id " +
            "WHERE b.slug = :brandSlug " +
            "AND (:keyword IS NULL OR LOWER(p.name) " +
            "LIKE LOWER(CONCAT('%', :keyword, '%'))) " +
            "AND (:maxPrice IS NULL OR p.price <= :maxPrice)",
            nativeQuery = true)
    Page<Product> searchPetProductByBrand(@Param("brandSlug") String brandSlug,
                                          @Param("keyword") String keyword,
                                          @Param("maxPrice") Double maxPrice,
                                          Pageable pageable);

    boolean existsBySlug(String productSlug);

    @Query(value = "SELECT p.* " +
            "FROM products p " +
            "JOIN order_detail od " +
            "ON p.id = od.product_id " +
            "GROUP BY p.id " +
            "ORDER BY SUM(od.quantity) DESC " +
            "LIMIT 8",
            nativeQuery = true)
    List<Product> findBestSellingProducts();

    @Query(value = "SELECT p.* " +
            "FROM products p " +
            "JOIN subcategories s " +
            "ON p.subcategory_id = s.id " +
            "JOIN categories c " +
            "ON s.category_id = c.id " +
            "JOIN order_detail od " +
            "ON p.id = od.product_id " +
            "WHERE c.name = :categoryName " +
            "AND p.id <> :productId " +
            "GROUP BY p.id " +
            "ORDER BY SUM(od.quantity) DESC " +
            "LIMIT 8", nativeQuery = true)
    List<Product> findRelatedProducts(@Param("categoryName") String categoryName,
                                      @Param("productId") Long productId);

}
