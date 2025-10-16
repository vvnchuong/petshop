package com.petshop.pet.controller.client;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.dto.ChangePasswordDTO;
import com.petshop.pet.domain.dto.RegisterDTO;
import com.petshop.pet.domain.dto.UserUpdateDTO;
import com.petshop.pet.service.UploadService;
import com.petshop.pet.service.UserService;
import jakarta.validation.Valid;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
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

        UserUpdateDTO userDTO = userService.getUserUpdateDTO(currentUser.getUsername());
        model.addAttribute("userDTO", userDTO);

        model.addAttribute("passwordDTO", new ChangePasswordDTO());

        return "client/auth/index";
    }

    @PostMapping("/account/update")
    public String updateProfile(@Valid @ModelAttribute("userDTO") UserUpdateDTO userUpdate,
                                BindingResult bindingResult,
                                @RequestParam("inputFile") MultipartFile file,
                                @AuthenticationPrincipal CustomUserDetails currentUser,
                                Model model){

        if(bindingResult.hasErrors()){
            model.addAttribute("userDTO", userUpdate);
            return "client/auth/index";
        }

        String avatar = uploadService.handleUploadFile(file, "avatar", false);
        userUpdate.setAvatarUrl(avatar);

        userService.updateUserByUser(currentUser.getUsername(), userUpdate);

        return "redirect:/account?success";
    }

    @PostMapping("/account/change-password")
    public String changePassword(@Valid @ModelAttribute("passwordDTO")ChangePasswordDTO passwordDTO,
                                 BindingResult bindingResult,
                                 @AuthenticationPrincipal CustomUserDetails currentUser,
                                 Model model){

        if(bindingResult.hasErrors()){
            model.addAttribute("userDTO", userService.getUserUpdateDTO(currentUser.getUsername()));
            return "client/auth/index";
        }

        try {
            userService.changePasswordByUser(passwordDTO, currentUser.getUsername());
        } catch (RuntimeException e){
            model.addAttribute("error", e.getMessage());
            model.addAttribute("userDTO", userService.getUserUpdateDTO(currentUser.getUsername()));
            return "client/auth/index";
        }

        return "redirect:/account?passwordChanged";
    }

    @GetMapping("/account/login")
    public String getLoginPage(Model model){
        if(!model.containsAttribute("registerDTO")){
            model.addAttribute("registerDTO", new RegisterDTO());
        }

        return "client/auth/login";
    }

    @PostMapping("/account/register")
    public String register(@Valid @ModelAttribute RegisterDTO registerDTO,
                           BindingResult bindingResult,
                           Model model) {

        if(bindingResult.hasErrors()){
            model.addAttribute("register", true);
            return "client/auth/login";
        }

        try {
            userService.registerAccount(registerDTO);
            model.addAttribute("success", "Account created successfully!");
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("register", true);
        }

        return "client/auth/login";
    }


}
