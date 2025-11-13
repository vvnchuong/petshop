package com.petshop.pet.service.impl;

import com.petshop.pet.domain.PetType;
import com.petshop.pet.enums.ErrorCode;
import com.petshop.pet.exception.BusinessException;
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
                .orElseThrow(() -> new BusinessException(ErrorCode.PETTYPE_NOT_FOUND));
    }

}
