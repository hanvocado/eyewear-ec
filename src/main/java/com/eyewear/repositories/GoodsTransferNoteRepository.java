package com.eyewear.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.eyewear.entities.GoodsTransferNote;

@Repository
public interface GoodsTransferNoteRepository  extends JpaRepository<GoodsTransferNote, Long>{

}
