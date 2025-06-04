package com.example.advanced_java_group5.models.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

import java.sql.Timestamp;

@Entity
@Table(name = "users")
@Getter
@Setter
@RequiredArgsConstructor
public class User {
    @Id
    private Long id;

    private String name;
    private String email;
    private String phone;
    private String password;
    private String role;
    private Timestamp createdAt;
}
