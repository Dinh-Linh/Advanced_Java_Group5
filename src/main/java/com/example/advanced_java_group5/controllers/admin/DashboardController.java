package com.example.advanced_java_group5.controllers.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class DashboardController {

    @GetMapping({"", "/"})
    public String showDashboard() {
        return "admin/dashboard";
    }
}
