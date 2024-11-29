package com.eyewear.controllers.manager;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eyewear.entities.Branch;
import com.eyewear.entities.BranchProduct;
import com.eyewear.entities.Category;
import com.eyewear.entities.Product;
import com.eyewear.services.BranchProductService;
import com.eyewear.services.BranchService;
import com.eyewear.services.CategoryService;
import com.eyewear.services.ProductService;

import jakarta.validation.Valid;


@Controller
@RequestMapping("/manager/warehouse")
public class WareHouseController {
	@Autowired
	ProductService productService;
	@Autowired
	CategoryService categoryService;
	@Autowired
	BranchProductService branchProductService;
	@Autowired
	BranchService branchService;

	Long branchId =(long) 1;
	@GetMapping("")
	public String allProduct(Model model) {
		List<Product> list = productService.findAll();
		for (Product product : list) {
	        System.out.println(product.getName()); // In ra thuộc tính name của mỗi category
	    }
		model.addAttribute("list", list);
		return "manager/warehouse/list";
	}

	// Hiển thị form thêm sản phẩm
	@GetMapping("/add")
	public String showAddForm(Model model) {
		model.addAttribute("product", new Product()); // Tạo đối tượng product rỗng
	    model.addAttribute("categories", categoryService.findAll());
	    model.addAttribute("branchProduct", new BranchProduct()); // Tạo đối tượng BranchProduct rỗng
	    model.addAttribute("specificBranchId", branchId);
		return "/manager/warehouse/add"; // Chuyển tới trang addProduct.jsp
	}

	// Xử lý form thêm sản phẩm
	@PostMapping("/save")
	public String saveProduct(@Valid @ModelAttribute("product") Product product,@RequestParam int quantity,@RequestParam("imageFile") MultipartFile imageFile,RedirectAttributes redirectAttributes, BindingResult result, Model model) {
		
		// Lưu sản phẩm
		 // Gắn product ID vào branchProduct (nếu cần liên kết)
		BranchProduct branchProduct = new BranchProduct();
		System.out.println(branchProduct.getQuantity());
	    branchProduct.setProduct(product);
	    Branch branch = branchService.findById(branchId);
	    branchProduct.setBranch(branch);
	    product.setBranches(new ArrayList<>());
		//List<BranchProduct> bPs= branchProduct;
		// Cập nhật số lượng của chi nhánh trong danh sách branchProduct của sản phẩm
		//product.setBranches(branchProduct);
        boolean branchExists = false;
        for (BranchProduct bp : product.getBranches()) {
            if (bp.getId().equals(branchId)) {
                bp.setQuantity(quantity); // Cập nhật số lượng
                branchExists = true;
                break;
            }
        }

        if (!branchExists) {
            // Nếu chi nhánh chưa tồn tại trong danh sách, thêm vào danh sách
            branchProduct.setQuantity(quantity);
            product.getBranches().add(branchProduct);
        }
        try {
	        if (imageFile != null && !imageFile.isEmpty()) {
	            // Upload ảnh
	            String fileName = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();
	            
	            // Sử dụng đường dẫn tuyệt đối
	            String uploadDir = "src/main/resources/static/images/products";
	            Path uploadPath = Paths.get(uploadDir).toAbsolutePath().normalize();
	            
	            // Log để debug
	            System.out.println("Upload Path: " + uploadPath);
	            System.out.println("File Name: " + fileName);
	            
	            // Tạo thư mục nếu không tồn tại
	            if (!Files.exists(uploadPath)) {
	                Files.createDirectories(uploadPath);
	                System.out.println("Directory created: " + uploadPath);
	            }
	            
	            // Copy file với full path
	            Path targetLocation = uploadPath.resolve(fileName);
	            System.out.println("Target Location: " + targetLocation);
	            
	            Files.copy(imageFile.getInputStream(), targetLocation, StandardCopyOption.REPLACE_EXISTING);
	            System.out.println("File saved successfully");
	            
	            // Lưu tên file vào entity
	            product.setImage(fileName);
	        }
        // Lưu sản phẩm với sự thay đổi trong danh sách branches
        productService.save(product);
	    branchProductService.save(branchProduct); // Lưu branchProduct
		model.addAttribute("message", "Sản phẩm đã được thêm thành công.");
		return "redirect:/manager/warehouse/searchpaginated"; // Chuyển hướng đến trang danh sách sản phẩm
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Lỗi khi lưu sản phẩm: " + e.getMessage());
            return "redirect:/manager/warehouse/add";
        }
	}


	// Hiển thị form chỉnh sửa sản phẩm
	@GetMapping("/edit/{id}")
	public String showEditForm(@PathVariable("id") Long id, Model model) {
		Product product = productService.findById(id);
		List<Category> categories = categoryService.findAll();
		if (product != null) {
			model.addAttribute("product", product);
		    model.addAttribute("categories", categories);
		

			return "/manager/warehouse/edit"; // Chuyển tới trang editProduct.jsp
		}
		model.addAttribute("message", "Không tìm thấy sản phẩm.");
		return "redirect:/manager/warehouse/searchpaginated"; // Quay lại danh sách nếu không tìm thấy sản phẩm
	}

	// Xử lý form chỉnh sửa sản phẩm
	@PostMapping("/update/{id}")
	public String updateProduct(@PathVariable("id") Long id, @Valid @ModelAttribute("product") Product product,
			BindingResult result, Model model) {
		if (result.hasErrors()) {
			// Nếu có lỗi, quay lại trang chỉnh sửa sản phẩm
			model.addAttribute("message", "Có lỗi khi cập nhật sản phẩm, vui lòng kiểm tra lại.");
			return "/manager/warehouse/edit";
		}
		// Cập nhật sản phẩm
		Product productEdit = new Product();
		BeanUtils.copyProperties(product, productEdit);

		productEdit.setId(id); // Đảm bảo rằng ID được giữ lại sau khi chỉnh sửa
		Category selectedCategory = categoryService.findById(product.getCategory().getId());

		productEdit.setCategory(selectedCategory);
        //product.getCategory().setId(selectedCategory.getId());
		productService.update(productEdit);
		
		model.addAttribute("message", "Sản phẩm đã được cập nhật thành công.");
		return "redirect:/manager/warehouse/searchpaginated"; // Chuyển hướng đến danh sách sản phẩm
	}
	// Xử lý xóa sản phẩm
    @GetMapping("/delete/{id}")
    public String deleteProduct(@PathVariable("id") Long id, Model model) {
        productService.deleteById(id); // Gọi service để xóa sản phẩm
        model.addAttribute("message", "Sản phẩm đã được xóa thành công.");
        return "redirect:/manager/warehouse/searchpaginated"; // Quay lại danh sách sản phẩm
    }
    @RequestMapping("/searchpaginated")

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

			resultPage = productService.findByNameContaining(name, pageable);

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

		model.addAttribute("list", resultPage);

		return "manager/warehouse/list";

	}
    @GetMapping("/view/{id}")
    public String viewProduct(@PathVariable("id") Long id, Model model) {
        Product product = productService.findById(id);
        BranchProduct branchProduct = branchProductService.findById(id,branchId);
        if (product != null) {
        	model.addAttribute("product", product);
            model.addAttribute("branchProduct", branchProduct);
            return "manager/warehouse/view"; // Trả về trang JSP
        } else {
            model.addAttribute("error", "Product not found");
            return "error";
        }
    }
}
