package com.model2.mvc.service.opinion.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.service.domain.Opinion;
import com.model2.mvc.service.opinion.OpinionDao;

@Repository("opinionDaoImpl")
public class OpinionDaoImpl implements OpinionDao {
	
	///Field///
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	
	public void setSqlSession(SqlSession sqlSession){
		System.out.println("::"+getClass()+".setSqlSession() Call.....");
		this.sqlSession = sqlSession;
	}
		
	public OpinionDaoImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public int addComment(Opinion opinion) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("OpinionMapper.insertComment", opinion);
	}

	@Override
	public List<Opinion> getOpinionList(int prodNo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("OpinionMapper.getOpinionList", prodNo);
	}
	
	

}
