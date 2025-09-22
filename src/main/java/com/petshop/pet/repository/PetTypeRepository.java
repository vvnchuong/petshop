package com.petshop.pet.repository;

import com.petshop.pet.domain.PetType;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PetTypeRepository extends JpaRepository<PetType, Long> {

    PetType findById(long id);

}
