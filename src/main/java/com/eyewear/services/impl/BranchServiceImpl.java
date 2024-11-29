package com.eyewear.services.impl;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eyewear.entities.Branch;
import com.eyewear.repositories.BranchRepository;
import com.eyewear.services.BranchService;

@Service
public class BranchServiceImpl implements BranchService{
	@Autowired
	private BranchRepository branchRepository;
	@Override
	public Branch findById(Long id) {
		return branchRepository.findById(id).orElse(null);
	}

}
