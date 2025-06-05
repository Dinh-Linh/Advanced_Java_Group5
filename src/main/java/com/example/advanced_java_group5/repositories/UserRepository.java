package com.example.advanced_java_group5.repositories;

import com.example.advanced_java_group5.models.entities.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UserRepository extends JpaRepository<User, Long> {

    // Tìm user theo email
    User findByEmail(String email);

    // Tìm user theo email hoặc phone
    User findByEmailOrPhone(String email, String phone);

    // Kiểm tra email tồn tại, ngoại trừ user có ID chỉ định
    @Query("SELECT COUNT(u) FROM User u WHERE u.email = :email AND u.id != :id")
    boolean checkEmailExist(@Param("email") String email, @Param("id") Long id);

    // Kiểm tra phone tồn tại, ngoại trừ user có ID chỉ định
    @Query("SELECT COUNT(u) FROM User u WHERE u.phone = :phone AND u.id != :id")
    boolean checkPhoneExist(@Param("phone") String phone, @Param("id") Long id);

    // Tìm user theo tên, email, hoặc phone với phân trang
    @Query("SELECT u FROM User u WHERE u.name LIKE %:keyword% OR u.email LIKE %:keyword% OR u.phone LIKE %:keyword%")
    Page<User> findByNameEmailPhone(@Param("keyword") String keyword, Pageable pageable);

    // Tìm user theo tên, email, hoặc phone và role với phân trang
    @Query("SELECT u FROM User u WHERE (u.name LIKE %:keyword% OR u.email LIKE %:keyword% OR u.phone LIKE %:keyword%) AND u.role = :role")
    Page<User> findByNameEmailPhoneWithRole(@Param("keyword") String keyword, @Param("role") String role, Pageable pageable);

    // Lấy user theo role với phân trang
    Page<User> findByRole(String role, Pageable pageable);

    @Query("SELECT COUNT(u) FROM User u WHERE u.role = :role")
    long countByRole(@Param("role") String role);

    @Query("SELECT COUNT(u) FROM User u WHERE u.name LIKE %:keyword% OR u.email LIKE %:keyword% OR u.phone LIKE %:keyword%")
    long countByNameContainingOrEmailContainingOrPhoneContaining(@Param("keyword") String keyword1, @Param("keyword") String keyword2, @Param("keyword") String keyword3);

    @Query("SELECT COUNT(u) FROM User u WHERE (u.name LIKE %:keyword% OR u.email LIKE %:keyword% OR u.phone LIKE %:keyword%) AND u.role = :role")
    long countByNameContainingOrEmailContainingOrPhoneContainingAndRole(@Param("keyword") String keyword1, @Param("keyword") String keyword2, @Param("keyword") String keyword3, @Param("role") String role);
}
