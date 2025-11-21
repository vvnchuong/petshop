package com.petshop.pet.service;

import com.petshop.pet.domain.News;
import com.petshop.pet.domain.dto.NewsCreateDTO;
import com.petshop.pet.domain.dto.NewsUpdateDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;

public interface NewsService {

    Page<News> getAllNews(Specification<News> spec, Pageable page);

    Page<News> getAllNewsDesc(Specification<News> spec, Pageable page);

    News getNewsById(long newsId);

    News getNewsBySlug(String slug);

    void createNews(NewsCreateDTO newsCreateDTO, String username);

    void updateNews(NewsUpdateDTO newsUpdateDTO, long newsId, String username);

    void deleteNews(long newsId);

    List<News> getLatestNewsExcept();

    List<News> getFeaturedNews();

}
