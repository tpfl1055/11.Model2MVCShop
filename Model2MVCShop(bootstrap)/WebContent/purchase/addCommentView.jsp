<%@ page contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>


<html lang="ko">
<head>
<title>상품등록</title>

<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<!-- Jquery DatePicker -->
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    
    	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
        
       div.col-sm-7{
       		margin-top:9px;
       }
    </style>
    
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	function fncAddProduct(){
		//Form 유효성 검증
		var opinion=$("textarea").val();
		
	
		if(opinion == null || opinion.length<1){
			alert("상품 후기는 반드시 입력하여야 합니다.");
			return;
		}
		
	
		$("form").attr("method", "POST").attr("action", "/purchase/addComment").submit();
	
	}
	
	//============= "등록"  Event 연결 =============
	 $(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$( "button" ).on("click" , function() {
			fncAddProduct();
		});
	});	
	
	
	//============= "취소"  Event 처리 및  연결 =============
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("a[href='#']").on("click" , function() {
			history.go(-1);
		});
	});
	
	//============= "DatePicker"  Event 처리 및  연결 =============
	$( function() {
       $( "#datepicker" ).datepicker({
    	   changeMonth: true, 
           changeYear: true,
	       dateFormat: "yy/mm/dd" 
       });   
    } );
	
	</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		<hr/><hr/>
		<h1 class="bg-primary text-center">상품후기등록</h1>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" enctype="multipart/form-data">
		
		  <div class="form-group">
		    <label for="opProdNo" class="col-sm-offset-1 col-sm-2 control-label">상품번호</label>
		    <div class="col-sm-7">
		      ${ product.prodNo }
		      <input type="hidden" class="form-control" id="opProdNo" name="opProdNo" value="${ product.prodNo }">
		      
		    </div>
		  </div>
		
		  <div class="form-group">
		    <label for="opProdName" class="col-sm-offset-1 col-sm-2 control-label">상품명</label>
		    <div class="col-sm-7">
		    	${ product.prodName }
		    	<input type="hidden" class="form-control" id="opProdName" name="opProdName" value="${ product.prodName }">
		    	
		    </div>
		  </div>
		 		 	  
		  <!-- <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    <div class="col-sm-4">
		      <input type="text" readonly="readonly" class="form-control" id="datepicker" name="manuDate" placeholder="제조일자">
		    </div>
		   	
		  </div> -->
		  
		  <div class="form-group">
		    <label for="opinion" class="col-sm-offset-1 col-sm-2 control-label">상품 후기 입력</label>
		    <div class="col-sm-7">
		      <textarea  rows=12 cols=70 class="form-control" id="opinion" name="opinion" >좋아요^^
		      </textarea>
			</div>
		  </div>
		  		  	  
		  <div class="form-group">
		    <label for="opUploadFile" class="col-sm-offset-1 col-sm-2 control-label">상품이미지</label>
		    <div class="col-sm-7">
		      <input type="file" class="form-control" id="opUploadFile" name="opUploadFile" placeholder="상품이미지">
		    </div>
		  </div>
		  
		 		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >등&nbsp;록</button>
			  <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
		    </div>
		  </div>
		</form>
		
		
		<!-- form End /////////////////////////////////////-->
		
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
</body>
</html>