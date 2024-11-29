package com.eyewear.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BranchModel {
    private Long id;
    private String name;
    
    // Constructor từ Entity
    public BranchModel(com.eyewear.entities.Branch branch) {
        this.id = branch.getId();
        this.name = branch.getName();
    }
}