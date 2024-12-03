package com.eyewear.entities;

import com.eyewear.enums.Role;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import lombok.*;
import lombok.experimental.SuperBuilder;

@Entity
@DiscriminatorValue("MANAGER")
@Getter
@Setter
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
public class Manager extends User {
	private Long branchId;
	
	@Override
    public String getRole() {
        return Role.MANAGER.name();
    }
}
