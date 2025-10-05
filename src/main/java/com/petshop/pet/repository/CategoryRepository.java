package com.petshop.pet.repository;

import com.petshop.pet.domain.Category;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CategoryRepository extends JpaRepository<Category, Long> {

    Category findById(long id);

    List<Category> findDistinctBySubcategoriesPetTypeId(long petTypeId);

}
