package com.eyewear.entities;

import com.eyewear.enums.Role;
import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.*;
import lombok.experimental.SuperBuilder;

@Entity
@DiscriminatorValue("MANAGER")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class Manager extends User {
    @ManyToOne
    @JoinColumn(name = "branch_id")
    private Branch branch;

    public Long getBranchId() {
        return branch != null ? branch.getId() : null;
    }

    @Override
    public String getRole() {
        return Role.MANAGER.name();
    }
}