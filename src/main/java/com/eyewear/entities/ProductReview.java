package com.eyewear.entities;

import java.io.Serializable;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "productReview")
public class ProductReview implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) // Tự động tăng
	@Column(name = "reviewId")
	private int reviewId;
	
	@ManyToOne
    @JoinColumn(name = "productId", nullable = false) // Khóa ngoại tới bảng Product
    private Product product;

    @ManyToOne
    @JoinColumn(name = "buyerId", nullable = true) // Khóa ngoại tới bảng Buyer
    private Buyer buyer;
	@Column(name="rating")
	private int rating;
	@Column(name="reviewContent", columnDefinition="nvarchar(500)")
	private String reviewContent;
	@Column(name="reviewDate")
	private LocalDate reviewDate;
	
	
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public Buyer getBuyer() {
		return buyer;
	}
	public void setBuyer(Buyer buyer) {
		this.buyer = buyer;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public LocalDate getReviewDate() {
		return reviewDate;
	}
	public void setReviewDate(LocalDate reviewDate) {
		this.reviewDate = reviewDate;
	}
	
	
}
