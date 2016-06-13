<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<style>
	span {
		color:#0088CC;
	}
</style>
<div class="thumbnail">
		<div class="caption">
			<h1>Records</h1>
			<hr>
			<%@ include file="../alert_bar.jsp" %>
			<ul class="thumbnails">
				<c:forEach var="x" varStatus="status" items="${records }">
				<li style="width:350px;">
				<div class="thumbnail">
					<div class="caption">
					<div>
						<h1 style="display:inline;">${status.index+1 }</h1>
						<div style="float:right;">
							<c:if test="${empty x.returnDate }">
								<a href="javascript:void(0);"class="btn btn-primary" onclick="returnBook(${x.patronNumber},${x.bookNumber})">Return</a>
							</c:if>
							<a href="javascript:void(0);" class="btn btn-danger" onclick="deleteBook(${x.patronNumber},${x.bookNumber})">Delete</a>
						</div>
					</div>
					<hr>
					<p><strong>Patron Card Number:   </strong><span class="patron-number">${x.patronNumber }</span></p>
					<p><strong>Patron Name:  </strong><span class="patron-name">${x.patronName }</span></p>
					<p><strong>Book Number:  </strong><span class="book-number">${x.bookNumber }</span></p>
					<p><strong>Book Name:  </strong><span class="book-name">${x.bookName }</span></p>
					<p><strong>Date of borrowed:  </strong><span class="borrow-date"><fmt:formatDate value="${x.borrowedDate }" pattern="yyyy-MM-dd"/></span></p>
					<p><strong>Date of return:  </strong><span class="return-date">
						<c:choose>
							<c:when test="${!empty x.returnDate }">
								<fmt:formatDate value="${x.returnDate }" pattern="yyyy-MM-dd"/>
							</c:when>
							<c:otherwise>
								Not yet return
							</c:otherwise>
						</c:choose>
					</span></p>
					</div>
				</div>
				</li>
				</c:forEach>
			</ul>
			<%@ include file="../pagination.jsp" %>
		</div>
</div>
<%@ include file="../modal.jsp" %>

<script>
	function returnBook(patronNumber, bookNumber) {
		$.post(baseUrl + "borrow/returnBook.do",
			{
				patronNumber:patronNumber,
				bookNumber:bookNumber
			},
			function(data){
				if (data.status == "300") {
					modal(data.msg);
					return ;
				} else {
					var msg = "Book returned";
					if (data.borrow.fine > 0) {
						msg += "Fine: $ <span style='color:red;'>" + data.borrow.fine;
					}
					modal(msg,function(){
						$(".borrow-form-search").submit();
					});
				}
			},
			'json'
		);
	}
	
	function deleteBook(patronNumber, bookNumber) {
		if (!confirm("Confirm?"))
			return;
		$.post(baseUrl + "borrow/deleteBook.do",
			{patronNumber:patronNumber,bookNumber:bookNumber},
			function(data){
				modal("Delete successfully");
			},'json');
	}
	function pageClick(page) {
		$(".input-pagination").val(page);
		$(".borrow-form-search").submit();
	}
</script>