package com.eyewear.controllers.manager;

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
import org.springframework.web.servlet.ModelAndView;

import com.eyewear.entities.Product;
import com.eyewear.services.ProductService;

import jakarta.validation.Valid;


@Controller
@RequestMapping("/manager/warehouse")
public class WareHouseController {
	@Autowired
	ProductService productService;

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
		return "/manager/warehouse/add"; // Chuyển tới trang addProduct.jsp
	}

	// Xử lý form thêm sản phẩm
	@PostMapping("/save")
	public String saveProduct(@Valid @ModelAttribute("product") Product product, BindingResult result, Model model) {
		if (result.hasErrors()) {
			// Nếu có lỗi, quay lại trang thêm sản phẩm và hiển thị thông báo lỗi
			model.addAttribute("message", "Có lỗi khi lưu sản phẩm, vui lòng kiểm tra lại.");
			return "/manager/warehouse/add"; // Quay lại trang thêm sản phẩm
		}
		// Lưu sản phẩm
		productService.save(product);
		model.addAttribute("message", "Sản phẩm đã được thêm thành công.");
		return "redirect:/manager/warehouse/searchpaginated"; // Chuyển hướng đến trang danh sách sản phẩm
	}


	// Hiển thị form chỉnh sửa sản phẩm
	@GetMapping("/edit/{id}")
	public String showEditForm(@PathVariable("id") Long id, Model model) {
		Product product = productService.findById(id);
		if (product != null) {
			model.addAttribute("product", product);
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
		product.setId(id); // Đảm bảo rằng ID được giữ lại sau khi chỉnh sửa
		productService.update(product);
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
		System.out.println("???????"+count);

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
		System.out.println("???????"+totalPages);

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
}
