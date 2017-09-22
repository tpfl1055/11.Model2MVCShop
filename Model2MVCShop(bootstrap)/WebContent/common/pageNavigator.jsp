<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${ resultPage.currentPage <= resultPage.pageUnit }">
		◀ 이전
</c:if>
<c:if test="${ resultPage.currentPage > resultPage.pageUnit }">
		<a href="javascript:fncGetList('${ resultPage.currentPage-1}')">◀ 이전</a>
</c:if>

<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
	<a href="javascript:fncGetList('${ i }');">${ i }</a>
</c:forEach>

<c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">
		이후 ▶
</c:if>
<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
		<a href="javascript:fncGetList('${resultPage.endUnitPage+1}')">이후 ▶</a>
</c:if>



<%-- <%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
		
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
		
		$(function() {
	
			 $( $('span')[0] ).on("click" , function() {
				fncGetList('${ resultPage.currentPage-1}');
			});
			 
			 $( $('span')[1], $(this) ).on("click" , function() {
				fncGetList('${ i }');
			});
			
			 $( $('span')[2] ).on("click" , function() {
				fncGetList('${resultPage.endUnitPage+1}');
			});
			 
		});
		 
	</script>

</head>

<body>
	<form>
	
		<c:if test="${ resultPage.currentPage <= resultPage.pageUnit }">
				◀ 이전
		</c:if>
		<c:if test="${ resultPage.currentPage > resultPage.pageUnit }">
				<a href="javascript:fncGetList('${ resultPage.currentPage-1}')">◀ 이전</a>
				<span>◀ 이전</span>
		</c:if>
		
		<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
				<a href="javascript:fncGetList('${ i }');">${ i }</a>
				<span>${ i }</span>
		</c:forEach>
		
		<c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">
				이후 ▶
		</c:if>
		<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
				<a href="javascript:fncGetList('${resultPage.endUnitPage+1}')">이후 ▶</a>
				<span>이후 ▶</span>
		</c:if>
	
	</form>
</body>

</html> --%>