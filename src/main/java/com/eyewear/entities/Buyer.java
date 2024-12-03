package com.eyewear.entities;

import java.util.List;

import com.eyewear.enums.Role;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

@Entity
@DiscriminatorValue("BUYER")
@AllArgsConstructor
@Getter
@Setter
@SuperBuilder
public class Buyer extends User {

	@OneToMany(mappedBy = "buyer", cascade = CascadeType.ALL)
    private List<Address> listaddress;


    private String address;
    @OneToMany(mappedBy = "buyer")
    private List<Order> orders;
    
    @OneToMany(mappedBy = "buyer", cascade = CascadeType.ALL)
    private List<Appointment> appointments;

    @OneToOne(mappedBy = "buyer", cascade = CascadeType.ALL, orphanRemoval = true)
    private ShoppingCart shoppingCart; // Một Buyer có một ShoppingCart
    
    public Buyer() {
    	super();
    }
  
    @Override
    public String getRole() {
        return Role.BUYER.name();
    }
}
