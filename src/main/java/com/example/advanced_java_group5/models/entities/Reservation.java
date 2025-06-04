package com.example.advanced_java_group5.models.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

import java.sql.Timestamp;

@Entity
@jakarta.persistence.Table(name = "reservations")
@RequiredArgsConstructor
@Getter
@Setter
public class Reservation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "total_people", nullable = false)
    private Integer totalPeople;

    @Column(nullable = false)
    private String status;

    @Column(name = "reservation_at", nullable = false)
    private Timestamp reservationAt;

    private String note;

    @Column(name = "total_price")
    private Float totalPrice;

    @Column(name = "created_at", nullable = false, updatable = false)
    private Timestamp createdAt;

    @ManyToOne
    @JoinColumn(name = "customer_id", nullable = false)
    private User customer;

    @ManyToOne
    @JoinColumn(name = "table_id")
    private Table table;

    @PrePersist
    protected void onCreate() {
        createdAt = new Timestamp(System.currentTimeMillis());
    }
}
