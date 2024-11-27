package com.eyewear.controllers.manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;

import com.eyewear.repositories.BranchRepository;
import com.eyewear.repositories.ProductRepository;
import com.eyewear.services.RevenueService;

import java.time.LocalDate;
import java.time.LocalDateTime;
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
        // Load initial data for form
        model.addAttribute("branches", branchRepository.findAllBranchModels());
        model.addAttribute("products", productRepository.findAll());
        return "manager/revenue-statistic";
    }
    
    @GetMapping("/data")
    public String getRevenueData(
            @RequestParam(required = false) Long branchId,
            @RequestParam(required = false) Long productId,
            @RequestParam(required = true) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
            @RequestParam(required = true) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate,
            Model model) {
        
        try {
            if (startDate != null && endDate != null) {
                // Convert LocalDate to LocalDateTime
                LocalDateTime startDateTime = startDate.atStartOfDay();
                LocalDateTime endDateTime = endDate.atTime(23, 59, 59);
                
                // Get revenue data
                Map<String, Object> result = revenueService.getRevenueData(
                    branchId, productId, startDateTime, endDateTime);
                
                // Add result to model
                model.addAttribute("revenueData", result);
                
                // Add selected filter values back to model
                model.addAttribute("selectedBranchId", branchId);
                model.addAttribute("selectedProductId", productId);
                model.addAttribute("startDate", startDate);
                model.addAttribute("endDate", endDate);
            }
        } catch (Exception e) {
            model.addAttribute("error", "Có lỗi khi tải dữ liệu: " + e.getMessage());
        }
        
        // Reload form data
        model.addAttribute("branches", branchRepository.findAllBranchModels());
        model.addAttribute("products", productRepository.findAll());
        
        return "manager/revenue-statistic";
    }
    
    @PostMapping("/export")
    public ResponseEntity<Resource> exportReport(
            @RequestParam(required = false) Long branchId,
            @RequestParam(required = false) Long productId,
            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate,
            @RequestParam String fileType) {
        
        try {
            LocalDateTime startDateTime = startDate.atStartOfDay();
            LocalDateTime endDateTime = endDate.atTime(23, 59, 59);
            
            Resource file = revenueService.generateReportFile(
                branchId, productId, startDateTime, endDateTime, fileType);
                
            String contentType = fileType.equalsIgnoreCase("excel") 
                ? "application/vnd.ms-excel" 
                : "application/pdf";
                
            String filename = String.format("revenue-report-%s.%s", 
                startDate, fileType.toLowerCase());
            
            return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(contentType))
                .header(HttpHeaders.CONTENT_DISPOSITION, 
                    "attachment; filename=\"" + filename + "\"")
                .body(file);
                
        } catch (Exception e) {
            // Handle error appropriately
            return ResponseEntity.internalServerError().build();
        }
    }
}