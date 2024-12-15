package com.eyewear.entities;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
@AllArgsConstructor
@Entity
@DiscriminatorValue("FRAME")
public class Frame extends Product {
    private String material; // Chất liệu
    private String shape;    // Hình dạng
    private double height;   // Chiều cao
    private double width;    // Chiều rộng
}

