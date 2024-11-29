package com.eyewear.controllers.manager;

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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.eyewear.entities.Category;
import com.eyewear.entities.Product;
import com.eyewear.services.CategoryService;
import com.eyewear.services.ProductService;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/manager/warehouse/category")
public class CategoryController {
    @Autowired
    private ProductService productService;
    @Autowired
    private CategoryService categoryService;

    // Hiển thị form thêm danh mục
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("category", new Category()); // Tạo đối tượng category rỗng
        return "/manager/warehouse/category/add"; // Chuyển tới trang addCategory.jsp
    }

    // Xử lý form thêm danh mục
    @PostMapping("/save")
    public String saveCategory(@Valid @ModelAttribute("category") Category category, BindingResult result, Model model) {
        if (result.hasErrors()) {
            // Nếu có lỗi, quay lại trang thêm danh mục và hiển thị thông báo lỗi
            model.addAttribute("message", "Có lỗi khi lưu danh mục, vui lòng kiểm tra lại.");
            return "/manager/warehouse/category/add";
        }
        // Lưu danh mục
        categoryService.save(category);
        model.addAttribute("message", "Danh mục đã được thêm thành công.");
        return "redirect:/manager/warehouse/category/searchpaginated"; // Chuyển hướng đến danh sách danh mục
    }

    // Hiển thị form chỉnh sửa danh mục
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model) {
        Category category = categoryService.findById(id);
        if (category != null) {
            model.addAttribute("category", category);
            return "/manager/warehouse/category/edit"; // Chuyển tới trang editCategory.jsp
        }
        model.addAttribute("message", "Không tìm thấy danh mục.");
        return "redirect:/manager/warehouse/category/searchpaginated"; // Quay lại danh sách nếu không tìm thấy danh mục
    }

    // Xử lý form chỉnh sửa danh mục
    @PostMapping("/update/{id}")
    public String updateCategory(@PathVariable("id") Long id, @Valid @ModelAttribute("category") Category category,
                                 BindingResult result, Model model) {
        if (result.hasErrors()) {
            // Nếu có lỗi, quay lại trang chỉnh sửa danh mục
            model.addAttribute("message", "Có lỗi khi cập nhật danh mục, vui lòng kiểm tra lại.");
            return "/manager/warehouse/category/edit";
        }
        // Cập nhật danh mục
        category.setId(id); // Đảm bảo rằng ID được giữ lại sau khi chỉnh sửa
        categoryService.update(category);
        model.addAttribute("message", "Danh mục đã được cập nhật thành công.");
        return "redirect:/manager/warehouse/category/searchpaginated"; // Chuyển hướng đến danh sách danh mục
    }

    // Xử lý xóa danh mục
    @GetMapping("/delete/{id}")
    public String deleteCategory(@PathVariable("id") Long id, Model model) {
        categoryService.deleteById(id); // Gọi service để xóa danh mục
        model.addAttribute("message", "Danh mục đã được xóa thành công.");
        return "redirect:/manager/warehouse/category/searchpaginated"; // Quay lại danh sách danh mục
    }

    // Tìm kiếm danh mục với phân trang
    @RequestMapping("/searchpaginated")
    public String search(ModelMap model,
                         @RequestParam(name = "name", required = false) String name,
                         @RequestParam("page") Optional<Integer> page,
                         @RequestParam("size") Optional<Integer> size) {

        int count = (int) categoryService.count();

        int currentPage = page.orElse(1);
        int pageSize = size.orElse(3);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name"));

        Page<Category> resultPage = null;

        if (StringUtils.hasText(name)) {
            resultPage = categoryService.findByNameContaining(name, pageable);
            model.addAttribute("name", name);
        } else {
            resultPage = categoryService.findAllPage(pageable);
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

        return "manager/warehouse/category/list";
    }
    @GetMapping("/view/{id}")
    public String viewProduct(@PathVariable("id") Iterable<Long> id, Model model) {
        List<Product> products = productService.findListById(id);

        if (products != null) {
            model.addAttribute("categories", products);
            return "manager/warehouse/view"; // Trả về trang JSP
        } else {
            model.addAttribute("error", "Product not found");
            return "error";
        }
    }
}

