package com.petshop.pet.exception;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(BusinessException.class)
    public String handleBusinessException(BusinessException e,
                                          HttpServletRequest request,
                                          RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("error", e.getMessage());

        String referer = request.getHeader("Referer");

        if(referer != null && !referer.isEmpty())
            return "redirect:" + referer;

        return "redirect:/admin/brands";
    }

}
