package com.petshop.pet.repository;

import com.petshop.pet.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.time.Instant;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long>,
        JpaSpecificationExecutor<User> {

    Optional<User> findByUsername(String username);

    long countByCreatedAtAfter(Instant createdAt);

    Optional<Object> findByEmail(String email);

}
