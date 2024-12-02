package com.eyewear.controllers.common;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cloudinary.Cloudinary;
import com.eyewear.entities.Category;
import com.eyewear.entities.Product;
import com.eyewear.entities.ProductReview;
import com.eyewear.services.CategoryService;
import com.eyewear.services.ProductReviewService;
import com.eyewear.services.ProductService;

@Controller
@RequestMapping("/common/products")
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;
    
    @Autowired
    private ProductReviewService productReviewService;

    @Autowired
    private Cloudinary cloudinary;

    private String message;
    

    // Lấy tất cả sản phẩm với phân trang
    @RequestMapping("")
    public String allProducts(ModelMap model, Pageable pageable) {	
    	int page = (pageable.getPageNumber()>0) ? pageable.getPageNumber()-1 : 0;
        Page<Product> productPage = productService.findAll(PageRequest.of(page, pageable.getPageSize()));
        addPaginationAttributes(model, pageable, productPage);
        setProductImageUrls(productPage);
        model.addAttribute("productPage", productPage);
        return "common/product-list";  // Trang hiển thị danh sách sản phẩm
    }
    @GetMapping("/search")
    public String search(ModelMap model, @RequestParam(name = "name", required = false) String name, Pageable pageable) {
        
        List<Category> categories = categoryService.findAll();
        List<String> uniqueBrand = getUniqueBrands();
        
        Double maxPrice = productService.findMaxPrice();
        Double minPrice = productService.findMinPrice();

        Page <Product> resultPage = searchProducts(name, pageable);
        String message = getMessage(resultPage, name);

        addPaginationAttributes(model, pageable, resultPage);
        setProductImageUrls(resultPage);

        model.addAttribute("brands", uniqueBrand);
        model.addAttribute("categories", categories);
        model.addAttribute("productPage", resultPage);
        model.addAttribute("message", message);
        model.addAttribute("max", maxPrice);
        model.addAttribute("min", minPrice);
        // Truyền tên từ thanh tìm xuống view
        model.addAttribute("searchname", name);

        return "common/product-search-result";
    }

    @GetMapping("/searchpaginated")
    public String searchPaginated(ModelMap model,
                                  @RequestParam(name = "name", required = false) String name,
                                  Pageable pageable) {

    	int currentPage = (pageable.getPageNumber()>0) ? pageable.getPageNumber()-1 : 0;

        Pageable page = PageRequest.of(currentPage, pageable.getPageSize(), Sort.by("name"));

        List<Category> categories = categoryService.findAll();
        List<String> uniqueBrand = getUniqueBrands();

        Page<Product> resultPage = searchProducts(name, page);
        String message = getMessage(resultPage, name);

        addPaginationAttributes(model, page, resultPage);
        setProductImageUrls(resultPage);

        model.addAttribute("brands", uniqueBrand);
        model.addAttribute("categories", categories);
        model.addAttribute("productPage", resultPage);
        model.addAttribute("message", message);
        model.addAttribute("searchname", name);

        return "common/product-search-result";
    }

    @RequestMapping("/filter")
    public String getProducts(@RequestParam(name = "name", required = false) String name,
                              @RequestParam(name = "categoryName", required = false) List<String> categoryName,  
                              @RequestParam(value = "brand", required = false) List<String> brand,
                              @RequestParam(value = "minPrice", required = false) Double minPrice,
                              @RequestParam(value = "maxPrice", required = false) Double maxPrice,
                              Pageable pageable,
                              ModelMap model) {

        Page<Product> productPage;
        String message = null;
        
        int currentPage = (pageable.getPageNumber() > 0) ? pageable.getPageNumber() - 1 : 0;
        Pageable page = PageRequest.of(currentPage, pageable.getPageSize(), Sort.by("name"));

        if (StringUtils.hasText(name)) {
            productPage = productService.searchProduct(name, page);
            if (!productPage.isEmpty()) {
                if ((categoryName != null && !categoryName.isEmpty()) ||
                    (brand != null && !brand.isEmpty()) ||
                    minPrice != null || maxPrice != null) {
                    productPage = productService.findByCriteria(categoryName, brand, minPrice, maxPrice, page);
                    message = "Tìm thấy" + productPage.getTotalElements() + " sản phẩm";
                }
            } else {
                productPage = Page.empty(page);
                message = "Không tìm thấy sản phẩm phù hợp, vui lòng chọn loại sản phẩm khác";
            }
        } else {
            if ((categoryName != null && !categoryName.isEmpty()) ||
                (brand != null && !brand.isEmpty()) ||
                minPrice != null || maxPrice != null) {
                productPage = productService.findByCriteria(categoryName, brand, minPrice, maxPrice, page);
            } else {
                productPage = productService.findAll(page);
                
            }
        }

        List<Category> categories = categoryService.findAll();
        List<String> uniqueBrand = getUniqueBrands();
        
        addPaginationAttributes(model, page, productPage);
        setProductImageUrls(productPage);

        model.addAttribute("action", "filter");
        model.addAttribute("searchname", name);
        model.addAttribute("brand", brand);
        model.addAttribute("categoryName", categoryName);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("brands", uniqueBrand);
        model.addAttribute("categories", categories);
        model.addAttribute("productPage", productPage);
        model.addAttribute("message", message);

        return "common/product-search-result";
    }
    
    @RequestMapping("/detail/{id}")
    public String getProductDetail(@PathVariable long id,
            ModelMap model) {
    	
    	Product product = productService.getProductById(id);
    	String message = null;
    	
    	String productType = product.getCategory().getName();
      	
    	List<ProductReview> reviews = productReviewService.findAll(id);
    	
   	 // Lấy sản phẩm tương tự (theo danh mục hoặc thương hiệu)
       List<Product> similarProducts = productService.findByCategoryIdOrBrand(
       		product.getCategory().getId(), 
       		product.getBrand(), id);
       
       if (similarProducts != null && !similarProducts.isEmpty()) {
    	    similarProducts.forEach(similarProduct -> {
    	        try {
    	            // Tạo URL hình ảnh từ Cloudinary
    	            String imageUrl = cloudinary.url()
    	                    .publicId(similarProduct.getImage())
    	                    .generate();

    	            // Gán URL hình ảnh vào sản phẩm tương tự
    	            similarProduct.setImageUrl(imageUrl);
    	        } catch (Exception e) {
    	            // Xử lý lỗi nếu việc tạo URL thất bại
    	            System.err.println("Lỗi tạo đường dẫn: " + similarProduct.getId());
    	            e.printStackTrace();
    	        }
    	    });
    	} else {
    	    System.out.println("Không tìm thấy sản phẩm tương tự");
    	    message = "Không tìm thấy sản phẩm tương tự";
    	}
    	
    	String imageUrl = cloudinary.url().publicId(product.getImage()).generate();
        product.setImageUrl(imageUrl);
    	model.addAttribute("product", product);
    	model.addAttribute("similarProducts", similarProducts);
    	model.addAttribute("message", message);
    	model.addAttribute("productType", productType); 
    	model.addAttribute("reviews", reviews);
    	
    	return "common/product-detail";
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
                return "Không tìm thấy sản phẩm phù hợp. Vui lòng nhập từ khóa tìm kiếm khác";
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