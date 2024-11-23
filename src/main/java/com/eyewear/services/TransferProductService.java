package com.eyewear.services;

import java.util.List;

import com.eyewear.entities.BranchProduct;
import com.eyewear.entities.GoodsTransferNote;


public interface TransferProductService {

	List<GoodsTransferNote> findNotesByImportBranchId(Long id);
	
	GoodsTransferNote createNote(Long importBranchId, Long productId, Long exportBranchId, int quantity);
	
	List<BranchProduct> findProductsByBranchId(Long branchId);
	
	GoodsTransferNote addTransferProduct(Long productId, int quantity, Long noteId);
}
