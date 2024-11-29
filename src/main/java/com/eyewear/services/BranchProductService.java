package com.eyewear.services;

import com.eyewear.entities.BranchProduct;

public interface BranchProductService {

	BranchProduct findById(Long id, Long branch);

	void save(BranchProduct branchProduct);

}
