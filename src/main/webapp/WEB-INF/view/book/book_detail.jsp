<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ include file="../header.jsp"%>
<style>
	.p1{
		color:#666666;
	}
</style>
<div class="container">
	<h1>${book.bookName }</h1>
	<hr>
	<div>
		<div style="float:left;">
			<img class="book-img" src="${basePath }img/loading.gif" style="width:200px;height=:auto;">
		</div>
		<div style="float:left;margin-left:10px;">
			<p><span class="p1">ISBN: </span><span class="book-number">${book.bookNumber }</span></p>
			<p><span class="p1">Author: </span>${book.author }</p>
			<p><span class="p1">Publisher: </span>${book.publisher }</p>
			<p><span class="p1">Date of Publish: </span><fmt:formatDate value="${book.publishDate }" pattern="yyyy-MM"></fmt:formatDate></p>
			<p><span class="p1">Price: </span>${book.price}.00</p>
			<p><span class="p1">Category: </span>${book.bookType }</p>
			<p><span class="p1">Store Location: </span>${book.storeLocation }</p>
			<p><span class="p1">Date of Store: </span><fmt:formatDate value="${book.storeDate }" pattern="yyyy-MM"></fmt:formatDate></p>
			<p><span class="p1">Borrowed: </span>${book.borrowedNumber }</p>
			<p><span class="p1">Stock: </span>${book.number }</p>
		</div>
	</div>
	
</div>
<div class="container">
		<hr>
	<div>
		<h2>Introduction of Author</h2>
		<p class="author-intro">No Content</p>
	</div>
	<div>
		<h2>Content</h2>
		<p class="summary">No Content</p>
	</div>
	<div>
		<h2>Catalog</h2>
		<p class="catalog">No Content</p>
	</div>
</div>
<script>
	$(document).ready(function(){
		
		$.post(baseUrl + "book/getBookImage.do",{id:$(".book-number").html()},
			function(data) {
				$(".book-img").attr("src", data.images.large);
		},'json');

		$.post(baseUrl + "book/getBookInfo.do", {id:$(".book-number").html()},
			function(data) {
				if (data['author_intro'])
					$(".author-intro").html(data['author_intro']);
				if (data['summary'])
					$(".summary").html(data['summary']);
				if (data['catalog'])
					$(".catalog").html(data['catalog']);
		},'json');
	});
</script>

<%@ include file="../footer.jsp"%>