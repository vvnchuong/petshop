package com.petshop.pet.service;

import com.petshop.pet.domain.Category;

import java.util.List;

public interface CategoryService {

    List<Category> getAllByPetTypeByPetTypeId(long petTypeId);

}
