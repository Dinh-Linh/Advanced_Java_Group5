package com.example.advanced_java_group5.services;
import com.example.advanced_java_group5.models.entities.Review;
import com.example.advanced_java_group5.models.entities.User;
import com.example.advanced_java_group5.repositories.ReviewRepository;
import com.example.advanced_java_group5.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;

@Service
public class ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Transactional
    public boolean createReview(String name, String email, String phone, String content) {
        try {
            // Kiểm tra các trường bắt buộc
            if (name == null || name.trim().isEmpty() ||
                    email == null || email.trim().isEmpty() ||
                    phone == null || phone.trim().isEmpty() ||
                    content == null || content.trim().isEmpty()) {
                return false;
            }

            // Tìm user hiện có hoặc tạo mới
            User user = userRepository.findByEmailOrPhone(email.trim(), phone.trim());
            if (user == null) {
                user = new User();
                user.setName(name.trim());
                user.setEmail(email.trim());
                user.setPhone(phone.trim());
                user.setRole("customer");
                user.setCreatedAt(new Timestamp(System.currentTimeMillis()));
                user.setPassword(passwordEncoder.encode(phone.trim()));
                user = userRepository.save(user);
            } else if (!user.getName().equals(name.trim())) {
                user.setName(name.trim());
                userRepository.save(user);
            }

            // Tạo review
            Review review = new Review();
            review.setCustomer(user);
            review.setRating(5); // Mặc định 5 sao
            review.setContent(content.trim());
            review.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            reviewRepository.save(review);

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
