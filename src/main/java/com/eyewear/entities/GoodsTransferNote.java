package com.eyewear.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.eyewear.utils.TransferNoteStatus;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
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
	
	@ManyToOne
    @JoinColumn(name = "import_branch_id", nullable = false)
	private Branch importBranch;
	
	@ManyToOne
    @JoinColumn(name = "export_branch_id", nullable = false)
	private Branch exportBranch;
	
	private LocalDateTime createdAt; 
	
	private LocalDateTime receivedAt;
	
	private TransferNoteStatus status;
	
	@OneToMany(mappedBy = "note", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<TransferProduct> products;
	
	public void addTransferProduct(TransferProduct product) {
		this.products.add(product);
	}
	
	public void removeTransferProduct(TransferProduct product) {
		this.products.remove(product);
	}
	
	public void request(Long productId, Long branchId, int quantity) {
		Branch exportBranch = new Branch();
		exportBranch.setId(branchId);
		this.exportBranch = exportBranch;
		TransferProduct transferProduct = new TransferProduct(productId, this.id, quantity);
		transferProduct.setNote(this);
		this.products = new ArrayList<TransferProduct>();
		this.products.add(transferProduct);
		this.createdAt = LocalDateTime.now();
		this.status = TransferNoteStatus.PENDING;
	}

	public GoodsTransferNote(Long importBranchId) {
		Branch importBranch = new Branch();
		importBranch.setId(importBranchId);
		this.importBranch = importBranch;
	}
	
	@Transient
	public int getTotalQuantity() {
		int total = 0;
		for (TransferProduct transferProduct : products) {
			total += transferProduct.getQuantity();
		}
		return total;
	}
	
	@Transient
	public int getNumberOfProducts() {
		return products.size();
	}
}