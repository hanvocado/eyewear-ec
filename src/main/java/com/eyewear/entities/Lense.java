package com.eyewear.entities;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import lombok.Data;

@Data
@Entity
@DiscriminatorValue("LENSE")
public class Lense extends Product {
    private String type; // Loại kính (ví dụ: cận, viễn, loạn)

}
