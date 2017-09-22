package com.model2.mvc.service.domain;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;


public class Opinion {
	
	///Field///
	private int opNo;
	private String opFileName;
	private String opUserId;
	private int opProdNo;
	private String opProdName;
	private String opinion;
	private Date opRegDate;
	private MultipartFile opUploadFile;
	
	
	///Constructor///
	public Opinion(){
	}

	
	
	///Method///
	public Date getOpRegDate() {
		return opRegDate;
	}

	public void setOpRegDate(Date opRegDate) {
		this.opRegDate = opRegDate;
	}
	
	public int getOpNo() {
		return opNo;
	}


	public void setOpNo(int opNo) {
		this.opNo = opNo;
	}
	
	public String getOpFileName() {
		return opFileName;
	}


	public void setOpFileName(String opFileName) {
		this.opFileName = opFileName;
	}


	public int getOpProdNo() {
		return opProdNo;
	}


	public void setOpProdNo(int opProdNo) {
		this.opProdNo = opProdNo;
	}


	public String getOpProdName() {
		return opProdName;
	}


	public void setOpProdName(String opProdName) {
		this.opProdName = opProdName;
	}


	public String getOpinion() {
		return opinion;
	}


	public void setOpinion(String opinion) {
		this.opinion = opinion;
	}


	public MultipartFile getOpUploadFile() {
		return opUploadFile;
	}


	public void setOpUploadFile(MultipartFile opUploadFile) {
		this.opUploadFile = opUploadFile;
	}



	public String getOpUserId() {
		return opUserId;
	}



	public void setOpUserId(String opUserId) {
		this.opUserId = opUserId;
	}



	@Override
	public String toString() {
		return "Opinion [opNo=" + opNo + ", opFileName=" + opFileName + ", opUserId=" + opUserId + ", opProdNo="
				+ opProdNo + ", opProdName=" + opProdName + ", opinion=" + opinion + ", opRegDate=" + opRegDate
				+ ", opUploadFile=" + opUploadFile + "]";
	}



	



	
	
	

	
	
}