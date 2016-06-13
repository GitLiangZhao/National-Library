<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ include file="../header.jsp" %>
<div class="container">
	<div class="tabbable">
		<ul class="nav nav-tabs">
			<li><a href="${basePath}patron/patron.do">Patrons</a></li>
			<li><a href="${basePath}book/book.do">Books</a></li>
			<li><a href="${basePath}borrow/borrow.do">Borrow</a></li>
			<li class="active"><a href="${basePath }type/patronType.do">Patron Category</a></li>
			<li><a href="${basePath }type/bookType.do">Book Category</a></li>
			<li><a href="${basePath }librarian/manageUser.do">Librarian</a></li>
		</ul>
	</div>
	<!-- tab-panes -->
	<div class="tab-content">
		<div class="tab-pane active">
			<h4>Add Category</h4>
			<form class="form-horizontal" action="addPatronType.do" method="POST">
				<div class="control-group">
					<div class="controls" style="margin-left:30px;">
						<input type="text" id="input-patron-type" name="type" placeholder="Category Name">
						<input id="input-borrow-number" class="input-medium" type="text" name="borrowNumber" placeholder="Number of Borrow">
						<button class="btn btn-success add-type">Add</button>
						<span class="help-inline"></span>
					</div>
				</div>
			</form>
			<hr>
			<h4>Patron Category</h4>
			<table class="table table-bordered span6">
				<thead>
					<tr>
						<th>Serial</th>
						<th>Category Name</th>
						<th>Number of Borrow</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="t" items="${typeList }" varStatus="status">
						<tr>
							<td>${status.index }</td>
							<td class="type-name">${t.type }</td>
							<td>${t.borrowNumber }</td>
							<td><a href="deletePatronType.do?type=${t.type }" class="btn btn-danger">Delete</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
<script>
	$(".add-type").attr("disabled",true);
	$("#input-patron-type , #input-borrow-number").keyup(function(){
		var typeNames = $(".type-name");
		for (var i = 0; i < typeNames.length; i++) {
			if ($(typeNames.get(i)).html() == $("#input-patron-type").val()) {
				$(".control-group").addClass("error");
				$(".add-type").next().html("The category already exists!");
				$(".add-type").attr("disabled",true);
				return;
			}
		}
		if ($("#input-borrow-number").val() != "" && 
				!isNaN($("#input-borrow-number").val()) && 
				$("#input-borrow-number").val() > 0 &&
				$("#input-patron-type").val() != "") {
			$(".add-type").attr("disabled",false);
		} else {
			$(".add-type").attr("disabled",true);
		}
		$(".control-group").removeClass("error");
		$(".add-type").next().html("");
	});
</script>
<%@ include file="../footer.jsp" %>