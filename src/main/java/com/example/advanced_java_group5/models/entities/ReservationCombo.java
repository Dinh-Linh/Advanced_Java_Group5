package com.example.advanced_java_group5.models.entities;

import jakarta.persistence.*;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "reservation_combos")
@Getter
@Setter
@RequiredArgsConstructor
public class ReservationCombo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "reservation_id", nullable = false)
    private Reservation reservation;

    @ManyToOne
    @JoinColumn(name = "combo_id", nullable = false)
    private Combo combo;

    @Column(nullable = false)
    private Integer quantity;
}
