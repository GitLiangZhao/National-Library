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
			<li><a href="${basePath }type/patronType.do">Patron Category</a></li>
			<li class="active"><a href="${basePath }type/bookType.do">Book Category</a></li>
			<li><a href="${basePath }librarian/manageUser.do">Librarian</a></li>
		</ul>
	</div>
	<!-- tab-panes -->
	<div class="tab-content">
		<div class="tab-pane active">
			<h4>Add Category</h4>
			<form class="form-horizontal" action="addBookType.do" method="POST">
				<div class="control-group">
					<div class="controls" style="margin-left:30px;">
						<input type="text" id="input-book-type" name="type" placeholder="Category Name">
						<input id="input-borrow-day" class="input-medium" type="text" name="borrowDay" placeholder="Borrow Days">
						<div class="input-append">
							<input id="input-day-fine" class="input-medium" type="text" name="dayFine" placeholder="Fine of Every Day">
							<span class="add-on">Cents</span>
						</div>
						<button class="btn btn-success add-type">Add</button>
						<span class="help-inline"></span>
					</div>
				</div>
			</form>
			<hr>
			<h4>Book Category</h4>
			<table class="table table-bordered span6">
				<thead>
					<tr>
						<th>Serial</th>
						<th>Category Name</th>
						<th>Borrow Days</th>
						<th>Fine of Every Day</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="t" items="${typeList }" varStatus="status">
						<tr>
							<td>${status.index }</td>
							<td class="type-name">${t.type }</td>
							<td>${t.borrowDay }</td>
							<td>${t.dayFine }Cents</td>
							<td><a href="javascript:void(0);" onclick="deleteType('${t.type}')" class="btn btn-danger">Delete</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
<script>
	$(".add-type").attr("disabled",true);
	$("#input-book-type , #input-borrow-day, #input-day-fine").keyup(function(){
		var typeNames = $(".type-name");
		for (var i = 0; i < typeNames.length; i++) {
			if ($(typeNames.get(i)).html() == $("#input-book-type").val()) {
				$(".control-group").addClass("error");
				$(".add-type").next().html("The category already exists");
				$(".add-type").attr("disabled",true);
				return;
			}
		}
		var num = $("#input-borrow-day").val();
		var dayfine = $("#input-day-fine").val();
		if (num != "" && dayfine != "" && !isNaN(num) && !isNaN(dayfine)) {
			$(".add-type").attr("disabled",false);
		} else {
			$(".add-type").attr("disabled",true);
		}
		$(".control-group").removeClass("error");
		$(".add-type").next().html("");
	});
	function deleteType(type) {
		$.post(baseUrl +"type/deleteBookType.do",{type:type},
			function(data) {
				window.location.href=baseUrl +"type/bookType.do";
		},'json');
		
	}
</script>
<%@ include file="../footer.jsp" %>