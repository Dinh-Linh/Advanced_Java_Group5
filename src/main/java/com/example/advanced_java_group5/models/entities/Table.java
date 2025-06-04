package com.example.advanced_java_group5.models.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Entity
@jakarta.persistence.Table(name = "tables")
@Getter
@Setter
@RequiredArgsConstructor
public class Table {
    @Id
    private Long id;

    private String name;

    private Integer capacity;

    private String status;

    private String location;
}
