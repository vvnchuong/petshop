package com.petshop.pet.repository;

import com.petshop.pet.domain.News;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;
import java.util.Optional;

public interface NewsRepository extends JpaRepository<News, Long>,
        JpaSpecificationExecutor<News> {

    Optional<News> findBySlug(String slug);

    boolean existsBySlug(String slug);

    List<News> findTop3ByOrderByCreatedAtDesc();

    List<News> findTop6ByOrderByCreatedAtDesc();

}
