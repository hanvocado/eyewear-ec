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
    @JoinColumn(name = "buyer_id")  // Đổi thành buyer_id
    private Buyer buyer;  // Đổi thành buyer

    @OneToMany(mappedBy = "order")
    private List<OrderDetail> items;

    @Column(name = "created_at")
    private LocalDateTime orderAt;

    @Column(name = "total_price")
    private Double totalPrice;

    @Column(name = "payment_method")
    private String paymentMethod;

    @Column(name = "status")  
    private String status;

    
}
