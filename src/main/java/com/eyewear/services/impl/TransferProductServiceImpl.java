package com.eyewear.services.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eyewear.entities.GoodsTransferNote;
import com.eyewear.repositories.GoodsTransferNoteRepository;
import com.eyewear.services.TransferProductService;

@Service
public class TransferProductServiceImpl implements TransferProductService {

	@Autowired
	private GoodsTransferNoteRepository noteRepo;
	
	public void save(GoodsTransferNote note) {
		if (note != null && note.getProducts().size() > 0) {
			noteRepo.save(note);
		}
	}
}
