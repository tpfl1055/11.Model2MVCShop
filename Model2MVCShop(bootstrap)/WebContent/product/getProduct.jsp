<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
<head>
	<title>상품조회</title>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
    </style>
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
				
		//============= 상품정보 GET/UPDATE Event  처리 =============
		 $(function() {
			
			 //manage//====================================================
			 $( "button:contains('확인')" ).on("click" , function() {
				//Debug..
				console.log($( "td.ct_btn01:contains('확인')" ).html());
				/* self.location = "/product/listProduct/manage" */
				self.location = "/product/listProduct/${menu}"
			});
			
			 $( "button:contains('수정')" ).on("click" , function() {
				//Debug..
				console.log($( "button:contains('수정')" ).html());
				history.go(-1);
			});
			
			//search//====================================================
			$( "button:contains('구매')" ).on("click" , function() {
				//Debug..
				console.log($( "button:contains('구매')" ).html());
				self.location = "/purchase/addPurchase/${product.prodNo}"
			});
			
			 $( "button:contains('뒤로')" ).on("click" , function() {
				//Debug..
				console.log($( "button:contains('뒤로')" ).html());
				self.location = "/product/listProduct/${menu}"
			});
		});
		
		
		//============= 상품정보 Tab Event  처리 =============
		$(function(){
					
			/* $('#myTab a').click(function (e) {
				  e.preventDefault()
				  $(this).tab('show')
			}); */
			
			/* $(document).ready(function() {
	            $('a[data-toggle="tab"]').on('hidden.bs.tab', function(e){
	                alert("이벤트 실행됨");
	            });
	        }); */
			
		});
		
		
		
		/* 
		//============= 상품후기 GET Event  처리 =============
		$(function(){
					
			$('#profile').click(function (e) {
				self.location = "/product/getProduct/${search}/${product.prodNo}"
			})
			
		})
		
		//============= 상품정보 GET Event  처리 =============
		$(function(){
					
			$('#home').click(function (e) {
				self.location = "/product/getProduct/${search}/${product.prodNo}"
			})
			
		})
		 */
		
		//============= 상품후기 Event  처리 =============
		/* $(function(){
			$("#profile-tab").click(function(){
				
				console.log("#profile-tab ==> "+$("#profile-tab").html()); //bottom high
				var userId = 
					$.ajax({
						url : "/purchase/json/listOpinion/${product.prodNo}",
						method : "GET",
						dataType : "json",
						success : function(JSONData, status){
							console.log(status);
							console.log("JSONData : "+JSON.stringify(JSONData));
							console.log("List : "+JSONData);
							
						
							for(i=0;i<JSONData.list.length;i++){
								
								var replace =	"<div class='row'>"
					  						+		"<div class='col-xs-4 col-md-2 '><strong>사용자</strong></div>"
											+		"<div class='col-xs-8 col-md-4'>상품 후기</div>"
											+	"</div>"
						
											+	"<hr/>"
							
											+	"<div class='row'>"
											+  		"<div class='col-xs-4 col-md-2'>"+${ user.userId }</div>
											+  		"<div class='col-xs-8 col-md-4'>"
											  			
											+  				"<img src='../../../images/uploadFiles/"+JSONData.opFileName+"'/>"
											+  				"<br/>"
											+  				JSONData.opinion
											+  		"</div>"
											+	"</div>"
							
								console.log(replace);		
								
								$("#profile").append(replace); 
											
								
							}
							
							
							
						}
					})
				
			})
		})*/ 
	
</script>

</head>


