package com.petshop.pet.controller.admin;

import com.petshop.pet.domain.User;
import com.petshop.pet.domain.dto.AdminCreateUserDTO;
import com.petshop.pet.domain.dto.AdminUpdateDTO;
import com.petshop.pet.service.UploadService;
import com.petshop.pet.service.UserService;
import com.turkraft.springfilter.boot.Filter;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/admin/user")
public class UserController {

    private final UserService userService;

    private final UploadService uploadService;

    public UserController(UserService userService,
                          UploadService uploadService){
        this.userService = userService;
        this.uploadService = uploadService;
    }

    @GetMapping
    public String getUserPage(Model model,
                              @Filter Specification<User> spec,
                              @RequestParam(name = "page", defaultValue = "1") int page,
                              @PageableDefault(size = 5) Pageable pageableDefault){

        Pageable pageable = PageRequest.of(page - 1,
                pageableDefault.getPageSize(),
                pageableDefault.getSort());

        Page<User> users = userService.getAllUsers(spec, pageable);;

        model.addAttribute("users", users.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", users.getTotalPages());
        model.addAttribute("totalElements", users.getTotalElements());

        return "admin/user/index";
    }

    @GetMapping("/{id}")
    public String getUserDetailPage(Model model,
                                    @PathVariable("id") long id){
        User user = userService.getUserById(id);
        model.addAttribute("user", user);
        return "admin/user/detail";
    }

    @GetMapping("/create")
    public String getCreateUserPage(Model model){
        model.addAttribute("newUser", new User());
        return "admin/user/create";
    }

    @PostMapping("/create")
    public String createUser(@Valid @ModelAttribute("newUser") AdminCreateUserDTO userDTO,
                             BindingResult bindingResult,
                             @RequestParam("inputFile") MultipartFile file,
                             Model model){

        if(bindingResult.hasErrors())
            return "admin/user/create";

        String avatar = uploadService.handleUploadFile(file, "avatar", false);
        userDTO.setAvatarUrl(avatar);

        userService.createUser(userDTO);

        return "redirect:/admin/user";
    }

    @GetMapping("/update/{id}")
    public String getUpdateUserPage(Model model,
                                    @PathVariable("id") long id){
        User currentUser = userService.getUserById(id);
        model.addAttribute("newUser", currentUser);
        return "admin/user/update";
    }

    @PostMapping("/update/{id}")
    public String updateUser(@PathVariable("id") long id,
                             @Valid @ModelAttribute("newUser") AdminUpdateDTO adminUpdateDTO,
                             BindingResult bindingResult,
                             @RequestParam("inputFile") MultipartFile file){

        if(bindingResult.hasErrors())
            return "admin/user/update";

        String avatarUpdate = uploadService.handleUploadFile(file, "avatar", false);
        adminUpdateDTO.setAvatarUrl(avatarUpdate);

        userService.updateUserByAdmin(id, adminUpdateDTO);

        return "redirect:/admin/user";
    }

    @GetMapping("/delete/{id}")
    public String getDeleteUserPage(@PathVariable("id") Long id){
        return "admin/user/delete";
    }

    @PostMapping("/delete/{id}")
    public String deleteUser(Model model, @PathVariable("id") Long id){
        this.userService.deleteUser(id);
        return "redirect:/admin/user";
    }

}
