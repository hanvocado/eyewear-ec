package com.eyewear.controllers.manager;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.eyewear.entities.BranchProduct;
import com.eyewear.entities.GoodsTransferNote;
import com.eyewear.entities.Product;
import com.eyewear.services.ProductService;
import com.eyewear.services.TransferProductService;

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
		
		model.addAttribute("importedNotes", importedNotes);
		return "manager/transfer-in";
	}
	
	@GetMapping("/new")
	public String newNote(Model model, Long productId) {
		int step = 1;			
		if (productId == null) {
			List<Product> products = productService.findAll();
			model.addAttribute("products", products);
		}
		else {
			Product product = productService.findById(productId);
			if (product != null) {
				List<BranchProduct> branchProducts = product.getAvailBranches();
				model.addAttribute("branchProducts", branchProducts);
				model.addAttribute("product", product);
				step = 2;
			}
		}

		model.addAttribute("step", step);		
		return "manager/new-transfer-note";
	}
	
	@PostMapping("/request")
	public String request(@RequestParam Long productId, @RequestParam Long branchId, @RequestParam int quantity, Boolean moreProduct, Model model) {
		Long importBranchId = (long) 3;
		GoodsTransferNote newNote = transferService.createNote(importBranchId, productId, branchId, quantity);
		model.addAttribute("transferNoteId", newNote.getId());
		if (moreProduct != null && moreProduct) {
			List<BranchProduct> productsAtExportBranch = transferService.findProductsByBranchId(branchId);
			model.addAttribute("products", productsAtExportBranch);
			model.addAttribute("step", 3);
			return "manager/new-transfer-note";
		} else
			return "redirect:/manager/transfer/in";
	}
	
	@PostMapping("/add-transfer-product")
	public String addTransferProduct(@RequestParam Long transferNoteId, @RequestParam int quantity, @RequestParam Long productId, Boolean moreProduct, Model model) {
		GoodsTransferNote existingNote = transferService.addTransferProduct(productId, quantity, transferNoteId);
		if (existingNote != null && moreProduct != null && moreProduct) {
			/*
			 * List<BranchProduct> productsAtExportBranch =
			 * transferService.findProductsByBranchId(branchId);
			 * model.addAttribute("products", productsAtExportBranch);
			 */
			model.addAttribute("step", 3);
			return "manager/new-transfer-note";
		}
		return null;
	}
}
