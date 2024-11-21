package com.eyewear.services;

import java.util.List;

import com.eyewear.entities.GoodsTransferNote;

public interface TransferProductService {
	void save(GoodsTransferNote note);
	
	List<GoodsTransferNote> findNotesByImportBranchId(Long id);
}
