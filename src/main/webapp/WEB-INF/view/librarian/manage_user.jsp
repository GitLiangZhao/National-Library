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
			<li><a href="${basePath }type/bookType.do">Book Category</a></li>
			<li class="active"><a href="${basePath }librarian/manageUser.do">Librarian</a></li>
		</ul>
	</div>
	<!-- tab-panes -->
	<div class="tab-content">
		<div class="tab-pane active">
			<%@ include file="../alert_bar.jsp" %>
			<h4>Add Librarian</h4>
			<form class="form-horizontal form-add-user" action="addUser.do" method="POST">
				<div class="control-group">
					<div class="controls" style="margin-left:30px;">
						<input type="text" id="input-username" name="username" placeholder="Librarian Name">
						<input id="input-password"  type="text" name="password" placeholder="Password">
						<select name="isAdmin" class="span2">
							<option value="1">Librarian</option>
						</select>
						<a class="btn btn-success add-user">Add</a>
						<span class="help-inline"></span>
					</div>
				</div>
			</form>
			<hr>
			<h4>Librarian</h4>
			<table class="table table-bordered span6">
				<thead>
					<tr>
						<th>Serial</th>
						<th>User Name</th>
						<th>Password</th>
						<th>Type</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="t" items="${userList }" varStatus="status">
						<tr>
							<td>${status.index }</td>
							<td class="user-name">${t.username }</td>
							<td>${t.password }</td>
							<td>Librarian</td>
							<td><a href="javascript:void(0);" onclick="deleteUser('${t.username}')" class="btn btn-danger">Delete</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
<script>
	$(".add-user").click(function(){
		var username = $("#input-username").val();
		var password = $("#input-password").val();
		var exist = false;
		$.each($(".user-name"), function(i,name) {
			if ($(name).html() == username) {
				$(".control-group").addClass("error");
				$(".add-user").next().html("The Librarian already exists!");
				exist = true;
				return;
			}
		});
		if (exist) return;
		if (username == "") {
			$(".control-group").addClass("error");
			$(".add-user").next().html("Librarian name cannot be empty");
			return ;
		} else if(password == ""){
			$(".control-group").addClass("error");
			$(".add-user").next().html("Password cannot be empty");
			return;
		} 
		
		$(".form-add-user").submit();
	});
	$(".form-add-user input").click(function(){
		$(".control-group").removeClass("error");
		$(".add-user").next().html("");
	});
	function deleteUser(name) {
		$.post(baseUrl + "librarian/deleteUser.do",{name:name},
			function(data) {
				window.location.href = baseUrl + "librarian/manageUser.do";
		},'json');
	}
</script>