<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
		
	<!--  화면구성 div Start /////////////////////////////////////-->
	<%-- <div class="container">
		
		<div class="page-header">
	       <h3 class=" text-info">상품정보</h3>
	       <h5 class="text-muted">상품정보를  <strong class="text-danger">꼼꼼히</strong>를 확인해주세요.</h5>
	    </div>
		
		<!--  탭 div Start /////////////////////////////////////-->
		<div role="tabpanel">

		  <!-- Nav tabs -->
		  <ul class="nav nav-tabs" role="tablist">
		    <li role="presentation" class="active"><a href="#home" id="home-tab" aria-controls="home" role="tab" data-toggle="tab">상세정보</a></li>
		    <li role="presentation"><a href="#profile" id="profile-tab" aria-controls="profile" role="tab" data-toggle="tab">상품후기</a></li>
		    <!-- <li role="presentation"><a href="#messages" aria-controls="messages" role="tab2" data-toggle="tab">Messages</a></li>
		    <li role="presentation"><a href="#settings" aria-controls="settings" role="tab3" data-toggle="tab">Settings</a></li> -->
		  </ul>
		  
		  <br/>
		  
		  <div id = "myTabContent" class="tab-content">
  			<div role="tabpanel" class="tab-pane fade active in" aria-labelledby="home-tab">
				<div class="row">
			  		<div class="col-xs-4 col-md-2 "><strong>상 품 명</strong></div>
					<div class="col-xs-8 col-md-4">${product.prodName}</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2 "><strong>상품이미지</strong></div>
			  		<div class="col-xs-8 col-md-4"><img src="../../../images/uploadFiles/${product.fileName}"/></div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2 "><strong>상품 상세정보</strong></div>
					<div class="col-xs-8 col-md-4">${product.prodDetail}	</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
					<div class="col-xs-8 col-md-4">${product.manuDate}</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2 "><strong>가격</strong></div>
					<div class="col-xs-8 col-md-4">${product.price}</div>
				</div>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2 "><strong>등록일자</strong></div>
					<div class="col-xs-8 col-md-4">${product.regDate}</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-md-12 text-center ">
			  				<c:if test = "${ ! empty menu && menu=='manage' }">
								<button type="button" class="btn btn-primary">상품정보수정</button>
							</c:if>
							<c:if test = "${ ! empty menu && menu=='search' }">
								<button type="button" class="btn btn-primary">뒤로</button>
							</c:if>
							<c:if test = "${ ! empty menu && menu=='manage' }">
								<button type="button" class="btn btn-primary">확인</button>
							</c:if>
							<c:if test = "${ ! empty menu && menu=='search' }">
								<button type="button" class="btn btn-primary">구매</button>
							</c:if>
			  		</div>
				</div>
				
				<br/>	
				</div>
				
				<div role="tabpanel" id="profile" class="tab-pane fade active in" aria-labelledby="profile-tab"><p></p>
					<div class="row">
			  			<div class="col-xs-4 col-md-2 "><strong>사용자</strong></div>
						<div class="col-xs-8 col-md-4"><strong>상품 후기</strong></div>
					</div>
				
					<hr/>
					
					<c:set var="i" value="0" />
					<c:forEach var="opinion" items="${list}">
					<div class="row">
				  		<div class="col-xs-4 col-md-2 ">${ opinion.opUserId }</div>
				  		<div class="col-xs-8 col-md-4">
				  			
				  				<img src="../../../images/uploadFiles/${opinion.opFileName}"/>
				  				<br/>
				  				${ opinion.opinion }
				  		</div>
					</div>
					<hr/>
					</c:forEach>
					
				</div>				
			</div>
			
			
		</div>
		<!--  탭 div End /////////////////////////////////////-->
 	</div> --%>
 	
 	<div class="container">
	
	<div class="page-header">
		<h3 class=" text-info">상품정보</h3>
	    <h5 class="text-muted">상품정보를  <strong class="text-danger">꼼꼼히</strong>를 확인해주세요.</h5>
	</div>

	<ul id="myTab" class="nav nav-tabs" role="tablist">
	  <li role="presentation" class="active"><a data-target="#home" id="home-tab" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true">상세 정보</a></li>
	  <li role="presentation" class=""><a data-target="#profile" role="tab" id="profile-tab" data-toggle="tab" aria-controls="profile" aria-expanded="false">상품 후기</a></li>
	  
	</ul>
	<div id="myTabContent" class="tab-content">
	  <div role="tabpanel" class="tab-pane fade active in" id="home" aria-labelledby="home-tab">
				<div class="row">
					<br/>
			  		<div class="col-xs-4 col-md-2 "><strong>상 품 명</strong></div>
					<div class="col-xs-8 col-md-4">${product.prodName}</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2 "><strong>상품이미지</strong></div>
			  		<div class="col-xs-8 col-md-4"><img src="../../../images/uploadFiles/${product.fileName}"/></div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2 "><strong>상품 상세정보</strong></div>
					<div class="col-xs-8 col-md-4">${product.prodDetail}	</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
					<div class="col-xs-8 col-md-4">${product.manuDate}</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2 "><strong>가격</strong></div>
					<div class="col-xs-8 col-md-4">${product.price}</div>
				</div>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2 "><strong>등록일자</strong></div>
					<div class="col-xs-8 col-md-4">${product.regDate}</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-md-12 text-center ">
			  				<c:if test = "${ ! empty menu && menu=='manage' }">
								<button type="button" class="btn btn-primary">상품정보수정</button>
							</c:if>
							<c:if test = "${ ! empty menu && menu=='search' }">
								<button type="button" class="btn btn-primary">뒤로</button>
							</c:if>
							<c:if test = "${ ! empty menu && menu=='manage' }">
								<button type="button" class="btn btn-primary">확인</button>
							</c:if>
							<c:if test = "${ ! empty menu && menu=='search' }">
								<button type="button" class="btn btn-primary">구매</button>
							</c:if>
			  		</div>
				</div>
				
				<br/>
	  </div>
	  <div role="tabpanel" class="tab-pane fade" id="profile" aria-labelledby="profile-tab">
					<div class="row">
						<br/>
			  			<div class="col-xs-4 col-md-2 "><strong>사용자</strong></div>
						<div class="col-xs-4 col-md-8"><strong>상품 후기</strong></div>
			  			<div class="col-xs-4 col-md-2 "><strong>등록일</strong></div>						
					</div>
				
					<hr/>
					
					<c:set var="i" value="0" />
					<c:forEach var="opinion" items="${list}">
					<div class="row">
<%-- 				  		<div class="col-xs-4 col-md-2 ">${ opinion.opUserId }</div>
 --%>				  						  		<div class="col-xs-4 col-md-2 ">${ user.userId }</div>
 
 							<div class="col-xs-4 col-md-8">
				  			
				  				<img src="../../../images/uploadFiles/${opinion.opFileName}"/>
				  				<br/>
				  				${ opinion.opinion }
				  		</div>
				  		<div class="col-xs-4 col-md-2 ">${ opinion.opRegDate }</div>				  		
					</div>
					<hr/>
					</c:forEach>
					
	  </div>	  
				
	</div>
	  
	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->

</body>

</html>