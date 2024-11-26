package com.eyewear.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.eyewear.entities.Buyer;
import com.eyewear.entities.ShoppingCart;


@Repository
public interface ShoppingCartRepository extends JpaRepository<ShoppingCart	,Long>{
	Optional<ShoppingCart> findByBuyer(Buyer buyer);
	Optional<ShoppingCart> findByCartId(Long cartID);
}
