package com.petshop.pet.service;

import com.petshop.pet.domain.Category;
import com.petshop.pet.repository.CategoryRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService {

    private final CategoryRepository categoryRepository;

    public CategoryService(CategoryRepository categoryRepository){
        this.categoryRepository = categoryRepository;
    }

    public List<Category> getAllByPetTypeByPetTypeId(long petTypeId){
        return categoryRepository.findDistinctBySubcategoriesPetTypeId(petTypeId);
    }

}
