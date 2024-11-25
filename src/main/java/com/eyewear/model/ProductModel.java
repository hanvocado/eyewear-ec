package com.eyewear.model;

import java.io.Serializable;
import java.util.List;
import com.eyewear.entities.BranchProduct;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ProductModel implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8350339795084866704L;
	
	@Id
	private Long id;
	
	private String name;
	
	private double price;
	
	private String description;
	
	private String brand;
	
	private String image;
	
    private List<BranchProduct> branches;

}
