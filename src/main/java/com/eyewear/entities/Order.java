package com.eyewear.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "orders")
@Getter
@Setter
@NoArgsConstructor
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long orderId;

    @ManyToOne
    @JoinColumn(name = "buyerId", nullable = false)
    private Buyer buyer;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<OrderDetail> items;

    @Column(name = "order_at", nullable = false)
    private LocalDateTime orderAt;

    @Column(name = "total_price", nullable = false)
    private float totalPrice;

    @Column(name = "payment_method", nullable = false)
    private String paymentMethod;

    @Column(name = "status")  
    private String status;

    
}
