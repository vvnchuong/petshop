package com.petshop.pet.controller.client;

import com.petshop.pet.domain.News;
import com.petshop.pet.service.impl.NewsService;
import com.turkraft.springfilter.boot.Filter;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/news")
public class NewsController {

    private final NewsService newsService;

    public NewsController(NewsService newsService){
        this.newsService = newsService;
    }

    @GetMapping
    public String getNewsPage(Model model,
                              @Filter Specification<News> spec,
                              @RequestParam(name = "page", defaultValue = "1") int page,
                              @PageableDefault(size = 12) Pageable pageableDefault){

        Pageable pageable = PageRequest.of(page - 1,
                pageableDefault.getPageSize(),
                pageableDefault.getSort());

        Page<News> news = newsService.getAllNewsDesc(spec, pageable);

        model.addAttribute("news", news.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", news.getTotalPages());
        model.addAttribute("totalElements", news.getTotalElements());

        return "client/news/index";
    }

    @GetMapping("/{newsTitle}")
    public String getNewsDetail(@PathVariable("newsTitle") String slug,
                                Model model){

        News newsDetail = newsService.getNewsBySlug(slug);
        model.addAttribute("newsDetail", newsDetail);

        List<News> latest3 = newsService.getLatestNewsExcept();
        model.addAttribute("latestNews", latest3);

        return "client/news/detail";
    }

}
