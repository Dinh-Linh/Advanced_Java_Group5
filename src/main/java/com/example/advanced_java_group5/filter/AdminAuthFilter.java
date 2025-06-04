package com.example.advanced_java_group5.filter;

import com.example.advanced_java_group5.models.entities.User;
import com.example.advanced_java_group5.services.UserService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
        String loginURI = request.getContextPath() + "/admin/login";
        boolean isLoginRequest = request.getRequestURI().equals(loginURI);

        if (isLoginRequest) {
            filterChain.doFilter(request, response);
            return;
        }

        HttpSession session = request.getSession(false);
        User sessionUser = null;
        if (session != null) {
            sessionUser = (User) session.getAttribute("adminUser");
        }

        User dbUser = null;
        if (sessionUser != null) {
            try {
                dbUser = userService.getUserByEmail(sessionUser.getEmail());
            } catch (Exception e) {
                dbUser = null;
            }
        }

        boolean isLoggedIn = dbUser != null && "ADMIN".equals(dbUser.getRole());

        if (isLoggedIn) {
            filterChain.doFilter(request, response);
        } else {
            if (session != null) {
                session.invalidate();
            }
            HttpSession newSession = request.getSession(true);
            newSession.setAttribute("error", "Có ai đó đã thay đổi dữ liệu tài khoản của bạn. Vui lòng đăng nhập lại");
            response.sendRedirect(loginURI);
        }
    }


}
