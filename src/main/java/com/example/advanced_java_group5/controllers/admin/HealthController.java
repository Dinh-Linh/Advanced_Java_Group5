package com.example.advanced_java_group5.controllers.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/admin/health")
public class HealthController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping
    public ResponseEntity<String> checkHealth() {
        try {
            jdbcTemplate.execute("SELECT 1");
            return ResponseEntity.ok("Database connected");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Database not connected");
        }
    }
}
