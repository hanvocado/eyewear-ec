package com.eyewear.entities;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "categories")
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", nullable = false, unique = true)
    private String name;

    @OneToMany(mappedBy = "category")
    @JsonIgnore // Thêm để tránh vòng lặp tuần hoàn khi gọi toString hoặc chuyển đổi JSON
    private List<Product> products;
    
    @Override
    public String toString() {
        return "Category{id=" + id + ", name='" + name + "'}";
    }
}
