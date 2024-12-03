package com.eyewear.entities;

import com.eyewear.enums.Role;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import lombok.*;
import lombok.experimental.SuperBuilder;

@Entity
@DiscriminatorValue("ADMIN")
@Getter
@Setter
@SuperBuilder
public class Admin extends User {
	public Admin() {
		super();
	}
	
	@Override
    public String getRole() {
        return Role.ADMIN.name();
    }
}
