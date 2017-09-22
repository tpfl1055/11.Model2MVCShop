<%-- <%@ page import="java.net.URLEncoder"%> --%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">

<head>
<title>상품 목록조회</title>

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
      
      .thumbnail a {
    	display: block;
   		width:300px; height:200px;
   		overflow:hidden;
   		margin:auto;
   		vertical-align:middle;
		}    
    </style>


    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">
	
		//=============    검색 / page 두가지 경우 모두  Event  처리	 =============	
		function fncGetList(currentPage) {
				$("#currentPage").val(currentPage)
				$("form").attr("method" , "POST").attr("action", "/product/listProduct/${menu}").submit();
		} 
		
		$(function(){
			$("button[type=button]").bind("click", function() {
				console.log( $("button[type=button]:contains('검색')").html() );
				fncGetList(1);
			});
			
			
		});		
		
		
		//=============    상품상세조회  Event  처리 		=============
		$(function(){
			$( "tr td:nth-child(2)").bind("click", function() {
				
				var prodNo = $( "input[name=prodNo]", $(this) ).val();
				
				//alert( $( "input[name=prodNo]", $(this) ).val() );
				console.log( $( "input[name=prodNo]", $(this) ).val() );
				self.location="/product/getProduct/${menu}/"+prodNo;
		
			});
		});

		
		//=============    상품상세조회(썸네일)  Event  처리 		=============
		$(function(){
			$("a.thumbnail_image").bind("click", function() {
				
				var prodNo = $( "input[name=prodNo]", $(this) ).val();
				
				//alert( $( "input[name=prodNo]", $(this) ).val() );
				console.log( $( ".thumbnail_image img", $(this) ).val() );
				self.location="/product/getProduct/${menu}/"+prodNo;
		
			});
		}); 
		
		/* $(function(){
			$( "h3.thumbnail_prodName input[name=prodNo]").bind("click", function() {
				
				var prodNo = $( "h3.thumbnail_prodName input[name=prodNo]", $(this) ).val();
				
				//alert( $( "input[name=prodNo]", $(this) ).val() );
				console.log( $( "h3.thumbnail_prodName, input[name=prodNo]", $(this) ).val() );
				self.location="/product/getProduct/${menu}/"+prodNo;
		
			});
		}); */
		
		
		//=============    상품상태변경  Event  처리 		=============
		$(function(){
			$( "button:contains('배송하기')").bind("click", function() {
				
				var prodNo = $( "input[name=prodNo]", $(this) ).val();
				var prodTranCode = $( "input[name=prodTranCode]", $(this) ).val();
				
				//alert( $( "input[name=prodNo]", $(this) ).val() );
				console.log( $( "input[name=prodNo]", $(this) ).val() );
				console.log( $( "input[name=prodTranCode]", $(this) ).val() );
				self.location="/purchase/updateTranCodeByProd/"+prodNo+"/"+prodTranCode;
		
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
		
		
		//=============    무한스크롤  Event  처리 		=============
				
		var currentPage= 1;	
		$(function(){
			$(document).scroll(function(){
				maxHeight = $(document).height();
				currentScroll = $(window).scrollTop() + $(window).height();
				
				console.log("\nmaxHeight ==> "+maxHeight); //941
				console.log("currentScroll ==> "+currentScroll); //bottom high
				
				var searchCondition = $(".form-control[name=searchCondition]").val();
				var searchKeyword = $(".form-control[name=searchKeyword]").val();
				
				
				
				console.log("\nsearchCondition ==> "+searchCondition);
				console.log("searchKeyword ==> "+searchKeyword);
				


				
				if(maxHeight <= currentScroll){
					currentPage++;
					console.log("currentPage ==> "+currentPage);
					$.ajax({
						url : "/product/listProduct/${menu}",
						method : "POST",
						data : { searchCondition : searchCondition, 
								 searchKeyword : searchKeyword,
								 currentPage : currentPage},
						dataType : "json",
						success : function(JSONData, status){
							console.log(status);
							console.log("JSONData : "+JSON.stringify(JSONData));
							console.log("List : "+JSONData.list);
							
							
							
						    
						
							for(i=0;i<JSONData.list.length;i++){
								
								var replace = "<div class='row_list'>"
											+ 	"<div class='col-sm-6 col-md-4' >"
											+ 		"<div class='thumbnail'>"
											+			"<a href='#' class='thumbnail_image'>"
											+				"<img src='../../images/uploadFiles/"+JSONData.list[i].fileName+"'>" 
											+				"<input type='hidden' id='prodNo' name='prodNo' value='"+JSONData.list[i].prodNo+"'/>"
											+			"</a>" 
											+			"<div class='caption'>"
											+				"<h3 class='thumbnail_prodName'>"+JSONData.list[i].prodName
											+				"<input type='hidden' id='prodNo' name='prodNo' value='"+JSONData.list[i].prodNo+"'/>"
											+				"</h3>"	
											+				"<p>가격 "+JSONData.list[i].price+" 원</p>"	
											+			"</div>"
											+ 		"</div>"
											+ 	"</div>"
											+ "</div>"
							
								console.log(replace);		
								
								$("div.container_list").append(replace);
								
							}
							
							
							
						}
					})
				}
			})
		})
			
			
			
			
	</script>
</head>


<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<%-- 
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
		   
	       <h3>${menu == 'manage'? '상품관리목록' : '상품검색' }</h3>
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
            <th align="left" >상품명</th>
            <th align="left">가격</th>
            <th align="left">등록일</th>
            <th align="left">현재상태</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="left">${ i }</td>
			  <td align="left"  title="Click : 상품정보">
			  <p data-photo="${ product.fileName }">
			  	<c:choose>
					<c:when test="${menu == 'manage' && empty product.prodTranCode}">
						<input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo }"/>
						 ${ product.prodName }
					</c:when>
					<c:when test="${menu == 'search' && empty product.prodTranCode}">
						<input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo }"/>
						${ product.prodName }
					</c:when>
					<c:otherwise>
					${product.prodName}
					</c:otherwise>
				</c:choose></p></td>
				
			  <td align="left">${product.price}</td>
			  <td align="left">${product.regDate}</td>
			  <td align="left">
			  	<i class="glyphicon glyphicon-ok" id= "${product.userId}"></i>
			  	<c:if test="${menu == 'manage'}">
				<c:choose>
					<c:when test="${product.prodTranCode == '1'}">
						<input type="hidden" id="prodNo" name="prodNo" value="${ product.prodNo }"/>						
						<input type="hidden" id="prodTranCode" name="prodTranCode" value="${ product.prodTranCode }"/>						
						
						구매 완료  배송하기
					</c:when>
					<c:when test="${product.prodTranCode == '2'}">
						배송중
					</c:when>
					<c:when test="${product.prodTranCode == '3'}">
						배송 완료
					</c:when>
					<c:otherwise>
						판매중
					</c:otherwise>
				</c:choose>
				</c:if>
				<c:if test="${menu == 'search'}">
				<c:choose>
					<c:when test="${empty product.prodTranCode}">
						판매중
					</c:when>
					<c:otherwise>
						재고 없음
					</c:otherwise>
				</c:choose>
				</c:if>
			  </td>
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
	   --%>
	  
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	  <div class="page-header text-info">
   		   <h3 align="center">${menu == 'search'? 'New Product' : 'Product Management' }</h3>
	  </div>
	  <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수
   		
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
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword" 
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
	  <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	  
	  <br/>
		<div class="container_list">		
			<div class="row_list">
				<input type="hidden" id="currentPageList" name="currentPageList" value="${resultPage.currentPage}"/>
			
				<c:set var="i" value="0" />
				<c:forEach var="product" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<div class="col-sm-6 col-md-4" >
						<div class="thumbnail">
							<a href="#" class="thumbnail_image">
								<img src="../../images/uploadFiles/${product.fileName}" width="300" height="350"> 
								<input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo }"/>
							</a> 
							<div class="caption">
								<h3 class="thumbnail_prodName">${ product.prodName }
									<input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo }"/>
								</h3>	
								<p>가격 ${ product.price } 원</p>
									<p>	
									 <c:if test="${menu == 'manage'}">
										<c:choose>
											<c:when test="${product.prodTranCode == '1'}">
												
												구매 완료 <!--  배송하기 -->
												<button type="button" class="btn btn-sm btn-primary">배송하기
													<span class="glyphicon glyphicon-plane" aria-hidden="true"></span>
													
													<input type="hidden" id="prodNo" name="prodNo" value="${ product.prodNo }"/>						
													<input type="hidden" id="prodTranCode" name="prodTranCode" value="${ product.prodTranCode }"/>						
												</button>
												
											</c:when>
											<c:when test="${product.prodTranCode == '2'}">
												배송중
											</c:when>
											<c:when test="${product.prodTranCode == '3'}">
												배송 완료
											</c:when>
											<c:otherwise>
												판매중
											</c:otherwise>
										</c:choose>
										</c:if>
										<c:if test="${menu == 'search'}">
										<c:choose>
											<c:when test="${empty product.prodTranCode}">
												판매중
											</c:when>
											<c:otherwise>
												재고 없음
											</c:otherwise>
										</c:choose>
									</c:if>
								
								</p>
								
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div> 
		
		
		  
		
	 
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<%-- <jsp:include page="../common/pageNavigator_new.jsp"/> --%>
	<!-- PageNavigation End... -->


	
</body>

</html>
