package com.eyewear.repositories;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.eyewear.entities.Order;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    
    @Query("SELECT o FROM Order o WHERE o.buyer.id = :buyerId ORDER BY o.orderAt DESC")
    List<Order> findAllByBuyerId(@Param("buyerId") Long buyerId);
    
    List<Order> findByBuyerIdAndStatusIn(Long buyerId, List<String> statuses);

    @Query("SELECT o FROM Order o " +
           "LEFT JOIN FETCH o.items i " +
           "LEFT JOIN FETCH i.product p " +
           "WHERE o.orderId = :orderId AND o.buyer.id = :buyerId")
    Optional<Order> findOrderDetailByIdAndBuyerId(
        @Param("orderId") Long orderId, 
        @Param("buyerId") Long buyerId
    );
    
    List<Order> findAllByOrderByOrderAtDesc();
    
    
    
    
 // OrderRepository.java
    @Query("SELECT o FROM Order o WHERE " +
    	       "(:branchId IS NULL OR o.id IN (SELECT od.order.id FROM OrderDetail od WHERE od.product.id IN " +
    	       "(SELECT bp.product.id FROM BranchProduct bp WHERE bp.branch.id = :branchId))) AND " +
    	       "(:productId IS NULL OR EXISTS (SELECT od FROM OrderDetail od WHERE od.order = o AND od.product.id = :productId)) AND " +
    	       "o.orderAt BETWEEN :startDate AND :endDate")
    	List<Order> findOrdersForReport(
    	    @Param("branchId") Long branchId,
    	    @Param("productId") Long productId, 
    	    @Param("startDate") LocalDateTime startDate,
    	    @Param("endDate") LocalDateTime endDate);
    
    
    
 
    
}