package com.eyewear.services;

import org.springframework.core.io.Resource;

import com.itextpdf.text.DocumentException;

import java.io.IOException;
import java.io.OutputStream;
import java.time.LocalDateTime;
import java.util.Map;

public interface RevenueService {
    Map<String, Object> getRevenueData(Long branchId, Long productId, LocalDateTime startDate, LocalDateTime endDate);
    
    void writeReportToStream(Long branchId, Long productId, LocalDateTime startDate, LocalDateTime endDate, 
            String fileType, OutputStream outputStream) throws IOException, DocumentException;
}