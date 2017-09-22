package com.model2.mvc.web.purchase;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Opinion;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.opinion.OpinionService;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {

	///Field///
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("opinionServiceImpl")
	private OpinionService opinionService;
	
	
	///Constructor///
	public PurchaseController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass()+"Default Constructor Call");
	}

	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	@RequestMapping( value = "addPurchase/{prodNo}", method = RequestMethod.GET)
	public ModelAndView addPurchase( @PathVariable String prodNo) throws Exception{
		
		System.out.println(">>> /addPurchase GET start <<<");		
		
		int prodNoInt = Integer.parseInt(prodNo);	
		System.out.println("addPurchaseView prodNo :: "+prodNoInt);
		
		Product product = new Product();
		product = productService.getProduct(prodNoInt);
		System.out.println("addPurchaseView product :: "+product);

		//==> Model(data) / View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/addPurchaseView.jsp");
		modelAndView.addObject(product);
		
		return modelAndView;
		
	}
	
	
	@RequestMapping( value = "addPurchase", method = RequestMethod.POST)
	public ModelAndView addPurchase( @ModelAttribute("purchase") Purchase purchase) throws Exception{
		
		System.out.println(">>> /addPurchase POST start <<<");		
			
		System.out.println("addPurchase purchase :: "+purchase);
		purchase.setTranCode("1");
		
		// Business Logic 수행
		purchaseService.addPurchase(purchase);

		//==> Model(data) / View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/addPurchase.jsp");
		modelAndView.addObject(purchase);
		
		return modelAndView;
		
	}
	
	
	@RequestMapping( value = "addCommentView/{prodNo}", method = RequestMethod.GET)
	public ModelAndView addComment( @PathVariable int prodNo ) throws Exception{
		
		System.out.println(">>> /addComment GET start <<<");		
			
		System.out.println("addComment prodName :: "+prodNo);
		
		// Business Logic 수행
		Product dbproduct = productService.getProduct(prodNo);
		
		//==> Model(data) / View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/addCommentView.jsp");
		modelAndView.addObject(dbproduct);
		
		return modelAndView;
		
	}	
	
	@RequestMapping( value = "addComment", method = RequestMethod.POST)
	public ModelAndView addComment( HttpSession session, HttpServletRequest request, @ModelAttribute("opinion") Opinion opinion) throws Exception{
		
		System.out.println(">>> /addComment POST start <<<");		
			
		System.out.println("addPurchase purchase :: "+opinion);
		
		User user = (User)session.getAttribute("user");

		String userId = user.getUserId();
		opinion.setOpUserId(userId);
		
		MultipartFile uploadFile = opinion.getOpUploadFile();
		
		if(uploadFile != null){
			String fileName = uploadFile.getOriginalFilename();
			System.out.println("uploaded file name :: "+fileName);
			
			String fileDirectory = request.getServletContext().getInitParameter("fileDirectory");
			System.out.println("uploaded file Directory :: "+fileDirectory);
			
			if(fileName != null && !fileName.equals("")){
				fileName = System.currentTimeMillis()+"_"+fileName;
				
				File file = new File(fileDirectory+fileName);
				uploadFile.transferTo(file);
				opinion.setOpFileName(fileName);
			}
			
		}
		
		
		// Business Logic 수행
		opinionService.addComment(opinion);

		int prodNoInt = opinion.getOpProdNo();
		Product product = productService.getProduct(prodNoInt);
		
		List<Opinion> list = opinionService.getOpinionList(prodNoInt);
		
				
		//==> Model(data) / View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/getProduct.jsp");
		modelAndView.addObject(list);
		modelAndView.addObject(product);
		modelAndView.addObject(opinion);

		modelAndView.addObject("menu", "search");
		
		return modelAndView;
		
	}	
	
	
	
	@RequestMapping( value = "listPurchase", method = RequestMethod.GET)
	public ModelAndView listPurchase(HttpSession session) throws Exception{
		
		System.out.println(">>> /listPurchase POST start <<<");
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(pageSize); 
		
		User user = (User)session.getAttribute("user");
		
		String buyerId = user.getUserId();
		
		// Business Logic 수행
		Map<String, Object> map = purchaseService.getPurchaseList(search, buyerId);
		
		Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/listPurchase.jsp");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		return modelAndView;
	}
	
	
	@RequestMapping( value = "listPurchase", method = RequestMethod.POST)
	public ModelAndView listPurchase( @ModelAttribute("search") Search search, HttpSession session) throws Exception{
		
		System.out.println(">>> /listPurchase POST start <<<");
		System.out.println("listPurchase search :: "+search);
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize); 
		
		User user = (User)session.getAttribute("user");
		
		String buyerId = user.getUserId();
		
		// Business Logic 수행
		Map<String, Object> map = purchaseService.getPurchaseList(search, buyerId);
		
		Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/listPurchase.jsp");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		return modelAndView;
	}
	
	/*@RequestMapping( value = "listOpinion/{prodNo}", method = RequestMethod.GET)
	public ModelAndView listPurchase( @PathVariable String prodNo, HttpSession session) throws Exception{
		
		System.out.println(">>> /listOpinion POST start <<<");
		int prodNoInt = Integer.parseInt(prodNo);
		System.out.println("updatePurchase prodNo :: "+prodNoInt);
		
		
		// Business Logic 수행
		List<Opinion> list = opinionService.getOpinionList(prodNoInt);
		
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/listPurchase.jsp");
		modelAndView.addObject("list", list);
		
		
		return modelAndView;
	}*/
	
	@RequestMapping( value = "getPurchase/{tranNo}", method = RequestMethod.GET)
	public ModelAndView getPurchase( @PathVariable String tranNo ) throws Exception{
		
		System.out.println("\n>>> GetPurchase GET start <<< ");

		int tranNoInt = Integer.parseInt(tranNo);
		System.out.println("GetPurchase tranNo :: "+tranNoInt);
		
		// Business Logic 수행
		Purchase purchase = purchaseService.getPurchase(tranNoInt);
		System.out.println("GetPurchase purchase :: "+purchase);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/getPurchase.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}
	
	
	
	
	
	@RequestMapping( value = "updatePurchase/{tranNo}", method = RequestMethod.GET)
	public ModelAndView updatePurchase( @PathVariable String tranNo ) throws Exception{
		
		System.out.println("\n>>> updatePurchase GET start <<< ");

		int tranNoInt = Integer.parseInt(tranNo);
		System.out.println("updatePurchase tranNo :: "+tranNoInt);
		
		// Business Logic 수행
		Purchase purchase = purchaseService.getPurchase(tranNoInt);
		System.out.println("updatePurchase purchase :: "+purchase);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/updatePurchaseView.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}
	
	@RequestMapping( value = "updatePurchase", method = RequestMethod.POST)
	public ModelAndView updatePurchase( @ModelAttribute("purchase") Purchase purchase ) throws Exception{
		
		System.out.println("\n>>> updatePurchase POST start <<< ");
		System.out.println("updatePurchase purchase :: "+purchase);
		
		// Business Logic 수행
		purchaseService.updatePurchase(purchase);
		
		purchase = purchaseService.getPurchase(purchase.getTranNo());
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/getPurchase.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}
	
	/*@RequestMapping( value = "updatePurchase/{tranNo}", method = RequestMethod.POST)
	public ModelAndView updatePurchase( @PathVariable String tranNo, @ModelAttribute("purchase") Purchase purchase ) throws Exception{
		
		System.out.println("\n>>> updatePurchase POST start <<< ");
		System.out.println("updatePurchase purchase :: "+purchase);
		
		int tranNoInt = Integer.parseInt(tranNo);
		System.out.println("updatePurchase tranNo :: "+tranNoInt);
		purchase.setTranNo(tranNoInt);
		
		// Business Logic 수행
		purchaseService.updatePurchase(purchase);
		
		purchase = purchaseService.getPurchase(purchase.getTranNo());
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/getPurchase.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}*/
	

	@RequestMapping( value = "updateTranCode/{prodNo}/{tranCode}", method = RequestMethod.GET)
	public ModelAndView updateTranCode( @PathVariable String tranCode, @PathVariable String prodNo ) throws Exception{
		
		System.out.println("\n>>> updateTranCode GET start <<< ");
		System.out.println("updateTranCode tranCode :: "+tranCode);
		System.out.println("updateTranCode prodNo :: "+prodNo);

		int prodNoInt = Integer.parseInt(prodNo);
		
		Product purchaseProd = new Product();
		purchaseProd.setProdNo(prodNoInt);
		
		Purchase purchase = new Purchase();
		
		if(tranCode != null && tranCode.equals("2")){
			tranCode = "3";
		}
		System.out.println("updateTranCode tranCode 변경 확인 :: "+tranCode);
	
		purchase.setTranCode(tranCode);
		purchase.setPurchaseProd(purchaseProd);
		
		// Business Logic 수행
		purchaseService.updateTranCode(purchase);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/listPurchase");
		
		return modelAndView;
	
	}
	
	
	@RequestMapping( value = "updateTranCodeByProd/{prodNo}/{tranCode}", method = RequestMethod.GET)
	public ModelAndView UpdateTranCodeByProd( @PathVariable String tranCode, @PathVariable String prodNo ) throws Exception{
		
		System.out.println("\n>>> updateTranCodeByProd GET start <<< ");
		System.out.println("updateTranCodeByProd tranCode :: "+tranCode);
		System.out.println("updateTranCodeByProd prodNo :: "+prodNo);

		int prodNoInt = Integer.parseInt(prodNo);
		
		Product purchaseProd = new Product();
		purchaseProd.setProdNo(prodNoInt);
		
		Purchase purchase = new Purchase();
		
		if(tranCode != null && tranCode.equals("1")){
			tranCode = "2";
		}
		System.out.println("updateTranCode tranCode 변경 확인 :: "+tranCode);
	
		purchase.setTranCode(tranCode);
		purchase.setPurchaseProd(purchaseProd);
		
		// Business Logic 수행
		purchaseService.updateTranCode(purchase);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/product/listProduct/manage");
		
		return modelAndView;
	}
}
