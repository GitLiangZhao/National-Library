<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<div>
	<form class="form-search borrow-form-search" action="searchBorrow.do" method="GET">
		<input type="text" class="input-large patron-number" placeholder="Patron Card Number " name="patronNumber" value="${patronNumber }">
		<input type="text" class="input-large book-number" placeholder="Books Number" name="bookNumber" value="${bookNumber }">
		<input type="hidden" class="input-pagination" name="page">
		<button id="search-borrow-record" class="btn" >Search</button>
		<a href="${basePath }borrow/borrow.do" class="btn btn-success borrow-book-btn">Borrow</a>
		<button class="btn btn-success return-book-btn">Records</button>
	</form>
</div>