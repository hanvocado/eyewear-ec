package com.eyewear.controllers.common;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.eyewear.entities.Product;
import com.eyewear.services.ProductService;


@Controller
@RequestMapping("/common/products")
public class ProductController{
	
	@Autowired 
	ProductService productService;
	
	@RequestMapping("")
	public String allProducts(Model model, Pageable pageable) {
		Page<Product> productPage = productService.findAll(PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), Sort.by("name")));
        model.addAttribute("productPage", productPage);
        // Dẫn vào trang danh sách sản phẩm, có phân trang
		return "common/product-list";
	}
	
	@GetMapping("/search")
	public String search(ModelMap model,
			@RequestParam(name = "name", required = false) String name,
			@RequestParam("page") Optional<Integer> page,
			@RequestParam("size") Optional<Integer> size) {
		
		int count = (int) productService.count();
		int currentPage = page.orElse(1);
		int pageSize = size.orElse(3);
		
		Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name"));
		
		Page<Product> resultPage = null;
		
		if (StringUtils.hasText(name)) {
			resultPage = productService.searchProduct(name, pageable);
			model.addAttribute("name", name);
		} else {
			resultPage = productService.findAll(pageable);
		}
		int totalPages = resultPage.getTotalPages();
		if (totalPages > 0) {
			int start = Math.max(1, currentPage - 2);
			int end = Math.min(currentPage + 2, totalPages);
			if (totalPages > count) {
				if (end == totalPages)
					start = end - count;
				else if (start == 1)
					end = start + count;
			}
			List<Integer> pageNumbers = IntStream.rangeClosed(start, end)
					.boxed()
					.collect(Collectors.toList());
			model.addAttribute("pageNumbers", pageNumbers);
		}
		model.addAttribute("productPage", resultPage);
		// Kết quả tìm kiếm, có phân trang
		return "common/product-search-result";
	}
}	
