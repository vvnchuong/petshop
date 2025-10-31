package com.petshop.pet.repository;

import com.petshop.pet.domain.Brand;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import javax.swing.text.html.Option;
import java.util.Optional;

public interface BrandRepository extends JpaRepository<Brand, Long>,
        JpaSpecificationExecutor<Brand> {

    boolean existsBySlug(String slug);

    Optional<Brand> findBySlug(String slug);

}
