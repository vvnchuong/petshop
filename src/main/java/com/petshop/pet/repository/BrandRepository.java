package com.petshop.pet.repository;

import com.petshop.pet.domain.Brand;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BrandRepository extends JpaRepository<Brand, Long> {

    Brand findById(long id);

}
