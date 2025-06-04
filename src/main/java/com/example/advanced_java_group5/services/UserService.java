package com.example.advanced_java_group5.services;

import com.example.advanced_java_group5.models.entities.User;
import com.example.advanced_java_group5.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    private boolean isValidVNPhoneNumber(String phone) {
        return phone.matches("(?:(\\+84|0084|0))[235789][0-9]{1,2}[0-9]{7}(?:[^\\d]+|$)");
    }

    private boolean isValidPassword(String password) {
        return password.matches("^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$");
    }

    public boolean comparePassword(String password, String confirmPassword) {
        return password.equals(confirmPassword);
    }

    private void checkValidUser(User user) throws IllegalArgumentException {
        if (!isValidVNPhoneNumber(user.getPhone())) {
            throw new IllegalArgumentException("Số điện thoại phải là số điện thoại Việt Nam hợp lệ");
        }
        if (!isValidPassword(user.getPassword())) {
            throw new IllegalArgumentException("Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt");
        }
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public Page<User> getUsers(int page, int itemsPerPage) {
        return userRepository.findAll(PageRequest.of(page - 1, itemsPerPage));
    }

    public Page<User> getUsersByRole(int page, int itemsPerPage, String role) {
        return userRepository.findByRole(role, PageRequest.of(page - 1, itemsPerPage));
    }

    public long getTotalUsers() {
        return userRepository.count();
    }

    public long getTotalUsersByRole(String role) {
        return userRepository.countByRole(role);
    }

    public User getUserById(Long id) {
        return userRepository.findById(id).orElse(null);
    }

    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public User createUser(User user) {
        checkValidUser(user);
        return userRepository.save(user);
    }

    public User updateUser(User user) {
        checkValidUser(user);
        if (userRepository.existsById(user.getId())) {
            return userRepository.save(user);
        }
        return null;
    }

    public void deleteUser(Long id) {
        userRepository.deleteById(id);
    }

    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public boolean checkEmailExist(User user) {
        return userRepository.checkEmailExist(user.getEmail(), user.getId() != null ? user.getId() : 0);
    }

    public boolean checkPhoneExist(User user) {
        return userRepository.checkPhoneExist(user.getPhone(), user.getId() != null ? user.getId() : 0);
    }

    public Page<User> findByKeyword(String keyword, int page, int itemsPerPage) {
        return userRepository.findByNameEmailPhone(keyword, PageRequest.of(page - 1, itemsPerPage));
    }

    public long getTotalUsersByKeyword(String keyword) {
        return userRepository.countByNameContainingOrEmailContainingOrPhoneContaining(keyword, keyword, keyword);
    }

    public Page<User> findByKeywordWithRole(String keyword, String role, int page, int itemsPerPage) {
        return userRepository.findByNameEmailPhoneWithRole(keyword, role, PageRequest.of(page - 1, itemsPerPage));
    }

    public long getTotalUsersByKeywordWithRole(String keyword, String role) {
        return userRepository.countByNameContainingOrEmailContainingOrPhoneContainingAndRole(keyword, keyword, keyword, role);
    }
}
