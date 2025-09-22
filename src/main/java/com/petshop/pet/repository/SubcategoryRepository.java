package com.petshop.pet.repository;

import com.petshop.pet.domain.Subcategory;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SubcategoryRepository extends JpaRepository<Subcategory, Long> {

    Subcategory findById(long id);

}
