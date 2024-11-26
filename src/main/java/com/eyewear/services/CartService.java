package com.eyewear.services;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.eyewear.entities.Buyer;
import com.eyewear.entities.CartItem;
import com.eyewear.entities.Product;
import com.eyewear.entities.ShoppingCart;
import com.eyewear.repositories.CartItemRepository;

public interface CartService {

	void deleteAll();

	void cartItem(CartItem entity);



	long count();

	Optional<CartItem> findById(Long id);

	List<CartItem> findAll();

	Page<CartItem> findAll(Pageable pageable);

	List<CartItem> findAll(Sort sort);

	<S extends CartItem> S save(S entity);



	void addCartItem(Buyer buyer, Long productId, int quantity);

	ShoppingCart getOrCreateCart(Buyer buyer);

	Optional<CartItem> findByShoppingCartAndProduct(ShoppingCart cart, Product product);

	Optional<ShoppingCart> findByCartId(Long cartID);

	void delete(CartItem entity);

	void deleteById(Long id);

	
	
}
