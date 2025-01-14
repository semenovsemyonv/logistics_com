package com.example.logistics.company.models;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "vehicles")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Vehicle {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String registrationNumber;

    @Column(nullable = false)
    private String model;

    @ManyToOne
    @JoinColumn(nullable = false)
    private Status status;

    @OneToOne
    @JoinColumn(name = "driver_id", nullable = true)
    private Driver driver;
}
