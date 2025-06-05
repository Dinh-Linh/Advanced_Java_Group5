package com.example.advanced_java_group5.controllers.client;

import com.example.advanced_java_group5.services.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/contact")
public class ContactController {

    @Autowired
    private ReviewService reviewService;

    @PostMapping
    public String submitReview(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("phone") String phone,
            @RequestParam("content") String content,
            Model model) {

        try {
            boolean success = reviewService.createReview(name, email, phone, content);

            if (success) {
                model.addAttribute("message", "Đánh giá của bạn đã được gửi thành công!");
                model.addAttribute("status", "success");
            } else {
                model.addAttribute("message", "Có lỗi xảy ra khi gửi đánh giá. Vui lòng thử lại!");
                model.addAttribute("status", "error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("message", e.getMessage());
            model.addAttribute("status", "error");
        }

        return "client/index";
    }
}
