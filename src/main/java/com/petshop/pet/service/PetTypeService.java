package com.petshop.pet.service;

import com.petshop.pet.domain.PetType;
import com.petshop.pet.repository.PetTypeRepository;
import org.springframework.stereotype.Service;

@Service
public class PetTypeService {

    private final PetTypeRepository petTypeRepository;

    public PetTypeService(PetTypeRepository petTypeRepository){
        this.petTypeRepository = petTypeRepository;
    }

    public PetType getPetTypeBySlug(String slug){
        return petTypeRepository.findBySlug(slug)
                .orElseThrow(() -> new RuntimeException("Pet type not found"));
    }

}
