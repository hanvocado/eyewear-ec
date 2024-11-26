package com.eyewear.entities;

import jakarta.persistence.*;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "frames")
public class Frame {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "product_id", nullable = false) // Liên kết với bảng Products
    private Product product;

    private Double height;
    private Double width;
    private String material;
}
