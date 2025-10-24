package com.petshop.pet.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Bean
    public ViewResolver viewResolver() {

        final InternalResourceViewResolver bean = new InternalResourceViewResolver();
        bean.setViewClass(JstlView.class);
        bean.setPrefix("/WEB-INF/view/");
        bean.setSuffix(".jsp");
        return bean;
    }
    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        registry.viewResolver(viewResolver());
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
//        registry.addResourceHandler("/css/**").addResourceLocations("/resources/css/");
//        registry.addResourceHandler("/js/**").addResourceLocations("/resources/js/");
        registry.addResourceHandler("/images/**").addResourceLocations("/resources/images/");
        registry.addResourceHandler("/client/**").addResourceLocations("/resources/client/");
        registry.addResourceHandler("/admin/**").addResourceLocations("/resources/admin/");
    }

}
//package com.petshop.pet.filter;
//
//import jakarta.servlet.*;
//        import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletRequestWrapper;
//import org.springframework.stereotype.Component;
//
//import java.io.IOException;
//
//@Component
//public class TinTucRewriteFilter implements Filter {
//
//    @Override
//    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
//        HttpServletRequest httpRequest = (HttpServletRequest) request;
//        String requestURI = httpRequest.getRequestURI();
//
//        if (requestURI.startsWith("/tin-tuc")) {
//            // Tạo wrapper thay đổi URI thành /news
//            HttpServletRequestWrapper wrapper = new HttpServletRequestWrapper(httpRequest) {
//                @Override
//                public String getRequestURI() {
//                    return requestURI.replaceFirst("/tin-tuc", "/news");
//                }
//
//                @Override
//                public String getServletPath() {
//                    return getRequestURI();
//                }
//            };
//            chain.doFilter(wrapper, response);
//        } else {
//            chain.doFilter(request, response);
//        }
//    }
//}
