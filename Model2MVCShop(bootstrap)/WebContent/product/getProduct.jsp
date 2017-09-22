<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
<head>
	<title>��ǰ��ȸ</title>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
				
		//============= ��ǰ���� GET/UPDATE Event  ó�� =============
		 $(function() {
			
			 //manage//====================================================
			 $( "button:contains('Ȯ��')" ).on("click" , function() {
				//Debug..
				console.log($( "td.ct_btn01:contains('Ȯ��')" ).html());
				/* self.location = "/product/listProduct/manage" */
				self.location = "/product/listProduct/${menu}"
			});
			
			 $( "button:contains('����')" ).on("click" , function() {
				//Debug..
				console.log($( "button:contains('����')" ).html());
				history.go(-1);
			});
			
			//search//====================================================
			$( "button:contains('����')" ).on("click" , function() {
				//Debug..
				console.log($( "button:contains('����')" ).html());
				self.location = "/purchase/addPurchase/${product.prodNo}"
			});
			
			 $( "button:contains('�ڷ�')" ).on("click" , function() {
				//Debug..
				console.log($( "button:contains('�ڷ�')" ).html());
				self.location = "/product/listProduct/${menu}"
			});
		});
		
		
		//============= ��ǰ���� Tab Event  ó�� =============
		$(function(){
					
			/* $('#myTab a').click(function (e) {
				  e.preventDefault()
				  $(this).tab('show')
			}); */
			
			/* $(document).ready(function() {
	            $('a[data-toggle="tab"]').on('hidden.bs.tab', function(e){
	                alert("�̺�Ʈ �����");
	            });
	        }); */
			
		});
		
		
		
		/* 
		//============= ��ǰ�ı� GET Event  ó�� =============
		$(function(){
					
			$('#profile').click(function (e) {
				self.location = "/product/getProduct/${search}/${product.prodNo}"
			})
			
		})
		
		//============= ��ǰ���� GET Event  ó�� =============
		$(function(){
					
			$('#home').click(function (e) {
				self.location = "/product/getProduct/${search}/${product.prodNo}"
			})
			
		})
		 */
		
		//============= ��ǰ�ı� Event  ó�� =============
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
					  						+		"<div class='col-xs-4 col-md-2 '><strong>�����</strong></div>"
											+		"<div class='col-xs-8 col-md-4'>��ǰ �ı�</div>"
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
	
		
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<%-- <div class="container">
		
		<div class="page-header">
	       <h3 class=" text-info">��ǰ����</h3>
	       <h5 class="text-muted">��ǰ������  <strong class="text-danger">�Ĳ���</strong>�� Ȯ�����ּ���.</h5>
	    </div>
		
		<!--  �� div Start /////////////////////////////////////-->
		<div role="tabpanel">

		  <!-- Nav tabs -->
		  <ul class="nav nav-tabs" role="tablist">
		    <li role="presentation" class="active"><a href="#home" id="home-tab" aria-controls="home" role="tab" data-toggle="tab">������</a></li>
		    <li role="presentation"><a href="#profile" id="profile-tab" aria-controls="profile" role="tab" data-toggle="tab">��ǰ�ı�</a></li>
		    <!-- <li role="presentation"><a href="#messages" aria-controls="messages" role="tab2" data-toggle="tab">Messages</a></li>
		    <li role="presentation"><a href="#settings" aria-controls="settings" role="tab3" data-toggle="tab">Settings</a></li> -->
		  </ul>
		  
		  <br/>
		  
		  <div id = "myTabContent" class="tab-content">
  			<div role="tabpanel" class="tab-pane fade active in" aria-labelledby="home-tab">
				<div class="row">
			  		<div class="col-xs-4 col-md-2 "><strong>�� ǰ ��</strong></div>
					<div class="col-xs-8 col-md-4">${product.prodName}</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2 "><strong>��ǰ�̹���</strong></div>
			  		<div class="col-xs-8 col-md-4"><img src="../../../images/uploadFiles/${product.fileName}"/></div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2 "><strong>��ǰ ������</strong></div>
					<div class="col-xs-8 col-md-4">${product.prodDetail}	</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>��������</strong></div>
					<div class="col-xs-8 col-md-4">${product.manuDate}</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2 "><strong>����</strong></div>
					<div class="col-xs-8 col-md-4">${product.price}</div>
				</div>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2 "><strong>�������</strong></div>
					<div class="col-xs-8 col-md-4">${product.regDate}</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-md-12 text-center ">
			  				<c:if test = "${ ! empty menu && menu=='manage' }">
								<button type="button" class="btn btn-primary">��ǰ��������</button>
							</c:if>
							<c:if test = "${ ! empty menu && menu=='search' }">
								<button type="button" class="btn btn-primary">�ڷ�</button>
							</c:if>
							<c:if test = "${ ! empty menu && menu=='manage' }">
								<button type="button" class="btn btn-primary">Ȯ��</button>
							</c:if>
							<c:if test = "${ ! empty menu && menu=='search' }">
								<button type="button" class="btn btn-primary">����</button>
							</c:if>
			  		</div>
				</div>
				
				<br/>	
				</div>
				
				<div role="tabpanel" id="profile" class="tab-pane fade active in" aria-labelledby="profile-tab"><p></p>
					<div class="row">
			  			<div class="col-xs-4 col-md-2 "><strong>�����</strong></div>
						<div class="col-xs-8 col-md-4"><strong>��ǰ �ı�</strong></div>
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
		<!--  �� div End /////////////////////////////////////-->
 	</div> --%>
 	
 	<div class="container">
	
	<div class="page-header">
		<h3 class=" text-info">��ǰ����</h3>
	    <h5 class="text-muted">��ǰ������  <strong class="text-danger">�Ĳ���</strong>�� Ȯ�����ּ���.</h5>
	</div>

	<ul id="myTab" class="nav nav-tabs" role="tablist">
	  <li role="presentation" class="active"><a data-target="#home" id="home-tab" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true">�� ����</a></li>
	  <li role="presentation" class=""><a data-target="#profile" role="tab" id="profile-tab" data-toggle="tab" aria-controls="profile" aria-expanded="false">��ǰ �ı�</a></li>
	  
	</ul>
	<div id="myTabContent" class="tab-content">
	  <div role="tabpanel" class="tab-pane fade active in" id="home" aria-labelledby="home-tab">
				<div class="row">
					<br/>
			  		<div class="col-xs-4 col-md-2 "><strong>�� ǰ ��</strong></div>
					<div class="col-xs-8 col-md-4">${product.prodName}</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2 "><strong>��ǰ�̹���</strong></div>
			  		<div class="col-xs-8 col-md-4"><img src="../../../images/uploadFiles/${product.fileName}"/></div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2 "><strong>��ǰ ������</strong></div>
					<div class="col-xs-8 col-md-4">${product.prodDetail}	</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>��������</strong></div>
					<div class="col-xs-8 col-md-4">${product.manuDate}</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2 "><strong>����</strong></div>
					<div class="col-xs-8 col-md-4">${product.price}</div>
				</div>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2 "><strong>�������</strong></div>
					<div class="col-xs-8 col-md-4">${product.regDate}</div>
				</div>
				
				<hr/>
				
				<div class="row">
			  		<div class="col-md-12 text-center ">
			  				<c:if test = "${ ! empty menu && menu=='manage' }">
								<button type="button" class="btn btn-primary">��ǰ��������</button>
							</c:if>
							<c:if test = "${ ! empty menu && menu=='search' }">
								<button type="button" class="btn btn-primary">�ڷ�</button>
							</c:if>
							<c:if test = "${ ! empty menu && menu=='manage' }">
								<button type="button" class="btn btn-primary">Ȯ��</button>
							</c:if>
							<c:if test = "${ ! empty menu && menu=='search' }">
								<button type="button" class="btn btn-primary">����</button>
							</c:if>
			  		</div>
				</div>
				
				<br/>
	  </div>
	  <div role="tabpanel" class="tab-pane fade" id="profile" aria-labelledby="profile-tab">
					<div class="row">
						<br/>
			  			<div class="col-xs-4 col-md-2 "><strong>�����</strong></div>
						<div class="col-xs-4 col-md-8"><strong>��ǰ �ı�</strong></div>
			  			<div class="col-xs-4 col-md-2 "><strong>�����</strong></div>						
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
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->

</body>

</html>