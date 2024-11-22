package com.eyewear.services;

import com.eyewear.entities.Order;

public interface OrderService {
	<S extends Order> S placeOrder(S entity);
}
