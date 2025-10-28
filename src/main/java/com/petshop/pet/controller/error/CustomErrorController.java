package com.petshop.pet.controller.error;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Map;

@Controller
public class CustomErrorController implements ErrorController {

    private static final Map<Integer, String> ERROR_PAGE_MAP = Map.of(
            400, "client/auth/400",
            403, "client/auth/403",
            404, "client/auth/404"
    );

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        if(status != null){
            int statusCode = Integer.parseInt(status.toString());
            return ERROR_PAGE_MAP.getOrDefault(statusCode, "client/auth/error");
        }

        return "client/auth/error";
    }

}
