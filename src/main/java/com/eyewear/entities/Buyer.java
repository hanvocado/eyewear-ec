package com.eyewear.entities;

import java.util.List;

import com.eyewear.enums.Role;

import jakarta.persistence.CascadeType;
import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import lombok.AllArgsConstructor;
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
@NoArgsConstructor
public class Buyer extends User {
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "address_id", referencedColumnName = "id")
    private Address address;

    @OneToMany(mappedBy = "buyer", cascade = CascadeType.ALL)
    private List<Order> orders;

    @OneToMany(mappedBy = "buyer", cascade = CascadeType.ALL)
    private List<Appointment> appointments;

    @OneToOne(mappedBy = "buyer", cascade = CascadeType.ALL, orphanRemoval = true)
    private ShoppingCart shoppingCart; // Một Buyer có một ShoppingCart

    @Override
    public String getRole() {
        return Role.BUYER.name();
    }
}