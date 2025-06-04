package com.example.advanced_java_group5.models.entities;

import jakarta.persistence.*;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "combo_foods")
@RequiredArgsConstructor
@Getter
@Setter
public class ComboFood {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "combo_id", nullable = false)
    private Combo combo;

    @ManyToOne
    @JoinColumn(name = "food_id", nullable = false)
    private Food food;

    @Column(nullable = false)
    private Integer quantity;
}
