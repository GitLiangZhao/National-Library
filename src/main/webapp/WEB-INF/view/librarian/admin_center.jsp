<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@ include file="../header.jsp" %>
<div class="container">
	<div class="tabbable">
		<ul class="nav nav-tabs">
			<li class="active"><a href="${basePath}patron/patron.do">Patrons</a></li>
<!-- 			<li class="active"><a href="#tab-patron" data-toggle="tab">Patrons</a></li> -->
			<li><a href="${basePath}book/book.do">Books</a></li>
			<li><a href="${basePath}borrow/borrow.do">Borrow</a></li>
			<li><a href="${basePath }type/patronType.do">Patron Category</a></li>
			<li><a href="${basePath }type/bookType.do">Book Category</a></li>
			<li><a href="${basePath }librarian/manageUser.do">Librarian</a></li>
		</ul>
	</div>
	<!-- tab-panes -->
	<div class="tab-content">
		<div class="tab-pane active" id="tab1">
			<%@ include file="../patron/patron.jsp" %>
		</div>
		<div class="tab-pane" id="tab-patron">
			
		</div>
		<div class="tab-pane" id="tab-book">
			<p>Books</p>
		</div>
		<div class="tab-pane" id="tab-borrow">
			<p>Borrow</p>
		</div>
		<div class="tab-pane" id="tab-patron-type">
			<p>Patron Category</p>
		</div>
		<div class="tab-pane" id="tab-book-type">
			<p>Book Category</p>
		</div>
		<div class="tab-pane" id="tab-user">
			<p>Librarian</p>
		</div>
	</div>
</div>
<script>
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
</script>
<%@ include file="../footer.jsp" %>
