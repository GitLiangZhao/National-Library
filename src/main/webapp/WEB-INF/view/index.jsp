<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ include file="header.jsp"%>

<div class="container">
	<c:choose>
		<c:when test="${!empty success }">
			<div class="alert alert-success">${success}</div>
		</c:when>
		<c:when test="${!empty error}">
			<div class="alert alert-error">${success }</div>
		</c:when>
	</c:choose>
	<div class="hero-unit">
		<h2>Welcome to National Library AU</h2>
		<p>This is a example system of Library Management</p>
	</div>
	<div >
		<div class="span2">
			<h4>Category:Books</h4>
			<hr>
			<ul class="nav nav-list">
				<li class="active"><a href="#">All</a></li>
				<c:forEach var="type" items="${bookTypes}">
					<li><a href="${basePath}book/searchBookUserType.do?type=${type.type}">${type.type}</a></li>
				</c:forEach>
   			</ul>
		</div>
		<div class="span9">
		<h4>News:Books</h4>
		<hr>
		<ul class="thumbnails">
			  <c:forEach var="book" items="${books }">
              <li class="span7 clearfix">
                <div class="thumbnail clearfix">
                  <img style="width:auto;height:100px;margin-right:10px;" name="${book.bookNumber }" class="book-image pull-left span2 clearfix" >
                  <div class="caption">
                    <h4><a target="_blank" href="${basePath }book/getBookDetail.do?bookNumber=${book.bookNumber}">《${book.bookName }》</a></h4>
                    <p>Author：${book.author }</p>
                    <p>Available/Stock：${book.number-book.borrowedNumber }/${book.number}</p>
                    <!--<p><a target="_blank" class="btn btn-primary btn-block" href="${basePath }book/getBookDetail.do?bookNumber=${book.bookNumber}">more</a>-->
                  </div>
                </div>
              </li>
              </c:forEach>
        </ul>
        <a href="javascript:void(0);" class="see-more" >More...</a>
        </div>
        <!--
        <div id="masonry" style="width:100%;">
        	<c:forEach var="book" items="${books }">
                <div class="item thumbnail" style="float:left;width:250px;margin-bottom:20px;margin-right:20px;">
                  <img style="width: auto; height:220px;" name="${book.bookNumber }" class="book-image clearfix" src="${basePath }img/loading.gif">
                  <div class="caption">
                    <h5>《${book.bookName }》</h5>
                    <p>Author：${book.author }</p>
                    <p>Available/Stock：${book.number-book.borrowedNumber }/${book.number}</p>
                    <p><a target="_blank" class="btn btn-primary" href="${basePath }book/getBookDetail.do?bookNumber=${book.bookNumber}">More</a>
                  </div>
                </div>
              </c:forEach>
        </div>
        -->
	</div>
</div>
<script>
	$(document).ready(function(){
		$.each($(".book-image"), function(i,x) {
			$.post(baseUrl + "book/getBookImage.do",{id:x.name},function(data){
				x.src = data.images.large;
			},'json');
		});
		var $container = $('#masonry');
		// initialize
		$container.masonry({
		  itemSelector: '.item'
		});
		
		$(".see-more").click(function(){
			$(".form-book-search").submit();
		});
	});
	
</script>

<%@ include file="footer.jsp"%>