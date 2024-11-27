package com.eyewear.DTO;

import java.util.List;

import com.eyewear.entities.BranchProduct;
import com.eyewear.model.ProductModel;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class CartItemDTO {
    private String image;
    private String description;
    private String productType;
    private String brand;
    private String name;
    private double unitPrice;
    private int quantity; // Thuộc về CartItem

   
}

