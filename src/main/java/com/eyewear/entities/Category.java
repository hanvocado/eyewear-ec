package com.eyewear.entities;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "categories")
@ToString(exclude = "products")  // Tránh StackOverFlow
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    
    @Column(length=100, nullable = false)
    private String name;
    
    @OneToMany(mappedBy = "category", cascade = CascadeType.ALL, orphanRemoval = true)

    @JsonIgnore // Thêm để tránh vòng lặp tuần hoàn khi gọi toString hoặc chuyển đổi JSON
    private List<Product> products;
    
    @Override
    public String toString() {
        return "Category{id=" + id + ", name='" + name + "'}";
    }
}