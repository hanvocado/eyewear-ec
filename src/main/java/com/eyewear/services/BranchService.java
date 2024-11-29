package com.eyewear.services;

import java.util.List;
import java.util.Optional;


import com.eyewear.entities.Branch;

public interface BranchService {

	List<Branch> findAll();
	Branch findById(Long id);

}
