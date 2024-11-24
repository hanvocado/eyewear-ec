package com.eyewear.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.eyewear.entities.GoodsTransferNote;

@Repository
public interface GoodsTransferNoteRepository  extends JpaRepository<GoodsTransferNote, Long>{

	List<GoodsTransferNote> findByImportBranchId(Long id);
	
	List<GoodsTransferNote> findByExportBranchId(Long id);
}
