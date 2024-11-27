package com.eyewear.entities;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "ShoppingCart")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ShoppingCart {
	 	@Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    private Long cartId;

	    @OneToMany(mappedBy = "shoppingCart", cascade = CascadeType.ALL, orphanRemoval = true)
	    private List<CartItem> cartItems = new ArrayList<>();

	    @OneToOne
	    @JoinColumn(name = "buyer_id", nullable = false)
	    private Buyer buyer; // Mỗi Cart có một buyer
}
