package com.model2.mvc.service.opinion;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Opinion;
import com.model2.mvc.service.domain.Product;



public interface OpinionService {

	public int addComment(Opinion opinion) throws Exception;

	
	/*public Product getProduct(int prodNo) throws Exception;
	

	public Product getProductByName(String prodName) throws Exception;


	public int updateProduct(Product product) throws Exception;*/

	
	public List<Opinion> getOpinionList(int prodNo) throws Exception ;


	
}
