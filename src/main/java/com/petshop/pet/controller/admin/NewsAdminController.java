package com.petshop.pet.controller.admin;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.News;
import com.petshop.pet.domain.dto.NewsCreateDTO;
import com.petshop.pet.domain.dto.NewsUpdateDTO;
import com.petshop.pet.service.NewsService;
import com.petshop.pet.service.UploadService;
import com.turkraft.springfilter.boot.Filter;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/admin/news")
public class NewsAdminController {

    private final NewsService newsService;

    private final UploadService uploadService;

    public NewsAdminController(NewsService newsService,
                               UploadService uploadService){
        this.newsService = newsService;
        this.uploadService = uploadService;
    }

    @GetMapping
    public String getNewsPage(Model model,
                              @Filter Specification<News> spec,
                              @RequestParam(name = "page", defaultValue = "1") int page,
                              @PageableDefault(size = 5) Pageable pageableDefault){

        Pageable pageable = PageRequest.of(page - 1,
                pageableDefault.getPageSize(),
                pageableDefault.getSort());

        Page<News> news = newsService.getAllNews(spec, pageable);

        model.addAttribute("news", news.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", news.getTotalPages());
        model.addAttribute("totalElements", news.getTotalElements());

        return "admin/news/index";
    }

    @GetMapping("/{id}")
    public String getNewsDetailPage(@PathVariable("id") long newsId,
                                    Model model){

        News news = newsService.getNewsById(newsId);
        model.addAttribute("news",news);

        return "admin/news/detail";
    }

    @GetMapping("/create")
    public String getCreateNewsPage(Model model){
        model.addAttribute("news", new NewsCreateDTO());
        return "admin/news/create";
    }

    @PostMapping("/create")
    public String createNews(@Valid @ModelAttribute("news") NewsCreateDTO newsCreateDTO,
                             BindingResult bindingResult,
                             @RequestParam("inputFile") MultipartFile file,
                             @AuthenticationPrincipal CustomUserDetails currentUser){

        if(bindingResult.hasErrors())
            return "admin/news/create";

        String thumbnail = uploadService.handleUploadFile(file, "thumbnail", true);
        newsCreateDTO.setThumbnail(thumbnail);

        newsService.createNews(newsCreateDTO, currentUser.getUsername());

        return "redirect:/admin/news";
    }

    @PostMapping("/upload-image")
    @ResponseBody
    public Map<String, Object> uploadEditorImage(@RequestParam("upload") MultipartFile uploadFile) {
        String savedFilename = uploadService.handleUploadFile(uploadFile, "news", true);

        String url = "/admin/images/news/" + savedFilename;

        Map<String, Object> resp = new HashMap<>();
        resp.put("uploaded", 1);
        resp.put("url", url);
        resp.put("default", url);
        resp.put("url", url);
        return resp;
    }

    @GetMapping("/update/{id}")
    public String getUpdateNewsPage(@PathVariable("id") long newsId,
                                    Model model){

        News news = newsService.getNewsById(newsId);
        model.addAttribute("news", news);

        return "admin/news/update";
    }

    @PostMapping("/update/{id}")
    public String updateNews(@PathVariable("id") long newsId,
                             @Valid @ModelAttribute("news") NewsUpdateDTO newsUpdateDTO,
                             BindingResult bindingResult,
                             @RequestParam("inputFile") MultipartFile file,
                             @AuthenticationPrincipal CustomUserDetails currentUser,
                             Model model){

        if(bindingResult.hasErrors())
            return "admin/news/update";

        String thumbnail = uploadService.handleUploadFile(file, "thumbnail", false);
        newsUpdateDTO.setThumbnail(thumbnail);

        newsService.updateNews(newsUpdateDTO, newsId, currentUser.getUsername());

        return "redirect:/admin/news";
    }

    @GetMapping("/delete/{id}")
    public String getDeleteNewsPage(@PathVariable("id") long newsId){
        return "admin/news/delete";
    }

    @PostMapping("/delete/{id}")
    public String deleteNews(@PathVariable("id") long newsId){
        newsService.deleteNews(newsId);
        return "redirect:/admin/news";
    }

}
