package com.petshop.pet.controller.client;

import com.petshop.pet.domain.News;
import com.petshop.pet.domain.Product;
import com.petshop.pet.service.NewsService;
import com.petshop.pet.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class HomePageController {

    private final ProductService productService;

    private final NewsService newsService;

    public HomePageController(ProductService productService,
                              NewsService newsService) {
        this.productService = productService;
        this.newsService = newsService;
    }

    @GetMapping
    public String getHomePage(Model model){
        Map<Long, List<Product>> products = productService.getBestSellingProduct()
                .stream().collect(Collectors.groupingBy(
                        p -> p.getSubcategory().getCategory().getId()));

        List<News> featuredNews = newsService.getFeaturedNews();

        model.addAttribute("products", products);
        model.addAttribute("featuredNews", featuredNews);

        return "client/homepage/index";
    }

}
