package com.eyewear.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eyewear.entities.BranchProduct;
import com.eyewear.entities.GoodsTransferNote;
import com.eyewear.repositories.BranchProductRepository;
import com.eyewear.repositories.GoodsTransferNoteRepository;
import com.eyewear.services.TransferProductService;

@Service
public class TransferProductServiceImpl implements TransferProductService {

	@Autowired
	private GoodsTransferNoteRepository noteRepo;
	
	@Autowired
	private BranchProductRepository branchProductRepo;
	
	@Override
	public List<GoodsTransferNote> findNotesByImportBranchId(Long id) {
		return noteRepo.findByImportBranchId(id);
	}

	@Override
	public GoodsTransferNote createNote(Long importBranchId, Long productId, Long exportBranchId, int quantity) {
		BranchProduct branchProduct = branchProductRepo.findByProductIdAndBranchId(productId, exportBranchId);
		if (branchProduct != null && quantity < branchProduct.getQuantity()) {
			GoodsTransferNote newNote = new GoodsTransferNote(importBranchId);
			newNote.request(productId, exportBranchId, quantity);
			noteRepo.save(newNote);
			return newNote;
		}
		return null;
	}
	
}
