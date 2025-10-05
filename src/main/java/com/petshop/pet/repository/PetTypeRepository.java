package com.petshop.pet.repository;

import com.petshop.pet.domain.PetType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface PetTypeRepository extends JpaRepository<PetType, Long> {

    Optional<PetType> findBySlug(String slug);

}
