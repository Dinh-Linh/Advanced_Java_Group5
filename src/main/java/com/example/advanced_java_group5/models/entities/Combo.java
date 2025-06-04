package com.example.advanced_java_group5.models.entities;

import jakarta.persistence.*;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "combos")
@Getter
@Setter
@RequiredArgsConstructor
public class Combo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private Float price;

    private String description;

    @Column(nullable = false)
    private String status;

    @Column(name = "image_url")
    private String imageUrl;
}
