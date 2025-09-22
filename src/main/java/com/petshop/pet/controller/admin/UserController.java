package com.petshop.pet.controller.admin;

import com.petshop.pet.domain.User;
import com.petshop.pet.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@Controller
public class UserController {

    private final UserService userService;

    public UserController(UserService userService){
        this.userService = userService;
    }

    @GetMapping("/admin/user")
    public String getUserPage(Model model){
        List<User> users = userService.getAllUsers();
        model.addAttribute("users", users);
        return "admin/user/index";
    }

    @GetMapping("/admin/user/{id}")
    public String getUserDetailPage(Model model,
                                    @PathVariable("id") long id){
        User user = userService.getUserById(id);
        model.addAttribute("user", user);
        return "admin/user/detail";
    }

    @GetMapping("/admin/user/create")
    public String getCreateUserPage(Model model){
        model.addAttribute("newUser", new User());
        return "admin/user/create";
    }

    @PostMapping("/admin/user/create")
    public String createUser(Model model,
                             @ModelAttribute("newUser") User user){
        userService.createUser(user);
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/update/{id}")
    public String getUpdateUserPage(Model model,
                                    @PathVariable("id") long id){
        User currentUser = userService.getUserById(id);
        model.addAttribute("newUser", currentUser);
        return "admin/user/update";
    }

    @PostMapping("/admin/user/update/{id}")
    public String updateUser(@PathVariable("id") long id,
                             @ModelAttribute("newUser") User newUser){
        userService.updateUser(id, newUser);
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/delete/{id}")
    public String getDeletUserPage(@PathVariable("id") Long id){
        return "admin/user/delete";
    }

    @PostMapping("/admin/user/delete/{id}")
    public String deleteUser(Model model, @PathVariable("id") Long id){
        this.userService.deleteUser(id);
        return "redirect:/admin/user";
    }

}
