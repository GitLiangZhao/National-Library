<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ page import="au.gov.library.model.Book" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
	Book book = (Book)request.getAttribute("book");
	String pubdate = null;
	String storeDate = null;
	if (book != null) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
		pubdate = format.format(book.getPublishDate());
		storeDate = format.format(book.getStoreDate());
	}
%>
<div class="data-patron thumbnail" style="width:50%;float:left;display:block;">
		<div class="caption">
			<c:choose>
				<c:when test="${empty book }">
					<p>No Records</p>
				</c:when>
				<c:otherwise>
					<h1>${book.bookName}</h1>
					<hr>
					<%@ include file="../alert_bar.jsp" %>
					<p>ISBN:<span class="bookNumber">${book.bookNumber }</span></p>
					<p>Author:<span>${book.author }</span></p>
					<p>Publisher:<span>${book.publisher }</span></p>
					<p>Date of Publish: <span><%=pubdate %></span></p>
					<p>Price:<span>${book.price }</span></p>
					<p>Category:<span>${book.bookType }</span></p>
					<p>Store Location:<span>${book.storeLocation }</span></p>
					<p>Date of Store:<span ><%=storeDate %></span></p>
					<p>Borrowed:<span>${book.borrowedNumber }</span></p>
					<p>Stock:<span>${book.number}</span></p>
					<div class="form-actions">
						<a href="${basePath }book/modifyBook.do?bookNumber=${book.bookNumber}" class="btn btn-primary book-modify">Modify</a>
						<button class="btn btn-danger book-delete">Delete</button>
					</div>
				</c:otherwise>
			</c:choose>
			
		</div>
</div>
<script>
	$(".book-delete").click(function() {
		if (!confirm("Confirm?"))
			return;
		var bookNumber = $(".bookNumber").html();
		$.post(baseUrl + "book/deleteBook.do",{bookNumber:bookNumber},
				function(data){
					if (data == '200') {
						$('.caption').html('<div class="alert alert-success">Delete successfully</div>');
					}
				},'json'
		);
	});
</script>