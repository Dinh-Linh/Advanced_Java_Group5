package com.example.advanced_java_group5.filter;

import com.example.advanced_java_group5.models.entities.User;
import com.example.advanced_java_group5.services.UserService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;


public class AdminAuthFilter extends OncePerRequestFilter {

    private final UserService userService;

    public AdminAuthFilter(UserService userService) {
        this.userService = userService;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        String loginURI = contextPath + "/admin/login";

        // Bỏ qua các URL công khai và tài nguyên tĩnh
        if (requestURI.equals(loginURI) ||
                requestURI.startsWith(contextPath + "/css/") ||
                requestURI.startsWith(contextPath + "/js/") ||
                requestURI.startsWith(contextPath + "/images/") ||
                requestURI.equals(contextPath + "/admin/logout")) {
            filterChain.doFilter(request, response);
            return;
        }

        // Kiểm tra xác thực qua SecurityContext
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        boolean isLoggedIn = false;

        if (authentication != null && authentication.isAuthenticated() && !"anonymousUser".equals(authentication.getPrincipal())) {
            String email = authentication.getName();
            try {
                User dbUser = userService.getUserByEmail(email);
                isLoggedIn = dbUser != null && "admin".equalsIgnoreCase(dbUser.getRole());
            } catch (Exception e) {
                isLoggedIn = false;
            }
        }

        if (isLoggedIn) {
            filterChain.doFilter(request, response);
        } else {
            // Không invalidate session, để Spring Security xử lý
            response.sendRedirect(loginURI + "?error=unauthorized");
        }
    }
}
