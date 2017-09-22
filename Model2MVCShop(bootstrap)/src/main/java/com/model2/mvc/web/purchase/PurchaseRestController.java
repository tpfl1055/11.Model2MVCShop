package com.model2.mvc.web.purchase;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
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

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {

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
	public PurchaseRestController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass()+"Default Constructor Call");
	}

	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	@RequestMapping( value = "json/addPurchase/{prodNo}", method = RequestMethod.GET)
	public Product addPurchase( @PathVariable String prodNo) throws Exception{
		
		System.out.println(">>> /addPurchase GET start <<<");		
		
		int prodNoInt = Integer.parseInt(prodNo);	
		System.out.println("addPurchaseView prodNo :: "+prodNoInt);
		
		Product product = new Product();
		product = productService.getProduct(prodNoInt);
		System.out.println("addPurchaseView product :: "+product);

		//==> Model(data) / View(jsp)
		/*ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/addPurchaseView.jsp");
		modelAndView.addObject(product);*/
		
		return product;
		
	}
	
	
	@RequestMapping( value = "json/addPurchase", method = RequestMethod.POST)
	public Purchase addPurchase( @RequestBody Purchase purchase) throws Exception{
		
		System.out.println(">>> /addPurchase POST start <<<");		
			
		System.out.println("addPurchase purchase :: "+purchase);
		purchase.setTranCode("1");
		
		// Business Logic 수행
		purchaseService.addPurchase(purchase);

		//==> Model(data) / View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/addPurchase.jsp");
		modelAndView.addObject(purchase);
		
		return purchase;
		
	}
	
	
	@RequestMapping( value = "json/listPurchase", method = RequestMethod.GET)
	public Map listPurchase(  HttpSession session) throws Exception{
		
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
		
		return map;
	}
	
	
	@RequestMapping( value = "json/listPurchase", method = RequestMethod.POST)
	public Map listPurchase( @ModelAttribute("search") Search search, HttpSession session) throws Exception{
		
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
		
		return map;
	}
	
	
	@RequestMapping( value = "json/getPurchase/{tranNo}", method = RequestMethod.GET)
	public Purchase getPurchase( @PathVariable String tranNo ) throws Exception{
		
		System.out.println("\n>>> GetPurchase GET start <<< ");

		int tranNoInt = Integer.parseInt(tranNo);
		System.out.println("GetPurchase tranNo :: "+tranNoInt);
		
		// Business Logic 수행
		Purchase purchase = purchaseService.getPurchase(tranNoInt);
		Product product = new Product();
		product.setManuDate("20170000");
		purchase.setPurchaseProd(product);
		System.out.println("GetPurchase purchase :: "+purchase);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/getPurchase.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return purchase;
	}
	
	
	@RequestMapping( value = "json/updatePurchase/{tranNo}", method = RequestMethod.GET)
	public Purchase updatePurchase( @PathVariable String tranNo ) throws Exception{
		
		System.out.println("\n>>> updatePurchase GET start <<< ");

		int tranNoInt = Integer.parseInt(tranNo);
		System.out.println("updatePurchase tranNo :: "+tranNoInt);
		
		// Business Logic 수행
		Purchase purchase = purchaseService.getPurchase(tranNoInt);
		/*Product product = new Product();
		product.setManuDate("20170000");
		purchase.setPurchaseProd(product);*/
		System.out.println("updatePurchase purchase :: "+purchase);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/updatePurchaseView.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return purchase;
	}
	
	@RequestMapping( value = "json/updatePurchase", method = RequestMethod.POST)
	public Purchase updatePurchase( @RequestBody Purchase purchase ) throws Exception{
		
		System.out.println("\n>>> updatePurchase POST start <<< ");
		System.out.println("updatePurchase purchase :: "+purchase);
		
		// Business Logic 수행
		purchaseService.updatePurchase(purchase);
		
		purchase = purchaseService.getPurchase(purchase.getTranNo());
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/getPurchase.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return purchase;
	}
	
	

	@RequestMapping( value = "json/updateTranCode/{prodNo}/{tranCode}", method = RequestMethod.GET)
	public Purchase updateTranCode( @PathVariable String tranCode, @PathVariable String prodNo ) throws Exception{
		
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
		
		return purchase;
	
	}
	
	
	@RequestMapping( value = "json/updateTranCodeByProd/{prodNo}/{tranCode}", method = RequestMethod.GET)
	public Purchase UpdateTranCodeByProd( @PathVariable String tranCode, @PathVariable String prodNo ) throws Exception{
		
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
		modelAndView.setViewName("/product/listProduct/manage");
		
		return purchase;
	}
	
	/*@RequestMapping( value = "json/listOpinion/{prodNo}", method = RequestMethod.GET)
	public List<Opinion> listPurchase( @PathVariable String prodNo, HttpSession session) throws Exception{
		
		System.out.println(">>> /listOpinion POST start <<<");
		int prodNoInt = Integer.parseInt(prodNo);
		System.out.println("updatePurchase prodNo :: "+prodNoInt);
		
		
		// Business Logic 수행
		List<Opinion> list = opinionService.getOpinionList(prodNoInt);
		
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/listPurchase.jsp");
		modelAndView.addObject("list", list);
		
		
		return list;
	}*/
}
