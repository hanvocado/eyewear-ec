package com.eyewear.controllers.manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.eyewear.repositories.BranchRepository;
import com.eyewear.repositories.ProductRepository;
import com.eyewear.services.RevenueService;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpHeaders;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/manager/revenue")
public class RevenueStatisticsController {
    
	@Autowired
    private RevenueService revenueService;
    
    @Autowired
    private BranchRepository branchRepository;
    
    @Autowired
    private ProductRepository productRepository;
    
    @GetMapping("")
    public String showRevenuePage(Model model) {
        model.addAttribute("branches", branchRepository.findAll());
        model.addAttribute("products", productRepository.findAll());
        return "manager/revenue-statistic";
    }
    
    @GetMapping("/data")
    @ResponseBody
    public Map<String, Object> getRevenueData(
            @RequestParam(required = false) Long branchId,
            @RequestParam(required = false) Long productId,
            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDateTime startDate,
            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDateTime endDate) {
            
        return revenueService.getRevenueData(branchId, productId, startDate, endDate);
    }
    
    @PostMapping("/export")
    public ResponseEntity<Resource> exportReport(
            @RequestParam(required = false) Long branchId,
            @RequestParam(required = false) Long productId,
            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDateTime startDate,
            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDateTime endDate,
            @RequestParam String fileType) {
            
        Resource file = revenueService.generateReportFile(
            branchId, productId, startDate, endDate, fileType);
            
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + file.getFilename())
                .body(file);
    }
}
