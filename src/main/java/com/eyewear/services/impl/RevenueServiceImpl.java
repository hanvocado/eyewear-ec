package com.eyewear.services.impl;

import com.eyewear.entities.Order;
import com.eyewear.entities.OrderDetail;
import com.eyewear.repositories.OrderRepository;
import com.eyewear.repositories.BranchRepository;
import com.eyewear.repositories.ProductRepository;
import com.eyewear.services.RevenueService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Transactional
public class RevenueServiceImpl implements RevenueService {
    
    @Autowired
    private OrderRepository orderRepository;
    
    @Autowired
    private BranchRepository branchRepository;
    
    @Autowired
    private ProductRepository productRepository;
    
    @Override
    public Map<String, Object> getRevenueData(
            Long branchId, 
            Long productId, 
            LocalDateTime startDate, 
            LocalDateTime endDate) {
            
        Map<String, Object> result = new HashMap<>();
        
        // Lấy dữ liệu đơn hàng theo filter
        List<Order> orders = orderRepository.findOrdersForReport(
            branchId, productId, startDate, endDate);
        
        // Xử lý dữ liệu cho biểu đồ
        List<Map<String, Object>> chartData = processChartData(orders);
        
        // Tính toán tổng doanh thu
        double totalRevenue = calculateTotalRevenue(orders);
        
        // Thống kê theo sản phẩm nếu có yêu cầu
        if (productId != null) {
            Map<String, Object> productStats = calculateProductStatistics(orders, productId);
            result.put("productStatistics", productStats);
        }
        
        // Thống kê theo chi nhánh nếu có yêu cầu
        if (branchId != null) {
            Map<String, Object> branchStats = calculateBranchStatistics(orders, branchId);
            result.put("branchStatistics", branchStats);
        }
        
        result.put("chartData", chartData);
        result.put("totalRevenue", totalRevenue);
        
        return result;
    }
    
    @Override
    public Resource generateReportFile(
            Long branchId, 
            Long productId, 
            LocalDateTime startDate, 
            LocalDateTime endDate, 
            String fileType) {
            
        try {
            // Lấy dữ liệu thống kê
            Map<String, Object> data = getRevenueData(branchId, productId, startDate, endDate);
            
            // Tạo file báo cáo theo định dạng yêu cầu
            if ("excel".equals(fileType)) {
                return generateExcelReport(data);
            } else if ("pdf".equals(fileType)) {
                return generatePdfReport(data);
            }
            
            throw new IllegalArgumentException("Không hỗ trợ loại file: " + fileType);
            
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi tạo file báo cáo", e);
        }
    }
    
    private List<Map<String, Object>> processChartData(List<Order> orders) {
        return orders.stream()
            .collect(Collectors.groupingBy(
                order -> order.getOrderAt().toLocalDate(),
                TreeMap::new,
                Collectors.summingDouble(Order::getTotalPrice)))
            .entrySet().stream()
            .map(entry -> {
                Map<String, Object> point = new HashMap<>();
                point.put("date", entry.getKey().toString());
                point.put("revenue", entry.getValue());
                return point;
            })
            .collect(Collectors.toList());
    }

    private Map<String, Object> calculateProductStatistics(List<Order> orders, Long productId) {
        Map<String, Object> stats = new HashMap<>();
        
        double totalRevenue = orders.stream()
            .flatMap(order -> order.getItems().stream())
            .filter(item -> item.getProduct().getId().equals(productId))
            .mapToDouble(item -> item.getQuantity() * item.getPrice())
            .sum();
            
        long totalQuantity = orders.stream()
            .flatMap(order -> order.getItems().stream())
            .filter(item -> item.getProduct().getId().equals(productId))
            .mapToLong(OrderDetail::getQuantity)
            .sum();
        
        stats.put("totalRevenue", totalRevenue);
        stats.put("totalQuantity", totalQuantity);
        return stats;
    }

    private Map<String, Object> calculateBranchStatistics(List<Order> orders, Long branchId) {
        // Cần thêm relationship với Branch hoặc sửa đổi query để lấy thông tin branch
        Map<String, Object> stats = new HashMap<>();
        double totalRevenue = 0;
        long orderCount = orders.size();
        
        stats.put("totalRevenue", totalRevenue);
        stats.put("orderCount", orderCount);
        return stats;
    }
    
    private double calculateTotalRevenue(List<Order> orders) {
        return orders.stream()
            .mapToDouble(Order::getTotalPrice)
            .sum();
    }
    
   
    private Resource generateExcelReport(Map<String, Object> data) {
        // Tạo file Excel từ dữ liệu thống kê
        // TODO: Implement logic tạo file Excel
        return null;
    }
    
    private Resource generatePdfReport(Map<String, Object> data) {
        // Tạo file PDF từ dữ liệu thống kê
        // TODO: Implement logic tạo file PDF
        return null;
    }
}