package com.model2.mvc.service.opinion;

import java.util.List;

import com.model2.mvc.service.domain.Opinion;


public interface OpinionDao {

	// INSERT
	public int addComment(Opinion opinion) throws Exception;
	
	/*// SELECT ONE
	public Product getProduct(int prodNo) throws Exception;
	
	
	public Product getProductByName(String prodName) throws Exception;

	
	// UPDATE
	public int updateProduct(Product product) throws Exception;
	
	// �Խ��� Page ó���� ���� ��üRow(totalCount)  return
	public int getTotalCount(Search search) throws Exception ;*/
	
	// SELECT LIST
	public List<Opinion> getOpinionList(int prodNo) throws Exception;
	
	
	
}
