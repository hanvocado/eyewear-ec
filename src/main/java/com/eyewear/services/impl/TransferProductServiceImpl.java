package com.eyewear.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.eyewear.entities.GoodsTransferNote;
import com.eyewear.repositories.GoodsTransferNoteRepository;
import com.eyewear.services.TransferProductService;


@Service
public class TransferProductServiceImpl implements TransferProductService {

	@Autowired
	private GoodsTransferNoteRepository noteRepo;
	
	@Override
	public void save(GoodsTransferNote note) {
		if (note != null && note.getProducts().size() > 0) {
			noteRepo.save(note);
		}
	}

	@Override
	public List<GoodsTransferNote> findNotesByImportBranchId(Long id) {
		return noteRepo.findByImportBranchId(id);
	}
	
}
