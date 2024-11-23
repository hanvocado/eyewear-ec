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
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.cloudinary.Cloudinary;
import com.eyewear.entities.Product;
import com.eyewear.services.ProductService;

@Controller
@RequestMapping("/common/products")
public class ProductController{
	
	@Autowired 
	private ProductService productService;
	
	@Autowired
	private Cloudinary cloudinary;
	
	private String message;
	
	// Lấy tất cả sản phẩm với phân trang
    @RequestMapping("")
    public String allProducts(Model model, Pageable pageable) {
        Page<Product> productPage = productService.findAll(PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), Sort.by("name")));
        productPage.forEach(product -> {
            String imageUrl = cloudinary.url().publicId(product.getImage()).generate();
            product.setImageUrl(imageUrl);
        });
        model.addAttribute("productPage", productPage);
        return "common/product-list";  // Trang hiển thị danh sách sản phẩm
    }
  
	@GetMapping("/search")
	public String search(ModelMap model, @RequestParam(name = "name", required = false) String name,
			@RequestParam("page") Optional<Integer> page, @RequestParam("size") Optional<Integer> size) {
		int count = (int) productService.count();
		int currentPage = page.orElse(1);
		int pageSize = size.orElse(3);

		Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name"));

		Page<Product> resultPage;
		String message = null; 
		
		if (StringUtils.hasText(name)) {
			resultPage = productService.searchProduct(name, pageable);

			if (resultPage.hasContent()) {
				message = "Tìm thấy " + resultPage.getTotalElements() + " sản phẩm ";
			} else {
				message = "Không tìm thấy sản phẩm";
			}

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
			List<Integer> pageNumbers = IntStream.rangeClosed(start, end).boxed().collect(Collectors.toList());
			model.addAttribute("pageNumbers", pageNumbers);
		}

		resultPage.forEach(product -> {
			String imageUrl = cloudinary.url().publicId(product.getImage()).generate();
			product.setImageUrl(imageUrl);
		});

		model.addAttribute("productPage", resultPage);
		model.addAttribute("message", message); // Truyền message xuống view

		return "common/product-search-result";
	}
	
	@RequestMapping("/filter")
	public String getProducts(@RequestParam(value = "categoryIds", required = false) List<Long> categoryIds,
			@RequestParam(value = "minPrice", required = false) Double minPrice,
			@RequestParam(value = "maxPrice", required = false) Double maxPrice,
			@RequestParam(value = "page", defaultValue = "0") int page,
			@RequestParam(value = "size", defaultValue = "10") int size, Model model) {

		Pageable pageable = PageRequest.of(page, size); // Tạo Pageable với trang và kích thước
		Page<Product> productPage;

		if (categoryIds != null && !categoryIds.isEmpty()) {
			if (minPrice != null && maxPrice != null) {
				productPage = productService.findByCategoryNameInAndPriceBetween(categoryIds, minPrice, maxPrice,
						pageable);
			} else {
				productPage = productService.findByCategoryId(categoryIds, pageable);
			}
		} else {
			productPage = productService.findAll(pageable); // Nếu không lọc theo danh mục, trả về tất cả sản phẩm
																// phân trang
		}
		productPage.forEach(product -> {
			String imageUrl = cloudinary.url().publicId(product.getImage()).generate();
			product.setImageUrl(imageUrl);
		});
		model.addAttribute("productPage", productPage); // Trả về Page<Product> để hiển thị
		return "common/product-search-result"; 
	}
}	
