package com.model2.mvc.service.opinion.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.service.domain.Opinion;
import com.model2.mvc.service.opinion.OpinionDao;
import com.model2.mvc.service.opinion.OpinionService;
import com.model2.mvc.service.product.ProductDao;


@Service("opinionServiceImpl")
public class OpinionServiceImpl implements OpinionService {
	
	
	///Field///
	@Autowired
	@Qualifier("opinionDaoImpl")
	OpinionDao opinionDao;
		
		
	public OpinionServiceImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(":: "+getClass()+" default Constructor Call.....");

	}
	
	///Method///
	//setter method//
	public void setOpinionDao(OpinionDao opinionDao) {
		System.out.println("::"+getClass()+".setOpinionDao Call.....");
		this.opinionDao = opinionDao;
	}

	@Override
	public int addComment(Opinion opinion) throws Exception {
		// TODO Auto-generated method stub
		return opinionDao.addComment(opinion);
	}

	@Override
	public List<Opinion> getOpinionList(int prodNo) throws Exception {
		// TODO Auto-generated method stub
		return opinionDao.getOpinionList(prodNo);
	}
	
	

}
