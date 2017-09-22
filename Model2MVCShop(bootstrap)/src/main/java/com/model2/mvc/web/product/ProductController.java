package com.model2.mvc.web.product;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.FileUploadException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Opinion;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.opinion.OpinionService;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;


@Controller
@RequestMapping("/product/*")
public class ProductController {

	///Field///
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("opinionServiceImpl")
	private OpinionService opinionService;
	
	
	///Constructor///
	public ProductController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass()+"Default Constructor Call");
	}
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	
	@RequestMapping( value="addProduct", method=RequestMethod.GET )
	public String addProduct(){
		
		System.out.println(">>> /product/addProduct::GET start <<<");

		return "forward:/product/addProductView.jsp";
	}
	
	@RequestMapping( value="addProduct", method=RequestMethod.POST )
	public String addProduct( Model model, HttpServletRequest request, @ModelAttribute("product") Product product) throws Exception{
		
		System.out.println(">>> /product/addProduct::POST start <<<");

		MultipartFile uploadFile = product.getUploadFile();
		
		if(uploadFile != null){
			String fileName = uploadFile.getOriginalFilename();
			System.out.println("uploaded file name :: "+fileName);
			
			String fileDirectory = request.getServletContext().getInitParameter("fileDirectory");
			System.out.println("uploaded file Directory :: "+fileDirectory);
			
			if(fileName != null && !fileName.equals("")){
				fileName = System.currentTimeMillis()+"_"+fileName;
				
				File file = new File(fileDirectory+fileName);
				uploadFile.transferTo(file);
				product.setFileName(fileName);
			}
			
		}
		
		System.out.println("addProduct product :: "+product);

		productService.addProduct(product);	
		model.addAttribute("product", product);
		return "forward:/product/addProduct.jsp";
	}
	
	
	
	@RequestMapping( value="listProduct/{menu}", method=RequestMethod.GET)
	public String listProduct( @PathVariable String menu, Model model) throws Exception{
		
		System.out.println(">>> /product/listProduct :: GET start <<<\n");
		System.out.println("menu :: "+menu);
		Search search = new Search();
				
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business Logic 수행
		Map<String, Object> map = productService.getProductList(search);
		
		Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("menu", menu);
		
		
		return "forward:/product/listProduct.jsp";
	}
	
	
	@RequestMapping( value="listProduct/{menu}", method=RequestMethod.POST)
	public String listProduct( @ModelAttribute("search") Search search, @PathVariable String menu, Model model) throws Exception{
		
		System.out.println("\n>>> /product/listProduct :: POST start <<<");
		System.out.println("listProduct search :: "+search);
		System.out.println(menu );
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
			System.out.println("CurrentPage"+search.getCurrentPage());
		}/*else{
			int currentPage = search.getCurrentPage() + 1;
			search.setCurrentPage(currentPage);
			System.out.println("CurrentPage"+search.getCurrentPage());

		}*/
		
		/*int currentPage = search.getCurrentPage() + 1;
		search.setCurrentPage(currentPage);
		System.out.println("CurrentPage"+search.getCurrentPage());*/
		search.setPageSize(pageSize);
		
		// Business Logic 수행
		Map<String, Object> map = productService.getProductList(search);
		
		Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		System.out.println(search.getStartRowNum());
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("menu", menu);
		
		return "forward:/product/listProduct.jsp";
	}
	
	
	@RequestMapping("/getProduct/{menu}/{prodNo}")
	public String getProduct( @PathVariable String menu, @PathVariable String prodNo, Model model) throws Exception{
		
		System.out.println(">>> /product/getProduct::GET start <<<");
		
		
		// Business Logic 수행
		int prodNoInt = Integer.parseInt(prodNo);
		Product product = productService.getProduct(prodNoInt);
		
		List<Opinion> list = opinionService.getOpinionList(prodNoInt);
		
		// Model 과 View 연결
		model.addAttribute("product", product);
		model.addAttribute("menu", menu);
		model.addAttribute("list", list);
		
		if(menu.equals("manage")){
			return "forward:/product/updateProductView.jsp";
		}else if(menu.equals("search")){
			return "forward:/product/getProduct.jsp";
		}else{
			return null;
		}
		
	}
	
	
	@RequestMapping( value="updateProduct/{prodNo}", method=RequestMethod.GET)
	public String updateProduct( @PathVariable String prodNo, Model model) throws Exception{
		
		System.out.println(">>> /product/updateProduct::GET start <<<");
		
		int prodNoInt = Integer.parseInt(prodNo);
		
		// Business Logic 수행
		Product product = productService.getProduct(prodNoInt);
		
		// Model 과 View 연결
		model.addAttribute("product", product);

		return "forward:/product/updateProductView.jsp";
	}
	
	
	@RequestMapping( value="updateProduct", method=RequestMethod.POST)
	public String updateProduct( HttpServletRequest request, Model model, @ModelAttribute("product") Product product) throws Exception{
		
		System.out.println(">>> /product/updateProduct::POST start <<<");
		System.out.println(product);
		MultipartFile uploadFile = product.getUploadFile();
		
		if(uploadFile != null){
			String fileName = uploadFile.getOriginalFilename();
			System.out.println("uploaded file name :: "+fileName);
			
			String fileDirectory = request.getServletContext().getInitParameter("fileDirectory");
			System.out.println("uploaded file Directory :: "+fileDirectory);
			
			if(fileName != null && !fileName.equals("")){
				fileName = System.currentTimeMillis()+"_"+fileName;
				
				File file = new File(fileDirectory+fileName);
				uploadFile.transferTo(file);
				product.setFileName(fileName);
			}
			
		}
		
		// Business Logic 수행
		productService.updateProduct(product);
		// Model 과 View 연결
		model.addAttribute("product", product);
		model.addAttribute("menu", "manage");
		
		return "forward:/product/getProduct.jsp";
	}
	
	
	/*@RequestMapping( value="updateProduct/{prodNo}", method=RequestMethod.POST)
	public String updateProduct( HttpServletRequest request, Model model, @PathVariable String prodNo, @ModelAttribute("product") Product product) throws Exception{
		
		System.out.println(">>> /product/updateProduct::POST start <<<");
		
		int prodNoInt = Integer.parseInt(prodNo);
		product.setProdNo(prodNoInt);
		
		MultipartFile uploadFile = product.getUploadFile();
		
		if(uploadFile != null){
			String fileName = uploadFile.getOriginalFilename();
			System.out.println("uploaded file name :: "+fileName);
			
			String fileDirectory = request.getServletContext().getInitParameter("fileDirectory");
			System.out.println("uploaded file Directory :: "+fileDirectory);
			
			if(fileName != null && !fileName.equals("")){
				fileName = System.currentTimeMillis()+"_"+fileName;
				
				File file = new File(fileDirectory+fileName);
				uploadFile.transferTo(file);
				product.setFileName(fileName);
			}
			
		}
		
		// Business Logic 수행
		productService.updateProduct(product);
		
		// Model 과 View 연결
		model.addAttribute("product", product);
		model.addAttribute("menu", "manage");
		
		return "forward:/product/getProduct.jsp";
	}*/
}
