package com.example.advanced_java_group5.controllers;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin")
public class AuthController {

    @GetMapping("/login")
    public String showLoginPage(Model model,
                                @RequestParam(value = "error", required = false) String error,
                                @RequestParam(value = "logout", required = false) String logout) {
        // Check if user is already authenticated
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getPrincipal())) {
            return "redirect:/admin";
        }

        // Handle error or logout messages from Spring Security
        if (error != null) {
            model.addAttribute("error", "Email hoặc mật khẩu không đúng");
        }
        if (logout != null) {
            model.addAttribute("message", "Đăng xuất thành công");
        }

        return "admin/auth/login"; // Maps to /WEB-INF/views/admin/auth/login.jsp
    }
}
