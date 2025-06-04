package com.example.advanced_java_group5.controllers;

import com.example.advanced_java_group5.models.entities.User;
import com.example.advanced_java_group5.services.AuthService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.SQLException;

@Controller
@RequestMapping("/admin")
public class AuthController {

    @Autowired
    private AuthService authService;

    @GetMapping("/login")
    public String showLoginPage(HttpSession session, Model model) {
        // Check if user is already authenticated
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getPrincipal())) {
            return "redirect:/admin";
        }

        // Get message or error from session (if any)
        String message = (String) session.getAttribute("message");
        String error = (String) session.getAttribute("error");
        if (message != null) {
            model.addAttribute("message", message);
            session.removeAttribute("message");
        }
        if (error != null) {
            model.addAttribute("error", error);
            session.removeAttribute("error");
        }

        return "admin/auth/login"; // Maps to /WEB-INF/views/admin/auth/login.jsp
    }

    @PostMapping("/login")
    public String handleLogin(@RequestParam String email, @RequestParam String password,
                              HttpSession session, Model model) {
        try {
            User user = authService.authenticate(email, password);
            if (user != null) {
                // Set user in session (optional, as Spring Security handles authentication)
                session.setAttribute("adminUser", user);
                session.setMaxInactiveInterval(30 * 60); // 30 minutes
                return "redirect:/admin";
            } else {
                model.addAttribute("error", "Email hoặc mật khẩu không đúng");
                model.addAttribute("email", email);
                return "admin/auth/login";
            }
        } catch (SQLException e) {
            model.addAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            return "admin/auth/login";
        }
    }

    @PostMapping("/logout")
    public String handleLogout(HttpServletRequest request, HttpServletResponse response, Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        model.addAttribute("message", "Đăng xuất thành công");
        return "admin/auth/login";
    }
}
