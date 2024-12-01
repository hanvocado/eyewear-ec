package com.eyewear.entities;

import java.util.List;

import org.springframework.data.jpa.domain.Specification;

public class ProductSpecification {

    public static Specification<Product> hasCategory(List<String> categories) {
        return (root, query, criteriaBuilder) -> 
            categories != null && !categories.isEmpty() ? 
            root.get("category").get("name").in(categories) : null;
    }

    public static Specification<Product> hasBrand(List<String> brands) {
        return (root, query, criteriaBuilder) -> 
            brands != null && !brands.isEmpty() ? 
                root.get("brand").in(brands) : null;  // Lọc theo nhiều thương hiệu
    }

    public static Specification<Product> isPriceBetween(Double minPrice, Double maxPrice) {
        return (root, query, criteriaBuilder) -> {
            if (minPrice != null && maxPrice != null) {
                return criteriaBuilder.between(root.get("price"), minPrice, maxPrice);
            } else if (minPrice != null) {
                return criteriaBuilder.greaterThanOrEqualTo(root.get("price"), minPrice);
            } else if (maxPrice != null) {
                return criteriaBuilder.lessThanOrEqualTo(root.get("price"), maxPrice);
            }
            return null;
        };
    }  
    public static Specification<Product> filterByCriteria(List<String> categories, List<String> brand, Double minPrice, Double maxPrice) {
        return Specification.where(hasCategory(categories))
                            .and(hasBrand(brand))
                            .and(isPriceBetween(minPrice, maxPrice));
    }
    
}
