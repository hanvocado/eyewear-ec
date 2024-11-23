package com.eyewear.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "transfer-product")
public class TransferProduct {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	
	@ManyToOne
    @JoinColumn(name = "product_id", nullable = false)
	private Product product;
	
	private int quantity = 0;
	
	@ManyToOne
    @JoinColumn(name = "transfer_note_id", nullable = false)
	private GoodsTransferNote note;
	
	public TransferProduct(Long productId, Long transferNoteId, int quantity) {
	    this.product = new Product();
	    this.product.setId(productId);
	    this.note = new GoodsTransferNote();
	    this.note.setId(transferNoteId);
	    this.quantity = quantity;
	}
}