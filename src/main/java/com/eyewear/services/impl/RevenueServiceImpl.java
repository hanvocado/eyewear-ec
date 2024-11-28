package com.eyewear.services.impl;

//Spring & core imports
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

//Project imports
import com.eyewear.entities.*;
import com.eyewear.repositories.*;
import com.eyewear.services.RevenueService;

//iText PDF imports
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

//Apache POI imports
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

//Java core imports
import java.io.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.*;

//Rest of the implementation remains the same

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
   public Map<String, Object> getRevenueData(Long branchId, Long productId, LocalDateTime startDate, LocalDateTime endDate) {
      Map<String, Object> result = new HashMap<>();
      List<Order> orders = orderRepository.findOrdersForReport(branchId, productId, startDate, endDate);

      // Get branch name
      String branchName = branchId == null ? "Tất cả chi nhánh" : 
          branchRepository.findById(branchId).map(Branch::getName).orElse("Không xác định");
          
      // Get product name  
      String productName = productId == null ? "Tất cả sản phẩm" :
          productRepository.findById(productId).map(Product::getName).orElse("Không xác định");

      result.put("branchName", branchName);
      result.put("productName", productName);
      result.put("chartData", processChartData(orders));
      result.put("totalRevenue", orders.stream().mapToDouble(Order::getTotalPrice).sum());

      return result;  
   }

   private List<Map<String, Object>> processChartData(List<Order> orders) {
	    Map<LocalDate, Double> dailyRevenue = new TreeMap<>();
	    
	    for (Order order : orders) {
	        LocalDate date = order.getOrderAt().toLocalDate();
	        double amount = order.getTotalPrice();
	        dailyRevenue.merge(date, Double.valueOf(amount), Double::sum);
	    }
	    
	    return dailyRevenue.entrySet().stream()
	        .map(entry -> {
	            Map<String, Object> item = new HashMap<>();
	            item.put("date", entry.getKey().toString());
	            item.put("revenue", entry.getValue());
	            return item;
	        })
	        .collect(Collectors.toList());
	}

   @Override
   public void writeReportToStream(Long branchId, Long productId, LocalDateTime startDate, LocalDateTime endDate,
           String fileType, OutputStream outputStream) throws IOException, DocumentException {
       Map<String, Object> data = getRevenueData(branchId, productId, startDate, endDate);
       if ("excel".equalsIgnoreCase(fileType)) {
           writeExcelReport(data, outputStream); 
       } else {
           writePdfReport(data, outputStream);
       }
   }

   private void writeExcelReport(Map<String, Object> data, OutputStream outputStream) 
	        throws IOException {
	    try (Workbook workbook = new XSSFWorkbook()) {
	        Sheet sheet = workbook.createSheet("Báo cáo doanh thu");
	        
	        // Tạo header style
	        CellStyle headerStyle = workbook.createCellStyle();
	        org.apache.poi.ss.usermodel.Font headerFont = workbook.createFont();
	        headerFont.setBold(true);
	        headerStyle.setFont(headerFont);

	        // Thông tin chung
	        sheet.createRow(0).createCell(0).setCellValue("BÁO CÁO DOANH THU");
	        sheet.createRow(1).createCell(0).setCellValue("Chi nhánh: " + data.get("branchName"));
	        sheet.createRow(2).createCell(0).setCellValue("Sản phẩm: " + data.get("productName"));
	        sheet.createRow(3).createCell(0).setCellValue("Tổng doanh thu: " + formatCurrency((Double) data.get("totalRevenue")));

	        // Tạo headers cho bảng
	        Row headerRow = sheet.createRow(5);
	        createCell(headerRow, 0, "Thời gian", headerStyle);
	        createCell(headerRow, 1, "Doanh thu", headerStyle);

	        // Thêm dữ liệu
	        @SuppressWarnings("unchecked")
	        List<Map<String, Object>> chartData = (List<Map<String, Object>>) data.get("chartData");
	        int rowNum = 6;
	        for (Map<String, Object> item : chartData) {
	            Row row = sheet.createRow(rowNum++);
	            row.createCell(0).setCellValue(item.get("date").toString());
	            row.createCell(1).setCellValue(formatCurrency((Double) item.get("revenue")));
	        }

	        // Auto-size columns
	        sheet.autoSizeColumn(0);
	        sheet.autoSizeColumn(1);

	        workbook.write(outputStream);
	    }
	}
   private Cell createCell(Row row, int column, String value, CellStyle style) {
	   Cell cell = row.createCell(column);
	   cell.setCellValue(value);
	   cell.setCellStyle(style);
	   return cell;
	}

   private void writePdfReport(Map<String, Object> data, OutputStream outputStream) throws DocumentException, IOException {
	   Document document = new Document();
	   PdfWriter.getInstance(document, outputStream);
	   document.open();

	   // Tiêu đề và thông tin chung
	   document.add(new Paragraph("BÁO CÁO DOANH THU"));
	   document.add(new Paragraph("\n"));
	   document.add(new Paragraph("Chi nhánh: " + data.get("branchName")));
	   document.add(new Paragraph("Sản phẩm: " + data.get("productName")));
	   document.add(new Paragraph("Tổng doanh thu: " + formatCurrency((Double) data.get("totalRevenue"))));
	   document.add(new Paragraph("\n"));

	   // Bảng dữ liệu
	   PdfPTable table = new PdfPTable(2);
	   table.setWidthPercentage(100);
	   table.setWidths(new float[]{1, 1});

	   // Headers
	   table.addCell("Thời gian");
	   table.addCell("Doanh thu");

	   // Data
	   @SuppressWarnings("unchecked")
	   List<Map<String, Object>> chartData = (List<Map<String, Object>>) data.get("chartData");
	   for (Map<String, Object> item : chartData) {
	       table.addCell(item.get("date").toString());
	       table.addCell(formatCurrency((Double) item.get("revenue")));
	   }

	   document.add(table);
	   document.close();
	}

   private Map<String, Object> calculateProductStats(List<Order> orders, Long productId) {
       double totalRevenue = 0;
       long totalQuantity = 0;
       
       for (Order order : orders) {
           for (OrderDetail item : order.getItems()) {
               if (item.getProduct().getId().equals(productId)) {
                   totalRevenue += item.getQuantity() * item.getPrice();
                   totalQuantity += item.getQuantity();
               }
           }
       }

       Map<String, Object> stats = new HashMap<>();
       stats.put("totalRevenue", totalRevenue);
       stats.put("totalQuantity", totalQuantity);
       return stats;
   }

   private Map<String, Object> calculateBranchStats(List<Order> orders) {
       Map<String, Object> stats = new HashMap<>();
       stats.put("totalRevenue", orders.stream().mapToDouble(Order::getTotalPrice).sum());
       stats.put("orderCount", orders.size());
       return stats;
   }

   private String formatCurrency(Double amount) {
       return String.format("%,.0f VNĐ", amount);
   }
}