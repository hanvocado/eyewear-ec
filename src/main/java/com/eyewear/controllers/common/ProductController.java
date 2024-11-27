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

import com.cloudinary.Cloudinary;
import com.eyewear.entities.Category;
import com.eyewear.entities.Product;
import com.eyewear.services.CategoryService;
import com.eyewear.services.ProductService;

@Controller
@RequestMapping("/common/products")
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private Cloudinary cloudinary;

    private String message;

    // Lấy tất cả sản phẩm với phân trang
    @RequestMapping("")
    public String allProducts(ModelMap model, Pageable pageable) {
        Page<Product> productPage = productService.findAll(PageRequest.of(pageable.getPageNumber(), pageable.getPageSize()));
        addPaginationAttributes(model, pageable, productPage);
        setProductImageUrls(productPage);
        model.addAttribute("productPage", productPage);
        return "common/product-list";  // Trang hiển thị danh sách sản phẩm
    }

    @GetMapping("/search")
    public String search(ModelMap model, @RequestParam(name = "name", required = false) String name, Pageable pageable) {
        
        List<Category> categories = categoryService.findAll();
        List<String> uniqueBrand = getUniqueBrands();

        Page<Product> resultPage = searchProducts(name, pageable);
        String message = getMessage(resultPage, name);

        addPaginationAttributes(model, pageable, resultPage);
        setProductImageUrls(resultPage);

        model.addAttribute("brands", uniqueBrand);
        model.addAttribute("categories", categories);
        model.addAttribute("productPage", resultPage);
        model.addAttribute("message", message);
        model.addAttribute("name", name);

        return "common/product-search-result";
    }

    @GetMapping("/searchpaginated")
    public String searchPaginated(ModelMap model,
                                  @RequestParam(name = "name", required = false) String name,
                                  @RequestParam("page") Optional<Integer> page,
                                  @RequestParam("size") Optional<Integer> size) {

        int currentPage = page.orElse(1);
        int pageSize = size.orElse(3);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name"));

        List<Category> categories = categoryService.findAll();
        List<String> uniqueBrand = getUniqueBrands();

        Page<Product> resultPage = searchProducts(name, pageable);
        String message = getMessage(resultPage, name);

        addPaginationAttributes(model, pageable, resultPage);
        setProductImageUrls(resultPage);

        model.addAttribute("brands", uniqueBrand);
        model.addAttribute("categories", categories);
        model.addAttribute("productPage", resultPage);
        model.addAttribute("message", message);

        return "common/product-search-result";
    }

    @RequestMapping("/filter")
    public String getProducts(@RequestParam(value = "categoryName", required = false) List<String> categoryName,
    						  @RequestParam(name = "name", required = false) String searchname,
                              @RequestParam(value = "brand", required = false) String brand,
                              @RequestParam(value = "minPrice", required = false) Double minPrice,
                              @RequestParam(value = "maxPrice", required = false) Double maxPrice,
                              @RequestParam(value = "page", defaultValue = "0") int page,
                              @RequestParam(value = "size", defaultValue = "10") int size,
                              Model model) {
    	
    	// Lấy kt, trang hiện tại
        Pageable pageable = PageRequest.of(page, size);
        System.out.println(searchname);
        Page <Product> productPage;
        
        if (StringUtils.hasText(searchname)) {
            productPage = productService.searchProduct(searchname, pageable);
            if ((categoryName != null && !categoryName.isEmpty()) || brand != null || minPrice != null || maxPrice != null) {
                productPage = productService.findByCriteria(categoryName, brand, minPrice, maxPrice, pageable);
            }
        } else {
            if ((categoryName != null && !categoryName.isEmpty()) || brand != null || minPrice != null || maxPrice != null) {
                productPage = productService.findByCriteria(categoryName, brand, minPrice, maxPrice, pageable);
            } else {
                productPage = productService.findAll(pageable);
            }
        }

        List<Category> categories = categoryService.findAll();
        List<String> uniqueBrand = getUniqueBrands();
        
        // đưa vào đường dẫn
        setProductImageUrls(productPage);

        model.addAttribute("brands", uniqueBrand);
        model.addAttribute("categories", categories);
        model.addAttribute("productPage", productPage);

        return "common/product-search-result";
    }

    // Tìm sản phẩm theo tên
    private Page<Product> searchProducts(String name, Pageable pageable) {
        if (StringUtils.hasText(name)) {
            return productService.searchProduct(name, pageable);
        } else {
            return productService.findAll(pageable);
        }
    }
    // Thông báo
    private String getMessage(Page<Product> resultPage, String name) {
        if (StringUtils.hasText(name)) {
            if (resultPage.hasContent()) {
                return "Tìm thấy " + resultPage.getTotalElements() + " sản phẩm";
            } else {
                return "Không tìm thấy sản phẩm";
            }
        }
        return null;
    }
    // phân trang
    private void addPaginationAttributes(ModelMap model, Pageable pageable, Page<Product> productPage) {
        int currentPage = pageable.getPageNumber();
        int totalPages = productPage.getTotalPages();
        if (totalPages > 0) {
            int start = Math.max(1, currentPage - 2);
            int end = Math.min(currentPage + 2, totalPages);
            List<Integer> pageNumbers = IntStream.rangeClosed(start, end)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }
    }
    // Lấy URL tạo ra từ Cloudinary
    private void setProductImageUrls(Page<Product> productPage) {
        productPage.forEach(product -> {
            String imageUrl = cloudinary.url().publicId(product.getImage()).generate();
            product.setImageUrl(imageUrl);
        });
    }

    private List<String> getUniqueBrands() {
        List<Product> productList = productService.findAll();
        return productList.stream()
                .map(Product::getBrand)
                .distinct()
                .collect(Collectors.toList());
    }
}