package com.example.advanced_java_group5.models.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Entity
@jakarta.persistence.Table(name = "reservation_tables")
@Getter
@Setter
@RequiredArgsConstructor
public class ReservationTable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "reservation_id", nullable = false)
    private Reservation reservation;

    @ManyToOne
    @JoinColumn(name = "table_id", nullable = false)
    private Table table;
}
