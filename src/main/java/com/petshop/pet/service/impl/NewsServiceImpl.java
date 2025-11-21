package com.petshop.pet.service.impl;

import com.petshop.pet.domain.News;
import com.petshop.pet.domain.User;
import com.petshop.pet.domain.dto.NewsCreateDTO;
import com.petshop.pet.domain.dto.NewsUpdateDTO;
import com.petshop.pet.enums.ErrorCode;
import com.petshop.pet.exception.BusinessException;
import com.petshop.pet.mapper.NewsMapper;
import com.petshop.pet.repository.NewsRepository;
import com.petshop.pet.service.NewsService;
import com.petshop.pet.service.UserService;
import com.petshop.pet.utils.SlugUtil;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NewsServiceImpl implements NewsService {

    private final NewsRepository newsRepository;

    private final UserService userService;

    private final NewsMapper newMapper;

    public NewsServiceImpl(NewsRepository newRepository,
                           UserService userService,
                           NewsMapper newMapper){
        this.newsRepository = newRepository;
        this.userService = userService;
        this.newMapper = newMapper;
    }

    public Page<News> getAllNews(Specification<News> spec,
                                 Pageable page){
        return newsRepository.findAll(spec, page);
    }

    public Page<News> getAllNewsDesc(Specification<News> spec,
                                 Pageable page){

        Pageable pageable = PageRequest.of(page.getPageNumber(), page.getPageSize(),
                Sort.by(Sort.Order.desc("createdAt")));

        return newsRepository.findAll(spec, pageable);
    }

    public News getNewsById(long newsId){
        return newsRepository.findById(newsId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NEWS_NOT_FOUND));
    }

    public News getNewsBySlug(String slug){
        return newsRepository.findBySlug(slug)
                .orElseThrow(() -> new BusinessException(ErrorCode.NEWS_NOT_FOUND));
    }

    public void createNews(NewsCreateDTO newsCreateDTO, String username){
        User user = userService.getUserByUserName(username);
        newsCreateDTO.setUser(user);

        News news = newMapper.toNews(newsCreateDTO);

        if(news.getSlug() == null || news.getSlug().isEmpty())
            news.setSlug(SlugUtil.toSlug(news.getTitle()));

        if(newsRepository.existsBySlug(news.getSlug()))
            throw new BusinessException(ErrorCode.NEWS_ALREADY_EXISTS);

        newsRepository.save(news);
    }

    public void updateNews(NewsUpdateDTO newsUpdateDTO, long newsId, String username){
        News news = newsRepository.findById(newsId)
                .orElseThrow(() -> new BusinessException(ErrorCode.NEWS_NOT_FOUND));

        newMapper.updateNews(news, newsUpdateDTO);

        User user = userService.getUserByUserName(username);
        news.setUser(user);

        String newSlug = SlugUtil.toSlug(news.getTitle());
        if(!newSlug.equals(news.getSlug()) && newsRepository.existsBySlug(newSlug))
            throw new BusinessException(ErrorCode.NEWS_ALREADY_EXISTS);

        news.setSlug(newSlug);

        newsRepository.save(news);
    }

    public void deleteNews(long newsId){
        if(!newsRepository.existsById(newsId))
            throw new BusinessException(ErrorCode.NEWS_NOT_FOUND);

        newsRepository.deleteById(newsId);
    }

    public List<News> getLatestNewsExcept(){
         return newsRepository.findTop3ByOrderByCreatedAtDesc();
    }

    @Override
    public List<News> getFeaturedNews() {
        return newsRepository.findTop6ByOrderByCreatedAtDesc();
    }

}
