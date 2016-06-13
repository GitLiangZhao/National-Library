<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@ include file="../header.jsp" %>
<div class="container">
	<div class="tabbable">
		<ul class="nav nav-tabs">
			<li><a href="${basePath}patron/patron.do">Patrons</a></li>
			<li class="active"><a href="${basePath}book/book.do">Books</a></li>
			<li><a href="${basePath}borrow/borrow.do">Borrow</a></li>
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
				<c:when test="${!empty bookResult }">
					<%@ include file="book_result.jsp" %>
				</c:when>
				<c:when test="${!empty addBook }">
					<%@ include file="add_book.jsp" %>
				</c:when>
				<c:when test="${!empty modifyBook }">
					<%@ include file="modify_book.jsp" %>
				</c:when>
				<c:when test="${!empty books }">
					<h1>Result<small>${searchName } <span class="search-type">${searchType}</span> ${pagination.items} records</small></h1>
					<hr>
					<%@ include file="list.jsp" %>
					<%@ include file="../pagination.jsp" %>
					<script>
						function pageClick(page) {
							console.log(page);
							$(".page").val(page);
							$(".book-type-select").val($("searchType"));
							$(".book-form-search").submit();
						}
						$(document).ready(function(){
							$.each($(".book-image"), function(i,x) {
								$.post(baseUrl + "book/getBookImage.do",{id:x.name},function(data){
									x.src = data.images.large;
								},'json');
							});
							
						});
					</script>
					
				</c:when>
			</c:choose>
			
		</div>
	</div>
</div>
<script>
	$("[href='#tab-patron']").click(function() {
		$.post(baseUrl +'patron/getPatronType.do',
				{},
				function(data) {
					$(".patron-select").empty();
					for(var i in data) {
						var option = "<option value='" + data[i]['type'] + "'>" + data[i]['type'] + "</option>";
						$(".patron-select").append(option);
					}
				}, 
				'json');
	});
</script>
<%@ include file="../footer.jsp" %>
