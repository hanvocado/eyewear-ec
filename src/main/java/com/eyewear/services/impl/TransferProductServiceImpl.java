package com.eyewear.services.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.eyewear.entities.BranchProduct;
import com.eyewear.entities.GoodsTransferNote;
import com.eyewear.entities.TransferProduct;
import com.eyewear.repositories.BranchProductRepository;
import com.eyewear.repositories.GoodsTransferNoteRepository;
import com.eyewear.services.TransferProductService;

import jakarta.persistence.EntityManager;

@Service
public class TransferProductServiceImpl implements TransferProductService {

	@Autowired
	private GoodsTransferNoteRepository noteRepo;
	
	@Autowired
	private BranchProductRepository branchProductRepo;
	
	@Autowired
	private EntityManager entityManager;
	
	@Override
	public List<GoodsTransferNote> findNotesByImportBranchId(Long id) {
		return noteRepo.findByImportBranchId(id);
	}

	@Override
	@Transactional
	public GoodsTransferNote createNote(Long importBranchId, Long productId, Long exportBranchId, int quantity) {
		BranchProduct branchProduct = branchProductRepo.findByProductIdAndBranchId(productId, exportBranchId);
		if (branchProduct != null && quantity < branchProduct.getQuantity()) {
			GoodsTransferNote newNote = new GoodsTransferNote(importBranchId);
			newNote.request(productId, exportBranchId, quantity);
			noteRepo.save(newNote);
			entityManager.refresh(newNote);
			return newNote;
		}
		return null;
	}

	@Override
	public List<BranchProduct> findProductsByBranchId(Long branchId) {
		return branchProductRepo.findByBranchId(branchId);
	}

	@Override
	public GoodsTransferNote addTransferProduct(Long productId, int quantity, Long noteId) {
		GoodsTransferNote existingNote = noteRepo.findById(noteId).orElse(null);
		if (existingNote != null) {
			TransferProduct productToAdd = new TransferProduct(productId, noteId, quantity);
			existingNote.addTransferProduct(productToAdd);
			noteRepo.save(existingNote);
			return existingNote;
		}
		return null;
	}
	
}
