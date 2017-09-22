<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    

<!DOCTYPE html>
<Html>
<head>
<meta charset='EUC-KR'>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script>
        $(document).ready(function() {
            $('a[data-toggle="tab"]').on('hidden.bs.tab', function(e){
                alert("이벤트 실행됨");
            });
        });
</script>
</head>
<body>
<div class="container">
	<h2>탭</h2>
	<ul id="myTab" class="nav nav-tabs" role="tablist">
	  <li role="presentation" class="active"><a data-target="#home" id="home-tab" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true">Home</a></li>
	  <li role="presentation" class=""><a data-target="#profile" role="tab" id="profile-tab" data-toggle="tab" aria-controls="profile" aria-expanded="false">Profile</a></li>
	  
	</ul>
	<div id="myTabContent" class="tab-content">
	  <div role="tabpanel" class="tab-pane fade active in" id="home" aria-labelledby="home-tab">
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
	  <div role="tabpanel" class="tab-pane fade" id="profile" aria-labelledby="profile-tab">
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

</body>
</html>
