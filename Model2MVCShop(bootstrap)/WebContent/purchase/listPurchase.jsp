<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>


<html>
<head>
<title>구매 목록조회</title>

<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
    <link href="/css/animate.min.css" rel="stylesheet">
    <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
    <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
   <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
   <!-- jQuery UI toolTip 사용 JS-->
   <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>


    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">
		
		//=============    검색 / page 두가지 경우 모두  Event  처리 =============	
		function fncGetList(currentPage) {
				$("#currentPage").val(currentPage)
				$("form").attr("method" , "POST").attr("action", "/purchase/listPurchase").submit();
		} 
		
		$(function(){
			$("button[type=button]").bind("click", function() {
				console.log( $("button[type=button]:contains('검색')").html() );
				fncGetList(1);
			});	
		});		
		
		$(function(){
			$( "tr td:nth-child(1)" ).on("click" , function() {
				console.log($( this ).text().trim());
				var tranNo = $( "input[name=tranNo]", $(this) ).val();
				self.location ="/purchase/getPurchase/"+tranNo;
			});
		});
		
		$(function(){
			$( "tr td:nth-child(2)" ).on("click" , function() {
				console.log($( this ).text().trim());
				var userId = $( "input[name=userId]", $(this) ).val();
				self.location ="/user/getUser/"+userId;
			});
		});
				
		$(function(){
			$( "tr td:contains('물건도착')").bind("click", function() {
				
				var prodNo = $( "input[name=prodNo]", $(this) ).val();
				var prodTranCode = $( "input[name=prodTranCode]", $(this) ).val();
				
				//alert( $( "input[name=prodNo]", $(this) ).val() );
				console.log( $( "input[name=prodNo]", $(this) ).val() );
				console.log( $( "input[name=prodTranCode]", $(this) ).val() );
				self.location="/purchase/updateTranCode/"+prodNo+"/"+prodTranCode;
		
			});
		});
		
		/* $(function(){
			$("input:hidden[name=prodNo]").tooltip({
				items : "[data-photo]",
				content : function() {
						console.log( $("input:hidden[name=prodNo]").val() );
						var photo = $(this).data('photo');
						return "<img src='../../../images/uploadFiles/"+photo+"' width='200' height='200'/>";
					
				}	
			});
		}); */
		
		
		
	</script>

</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
		   
	       <h3><strong>${user.userId}</strong> 님의 구매 목록입니다.</h3>
	    </div>
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
						<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >구매자 이름</th>
            <th align="left">전화번호</th>
            <th align="left">배송현황</th>
            <th align="left">정보수정</th>
          </tr>
        </thead>
       
		<tbody>
		
		<c:set var="i" value="0" />
		<c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
				<td align="left">
					<input type="hidden" id="tranNo" name="tranNo" value="${ purchase.tranNo }"/>
					${ i }
				</td>
				<td align="left">${purchase.receiverName}</td>
				<td align="left">${purchase.receiverPhone}</td>
				<td align="left">
					<c:choose>
						<c:when test="${ purchase.tranCode == '3' }" >
							현재 배송 완료 상태입니다.
						</c:when>
						<c:otherwise>
							현재 구매 완료 상태입니다.
						</c:otherwise>
					</c:choose></td>
				
				<td align="left">
					<c:choose>
						<c:when test="${purchase.tranCode == '2'}">
							<input type="hidden" id="prodNo" name="prodNo" value="${ purchase.purchaseProd.prodNo }"/>
							<input type="hidden" id="prodTranCode" name="prodTranCode" value="${ purchase.tranCode }"/>				
							물건도착
							<span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>
								
						</c:when>
					</c:choose></td>
			
			</tr>
		</c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>


</html>