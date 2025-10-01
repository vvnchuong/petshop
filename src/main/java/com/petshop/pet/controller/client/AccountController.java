package com.petshop.pet.controller.client;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.User;
import com.petshop.pet.service.UploadService;
import com.petshop.pet.service.UserService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class AccountController {

    private final UserService userService;

    private final UploadService uploadService;

    public AccountController(UserService userService,
                             UploadService uploadService){
        this.userService = userService;
        this.uploadService = uploadService;
    }

    @GetMapping("/account")
    public String getAccountPage(Model model,
                                 @AuthenticationPrincipal CustomUserDetails currentUser){

        User user = userService.getUserByUserName(currentUser.getUsername());
        model.addAttribute("user", user);

        return "client/auth/index";
    }

    @PostMapping("/account/update")
    public String updateProfile(@ModelAttribute("user") User userUpdate,
                                @RequestParam("inputFile") MultipartFile file,
                                @AuthenticationPrincipal CustomUserDetails currentUser){

        String avatar = uploadService.handleUploadFile(file, "avatar", false);
        userUpdate.setAvatarUrl(avatar);

        userService.updateUserByUser(currentUser.getUsername(), userUpdate);

        return "redirect:/account?success";
    }

    @PostMapping("/account/change-password")
    public String changePassword(@RequestParam("oldPassword") String oldPassword,
                                 @RequestParam("newPassword") String newPassword,
                                 @RequestParam("confirmPassword") String confirmPassword,
                                 @AuthenticationPrincipal CustomUserDetails currentUser){

        boolean changed = userService.changePasswordByUser(oldPassword, newPassword,
                confirmPassword, currentUser.getUsername());

        if(!changed)
            return "client/auth/index";

        return "redirect:/account?passwordChanged";
    }

    @GetMapping("/account/login")
    public String getLoginPage(){
        return "client/auth/login";
    }

}
