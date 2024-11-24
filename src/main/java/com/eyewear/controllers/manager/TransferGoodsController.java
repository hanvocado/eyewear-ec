package com.eyewear.controllers.manager;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eyewear.entities.BranchProduct;
import com.eyewear.entities.GoodsTransferNote;
import com.eyewear.entities.Product;
import com.eyewear.services.ProductService;
import com.eyewear.services.TransferProductService;
import com.eyewear.utils.TransferNoteStatus;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/manager/transfer")
public class TransferGoodsController {
	@Autowired
	private ProductService productService;

	@Autowired
	private TransferProductService transferService;

	@GetMapping("/in")
	public String transferIn(Model model) {
		Long managerBranchId = (long) 3;
		List<GoodsTransferNote> importedNotes = transferService.findNotesByImportBranchId(managerBranchId);
		List<GoodsTransferNote> pendingNotes = importedNotes.stream()
								.filter(n -> n.getStatus().equals(TransferNoteStatus.PENDING))
								.collect(Collectors.toList());
		List<GoodsTransferNote> shippingNotes = importedNotes.stream()
				.filter(n -> n.getStatus().equals(TransferNoteStatus.CONFIRMED))
				.collect(Collectors.toList());
		List<GoodsTransferNote> completedNotes = importedNotes.stream()
				.filter(n -> n.getStatus().equals(TransferNoteStatus.COMPLETED))
				.collect(Collectors.toList());
		
		model.addAttribute("pendingNotes", pendingNotes);
		model.addAttribute("shippingNotes", shippingNotes);
		model.addAttribute("completedNotes", completedNotes);
		return "manager/transfer-in";
	}

	@GetMapping("/new")
	public String newNote(Model model, Long productId, HttpSession session) {
		/*
		 * Long importBranchId = (Long) session.getAttribute("currentLoginBranchId");
		 */		
		Long importBranchId = (long) 3;
		int step = 1;
		if (productId == null) {
			List<Product> products = productService.findAll();
			model.addAttribute("products", products);
		} else {
			Product product = productService.findById(productId);
			if (product != null) {
				List<BranchProduct> branchProducts = product.getAvailBranches();
				branchProducts.removeIf(bp -> bp.getBranch().getId() == importBranchId);
				model.addAttribute("branchProducts", branchProducts);
				model.addAttribute("product", product);
				step = 2;
			}
		}

		model.addAttribute("step", step);
		return "manager/new-transfer-note";
	}

	@PostMapping("/request")
	public String request(@RequestParam Long productId, @RequestParam Long branchId, @RequestParam int quantity,
			Boolean moreProduct, Model model, HttpSession session, RedirectAttributes attributes) {
		Long importBranchId = (long) 3;
		GoodsTransferNote newNote = transferService.createNote(importBranchId, productId, branchId, quantity);
		if (newNote == null) {
			attributes.addFlashAttribute("message", "Thất bại. Vui lòng đọc kỹ hướng dẫn và thử lại.");
			attributes.addFlashAttribute("messageType", "danger");
			return "redirect:/manager/transfer/new";
		}
		
		if (moreProduct != null && moreProduct) {
			List<BranchProduct> productsAtExportBranch = transferService.findProductsByBranchId(branchId);
			productsAtExportBranch.removeIf(p -> p.getProduct().getId() == productId || p.getQuantity() <= 0);
			model.addAttribute("products", productsAtExportBranch);
			model.addAttribute("step", 3);
			model.addAttribute("transferNote", newNote);
			
			session.setAttribute("productsAtExportBranch", productsAtExportBranch);
			return "manager/new-transfer-note";
		}
		
		attributes.addFlashAttribute("message", "Tạo phiếu yêu cầu chuyển kho thành công!");
		attributes.addFlashAttribute("messageType", "success");
		return "redirect:/manager/transfer/in";
	}

