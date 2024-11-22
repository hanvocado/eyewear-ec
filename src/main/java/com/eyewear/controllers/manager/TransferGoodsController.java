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

@Controller
@RequestMapping("/manager/transfer")
public class TransferGoodsController {
	@Autowired
	private ProductService productService;
	
	@Autowired
	private TransferProductService transferService;
	
	@GetMapping("/in")
	public String transferIn(Model model) {
		Long managerBranchId = (long) 1;
		List<GoodsTransferNote> importedNotes = transferService.findNotesByImportBranchId(managerBranchId);
		
		model.addAttribute("importedNotes", importedNotes);
		return "manager/transfer-in";
	}
	
	@GetMapping("/new")
	public String newNote(Model model, Long productId) {
		List<Product> products = productService.findAll();
		if (productId != null) {
			Product product = productService.findById(productId);
			if (product != null) {
				List<BranchProduct> branchProducts = product.getAvailBranches();
				model.addAttribute("branchProducts", branchProducts);
			}
		}
		
		model.addAttribute("products", products);
		
		return "manager/new-transfer-note";
	}
	
	@RequestMapping("/request/{id}")
	public String request(@PathVariable("id") Long productId, Model model) {
		Product product = productService.findById(productId);
		if (product != null) {
			List<BranchProduct> branchProducts = product.getAvailBranches();
			model.addAttribute("branchProducts", branchProducts);
		}
		return "redirect:/manager/transfer/new";
	}
}
