package com.example.logistics.company.models;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "statuses")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Status {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;
}
