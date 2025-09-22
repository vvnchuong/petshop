package com.petshop.pet.repository;

import com.petshop.pet.domain.Category;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepository extends JpaRepository<Category, Long> {

    Category findById(long id);

}
