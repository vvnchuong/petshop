package com.petshop.pet.controller.client;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.dto.ChangePasswordDTO;
import com.petshop.pet.domain.dto.RegisterDTO;
import com.petshop.pet.domain.dto.UserUpdateDTO;
import com.petshop.pet.service.impl.PasswordRecoveryService;
import com.petshop.pet.service.impl.UploadService;
import com.petshop.pet.service.impl.UserService;
import jakarta.validation.Valid;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/account")
public class AccountController {

    private final UserService userService;

    private final UploadService uploadService;

    private final PasswordRecoveryService recoveryService;

    public AccountController(UserService userService,
                             UploadService uploadService,
                             PasswordRecoveryService recoveryService){
        this.userService = userService;
        this.uploadService = uploadService;
        this.recoveryService = recoveryService;
    }

    @GetMapping
    public String getAccountPage(Model model,
                                 @AuthenticationPrincipal CustomUserDetails currentUser){

        UserUpdateDTO userDTO = userService.getUserUpdateDTO(currentUser.getUsername());
        model.addAttribute("userDTO", userDTO);

        model.addAttribute("passwordDTO", new ChangePasswordDTO());

        return "client/auth/index";
    }

    @PostMapping("/update")
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

    @PostMapping("/change-password")
    public String changePassword(@Valid @ModelAttribute("passwordDTO")ChangePasswordDTO passwordDTO,
                                 BindingResult bindingResult,
                                 @AuthenticationPrincipal CustomUserDetails currentUser,
                                 Model model){

        if(bindingResult.hasErrors()){
            model.addAttribute("userDTO", userService.getUserUpdateDTO(currentUser.getUsername()));
            return "client/auth/index";
        }

        userService.changePasswordByUser(passwordDTO, currentUser.getUsername());

        return "redirect:/account?passwordChanged";
    }

    @GetMapping("/login")
    public String getLoginPage(Model model){
        if(!model.containsAttribute("registerDTO"))
            model.addAttribute("registerDTO", new RegisterDTO());

        return "client/auth/login";
    }

    @PostMapping("/register")
    public String register(@Valid @ModelAttribute RegisterDTO registerDTO,
                           BindingResult bindingResult,
                           Model model) {

        if(bindingResult.hasErrors()){
            model.addAttribute("register", true);
            return "client/auth/login";
        }

        userService.registerAccount(registerDTO);
        model.addAttribute("success", "Account created successfully!");

        return "client/auth/login";
    }

    @GetMapping("/forgot-password")
    public String forgotPasswordPage(Model model){
        if(!model.containsAttribute("email"))
            model.addAttribute("email", "");

        return "client/auth/forgot-password";
    }

    @PostMapping("/forgot-password")
    public String handleForgotPassword(@RequestParam("email") String email, Model model){
        recoveryService.generateResetToken(email);

        model.addAttribute("message", "Vui lòng kiểm tra email của bạn.");
        model.addAttribute("email", email);

        return "client/auth/forgot-password";
    }

    @GetMapping("/reset-password")
    public String resetPasswordPage(@RequestParam("token") String token, Model model){
        model.addAttribute("token", token);

        return "client/auth/reset-password";
    }

    @PostMapping("/reset-password")
    public String handleResetPassword(@RequestParam("token") String token,
                                      @RequestParam("password") String password,
                                      @RequestParam("confirmPassword") String confirmPassword,
                                      Model model){
        if(password == null || !password.equals(confirmPassword)){
            model.addAttribute("error", "Mật khẩu và xác nhận mật khẩu không khớp");
            model.addAttribute("token", token);
            return "client/auth/reset-password";
        }

        recoveryService.resetPassword(token, password);

        return "redirect:/account/login?resetSuccess";
    }


}
