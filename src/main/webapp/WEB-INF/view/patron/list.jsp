<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<style>
div {  
 white-space:nowrap;  
 text-overflow:ellipsis;  
 -o-text-overflow:ellipsis;  
 overflow: hidden;  
 }  
</style>
<ul class="thumbnails">
	<c:forEach var="patron" items="${patrons }">
		<li class="span5 clearfix" id="${patron.cardNumber }" style="width:270px;">
			<div class="thumbnail clearfix">
				<div class="caption">
					<h3>${patron.name} <small>${patron.sex}</small></h3>
					<p>Member CardID：${patron.cardNumber }</p>
					<p>Mobile: ${patron.phone }</p>
					<p>Membership Type：${patron.type }</p>
					<p>Book Borrowed：${patron.borrowed}</p>
					<c:if test="${!empty user }">
						<button style = "margin-left:10px;" class="btn btn-danger patron-info pull-right" cardNumber="${patron.cardNumber }" patronType="${patron.type }">More</button>
						<c:if test="${!(patron.borrowed == 0)}">
							<a class="btn btn-primary pull-right" href="${basePath }borrow/searchBorrow.do?patronNumber=${patron.cardNumber}">Borrowed</a>
						</c:if>
					</c:if>
				</div>
			</div>
		</li>
	</c:forEach>
</ul>
<script>
	$(".patron-info").click(function() {
		var cardNumber = $(this).attr("cardNumber");
		var patronType = $(this).attr("patronType");
		searchPatron({cardNumber:cardNumber, patronType:patronType});
	});
</script>