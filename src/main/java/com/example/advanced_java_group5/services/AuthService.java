package com.example.advanced_java_group5.services;


import com.example.advanced_java_group5.models.entities.User;
import com.example.advanced_java_group5.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public User authenticate(String email, String password) {
        User user = userRepository.findByEmail(email);
        if (user == null) {
            return null;
        }
        boolean isPasswordCorrect = BCrypt.checkpw(password, user.getPassword());
        boolean isAdmin = "admin".equalsIgnoreCase(user.getRole());
        if (!isAdmin || !isPasswordCorrect) {
            return null;
        }
        return user;
    }

    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }
}
