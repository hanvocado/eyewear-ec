package com.eyewear.entities;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
@Entity
@DiscriminatorValue("LENSE")
public class Lense extends Product {
    private String type; // Loại kính (ví dụ: cận, viễn, loạn)

}