	@PostMapping("/add-transfer-product")
	public String addTransferProduct(@RequestParam Long transferNoteId, @RequestParam int quantity,
			@RequestParam Long productId, Boolean moreProduct, Model model, HttpSession session, RedirectAttributes attributes) {
		GoodsTransferNote existingNote = transferService.addTransferProduct(productId, quantity, transferNoteId);
		
		if (existingNote != null && moreProduct != null && moreProduct) {
			List<BranchProduct> productsAtExportBranch = (List<BranchProduct>) session.getAttribute("productsAtExportBranch");
			productsAtExportBranch.removeIf(p -> p.getProduct().getId() == productId);
			model.addAttribute("products", productsAtExportBranch);
			model.addAttribute("step", 3);
			model.addAttribute("transferNote", existingNote);			
			session.setAttribute("productsAtExportBranch", productsAtExportBranch);
			
			return "manager/new-transfer-note";
		}
		
		attributes.addFlashAttribute("message", "Tạo phiếu yêu cầu chuyển kho thành công!");
		attributes.addFlashAttribute("messageType", "success");		
		return "redirect:/manager/transfer/in";
	}
	
	@RequestMapping("/received/{id}")
	public String received(@PathVariable("id") Long noteId, RedirectAttributes attributes) {
		boolean isSuccess = transferService.completeTransfer(noteId);
		if (isSuccess) {
			attributes.addFlashAttribute("message", "Cập nhật thành công!");
			attributes.addFlashAttribute("messageType", "success");
		} else {
			attributes.addFlashAttribute("message", "Cập nhật thất bại!");
			attributes.addFlashAttribute("messageType", "danger");
		}
		return "redirect:/manager/transfer/in";
	}
	
	@RequestMapping("/cancell/{id}")
	public String cancell(@PathVariable("id") Long noteId, RedirectAttributes attributes) {
		boolean isSuccess = transferService.cancellTransfer(noteId);
		if (isSuccess) {
			attributes.addFlashAttribute("message", "Hủy yêu cầu thành công!");
			attributes.addFlashAttribute("messageType", "success");
		} else {
			attributes.addFlashAttribute("message", "Hủy yêu cầu thất bại!");
			attributes.addFlashAttribute("messageType", "danger");
		}
		return "redirect:/manager/transfer/in";
	}
	
	@GetMapping("/out")
	public String transferOut(Model model) {
		Long managerBranchId = (long) 1;
		List<GoodsTransferNote> exportedNotes = transferService.findNotesByExportBranchId(managerBranchId);
		List<GoodsTransferNote> pendingNotes = exportedNotes.stream()
								.filter(n -> n.getStatus().equals(TransferNoteStatus.PENDING))
								.collect(Collectors.toList());
		List<GoodsTransferNote> shippingNotes = exportedNotes.stream()
				.filter(n -> n.getStatus().equals(TransferNoteStatus.CONFIRMED))
				.collect(Collectors.toList());
		List<GoodsTransferNote> completedNotes = exportedNotes.stream()
				.filter(n -> n.getStatus().equals(TransferNoteStatus.COMPLETED))
				.collect(Collectors.toList());
		
		model.addAttribute("pendingNotes", pendingNotes);
		model.addAttribute("shippingNotes", shippingNotes);
		model.addAttribute("completedNotes", completedNotes);
		return "manager/transfer-out";
	}
	
	@RequestMapping("/confirmShipping/{id}")
	public String confirm(@PathVariable("id") Long noteId, RedirectAttributes attributes) {
		boolean isSuccess = transferService.confirmShipping(noteId);
		if (isSuccess) {
			attributes.addFlashAttribute("message", "Xác nhận thành công!");
			attributes.addFlashAttribute("messageType", "success");
		} else {
			attributes.addFlashAttribute("message", "Xác nhận thất bại!");
			attributes.addFlashAttribute("messageType", "danger");
		}
		return "redirect:/manager/transfer/out";
	}
	
	@RequestMapping("/details/{id}")
	public String details(@PathVariable("id") Long noteId, Model model) {
		GoodsTransferNote note = transferService.findNoteById(noteId);
		model.addAttribute("transferNote", note);
		return "manager/transfer-note-details";
	}
	
}
