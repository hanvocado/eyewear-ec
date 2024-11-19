package com.eyewear.entities;

import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "transfer-notes")
public class GoodsTransferNote {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	private Long importBranchId;
	
	private Long exportBranchId;
	
	private LocalDateTime createdAt; 
	
	private LocalDateTime receivedAt;
	
	private String status;
	
	@OneToMany(mappedBy = "note", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<TransferProduct> products;
	
	public void addTransferProduct(TransferProduct product) {
		this.products.add(product);
	}
	
	public void removeTransferProduct(TransferProduct product) {
		this.products.remove(product);
	}
	
	public void request(Long productId, Long branchId, int quantity) {
		this.exportBranchId = branchId;
		TransferProduct newRequest = new TransferProduct(productId, this.id, quantity);
		this.products.add(newRequest);
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public List<TransferProduct> getProducts() {
		return products;
	}

	public void setProducts(List<TransferProduct> products) {
		this.products = products;
	}
	
	
}