<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<link rel="stylesheet" href="/css/admin.css" type="text/css">

	<!-- Bootstrap Carousel Slide -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<script   src="https://code.jquery.com/jquery-3.1.1.min.js" ></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!--   jQuery , Bootstrap CDN  -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
	<style>
        body {
        	/* background-color : #FFE2D6; */ 
            padding-top : 70px;
            
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
	 <!--  ///////////////////////// JavaScript ////////////////////////// -->
	 <script type="text/javascript">
	
		//=============    검색 / page 두가지 경우 모두  Event  처리	 =============	
		function fncGetList(currentPage) {
				$("#currentPage").val(currentPage)
				$("form").attr("method" , "POST").attr("action", "/product/listProduct/${menu}").submit();
		} 
		
		/* $(function(){
			$("button[type=button]").bind("click", function() {
				console.log( $("button[type=button]:contains('검색')").html() );
				fncGetList(1);
			});
			
			
		}); */		
		
		
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
			$("div.thumbnail").bind("click", function() {
				
				var prodNo = $( "input[name=prodNo]", $(this) ).val();
				
				//alert( $( "input[name=prodNo]", $(this) ).val() );
				console.log( $( "a.thumbnail_image", $(this) ).val() );
				self.location="../../product/getProduct/${menu}/"+prodNo;
		
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
			$( "tr td:nth-child(5):contains('배송하기')").bind("click", function() {
				
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
		
		/* $(document).ready(function () {
						        // for a filled square thumbnail
						        $('img').fakecrop();
						        // for a fixed width/height
						        $('img').fakecrop({fill: false});
						    }); */
		
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
			
			
	//=============    상품상세조회  Event  처리 		=============
	$(function(){
		$( "#btn btn-chatting").bind("click", function() {
			
			
			console.log( $( "#btn btn-chatting").html() );
			self.location="/product/getProduct/${menu}/"+prodNo;
	
		});
	});		
			
	</script>		
	
</head>
	
<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  아래의 내용은 http://getbootstrap.com/getting-started/  참조 -->	
   	<!-- Container start -->
   	<div class="container ">
   	
   	  <div id="myCarousel" class="carousel slide" data-ride="carousel">
	     	<!-- Indicators -->
	        <ol class="carousel-indicators">
	          <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
	          <li data-target="#myCarousel" data-slide-to="1"></li>
	          <li data-target="#myCarousel" data-slide-to="2"></li>
	        </ol>
	        <div class="carousel-inner" role="listbox">
	          <div class="item active">
	            <img class="first-slide" src="/images/main/sleep_d.jpg" alt="First slide">
	            <div class="container">
	            	<%-- <div class="carousel-caption">
	            		<h1>Example headline.</h1>
	            		<p>Note : If you're viewing this page via a <code>file://</code> URL, the "next" and "previous"
	            		   Glyphicon buttons on the left and right might not load/display properly due to web browser security rules.</p>
	            		<p><a class="btn btn-lg btn-primary" href="#" role="button">Sign up today</a></p>
	            	</div> --%>
	            </div>
	          </div>
	          <div class="item">
	            <img class="second-slide" src="/images/main/sub_dining_serato.jpg" alt="Second slide">
	            <div class="container">
	            	<!-- <div class="carousel-caption">
	            		<h1>Another Example headline.</h1>
	            		<p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. 
	            		   Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
	            		<p><a class="btn btn-lg btn-primary" href="#" role="button">Learn more</a></p>
	            	</div> -->
	            </div>
	          </div>
	          <div class="item">
	            <img class="third-slide" src="/images/main/sub_sofa_lode.jpg" alt="Third slide">
	            <div class="container">
	            	<!-- <div class="carousel-caption">
	            		<h1>Another Example headline.</h1>
	            		<p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. 
	            		   Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
	            		<p><a class="btn btn-lg btn-primary" href="#" role="button">Learn more</a></p>
	            	</div> -->
	            </div>
	          </div>
	         </div>
	        <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
	          <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
	          <span class="sr-only">Previous</span>
	        </a>
	        <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
	          <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
	          <span class="sr-only">Next</span>
	        </a>
	    </div>
		
      
    </div>
<!-- Container end -->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
	<button type="button" class="btn btn-chatting">채팅</button>
		
	  <div class="page-header text-info">
   		   <h3 align="center">New Product</h3>
	  </div>
	  <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수
   		
		    	</p>
		    </div>
		    
		    <%-- <div class="col-md-6 text-right">
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
	    	</div> --%>
	    	
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
								
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div> 
		
		
		  
		
	 
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
	
	
</body>

</html>