package com.eyewear.services;

import org.springframework.core.io.Resource;
import java.time.LocalDateTime;
import java.util.Map;

public interface RevenueService {
	Map<String, Object> getRevenueData(Long branchId, Long productId, LocalDateTime startDate, LocalDateTime endDate);

	Resource generateReportFile(Long branchId, Long productId, LocalDateTime startDate, LocalDateTime endDate,
			String fileType);
}