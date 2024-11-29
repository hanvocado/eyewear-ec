package com.eyewear.services.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eyewear.entities.BranchProduct;
import com.eyewear.repositories.BranchProductRepository;
import com.eyewear.services.BranchProductService;

@Service
public class BranchProductServiceImpl implements BranchProductService{
	@Autowired
	private BranchProductRepository branchProductRepository;
	@Override
	public BranchProduct findById(Long id, Long branch) {
		// TODO Auto-generated method stub
		return branchProductRepository.findByProductIdAndBranchId(id, branch);
	}
	@Override
	public void save(BranchProduct branchProduct) {
		// TODO Auto-generated method stub
		branchProductRepository.save(branchProduct);
	}

}
