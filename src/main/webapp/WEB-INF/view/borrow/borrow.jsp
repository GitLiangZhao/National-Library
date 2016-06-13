<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ include file="../header.jsp" %>
<div class="container">
	<div class="tabbable">
		<ul class="nav nav-tabs">
			<li><a href="${basePath}patron/patron.do">Patrons</a></li>
			<li><a href="${basePath}book/book.do">Books</a></li>
			<li class="active"><a href="${basePath}borrow/borrow.do">Borrow</a></li>
			<li><a href="${basePath }type/patronType.do">Patron Category</a></li>
			<li><a href="${basePath }type/bookType.do">Book Category</a></li>
			<li><a href="${basePath }librarian/manageUser.do">Librarian</a></li>
		</ul>
	</div>
	<!-- tab-panes -->
	<div class="tab-content">
		<div class="tab-pane active">
			<%@ include file="actions.jsp" %>
			<c:choose>
				<c:when test="${!empty borrowResult }">
					<%@ include file="borrow_result.jsp" %>
				</c:when>
				<c:otherwise>
					<%@ include file="borrow_book.jsp" %>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
<%@ include file="../footer.jsp" %>