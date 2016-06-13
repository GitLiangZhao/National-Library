<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<style>
	span {
		color:#0088CC;
	}
</style>
<div class="thumbnail" style="width:50%;float:left;display:block;">
		<div class="caption">
			<h1>Borrow</h1>
			<hr>
			<%@ include file="../alert_bar.jsp" %>
			<ul class="thumbnails">
				<li class="span5">
				<div class="thumbnail">
					<div class="caption">
					<form class="form-inline">
						<strong>Patron Card Number:</strong>
						<input type="text" class="input-small card-number">
						<a class="btn btn-primary patron-search">Search</a>
						<span class="patron-msg" style="color:red;"></span>
					</form>
					<p><strong>Patron Name:  </strong><span class="patron-name"></span></p>
					<p><strong>Membership:  </strong><span class="patron-type"></span></p>
					<p><strong>Limited to Borrow:  </strong><span class="borrow-number"></span></p>
					<p><strong>Borrowed:  </strong><span class="patron-borrowed"></span></p>
					</div>
				</div></li>
				<li class="span5">
				<div class="thumbnail">
					<div class="caption">
					<form class="form-inline">
						<strong>Book Number:</strong>
						<input type="text" class="input-small input-book-number">
						<a class="btn btn-primary book-search">Search</a>
						<span class="book-msg" style="color:red;"></span>
					</form>
					<p><strong>Book Name:  </strong><span class="book-name"></span></p>
					<p><strong>Author:  </strong><span class="author"></span></p>
					<p><strong>Type:  </strong><span class="book-type"></span></p>
					<p><strong>Limited Borrow Day:  </strong><span class="borrow-day"></span></p>
					<p><strong>Number of books:  </strong><span class="number"></span></p>
					<p><strong>Available:  </strong><span class="can-borrow"></span></p>
					</div>
				</div></li>
			</ul>
			<div class="form-actions">
				<a class="btn btn-primary borrow-submit">Confirm</a>
				<button class="btn btn-danger borrow-cancel">Cancel</button>
			</div>
		</div>
</div>
<script>
	$(".patron-search").click(function(){
		if ($(".card-number").val() == "") {
			$(".patron-msg").html("Please enter the card number");
			return;
		}
		$(".patron-msg").html("");
		$.post(baseUrl + "borrow/getPatronInfo.do",
			{patronNumber:$(".card-number").val()},
			function(data){
				if (data.status == '300')
					$(".patron-msg").html(data.msg);
				else {
					$(".patron-name").html(data.name);
					$(".patron-type").html(data.type);
					$(".borrow-number").html(data.canBorrowNumber);
					$(".patron-borrowed").html(data.borrowedNumber);
				}
			}, 
			'json'
		);
	});
	$(".book-search").click(function(){
		var bookNumber = $(".input-book-number").val();
		if (bookNumber == "") {
			$(".book-msg").html("Please enter the book number");
			return ;
		}
		$(".book-msg").html("");
		$.post(baseUrl + "borrow/getBookInfo.do",{bookNumber:bookNumber},
			function(data) {
				if (data.status == '300') {
					$(".book-msg").html(data.msg);
					return;
				} else {
					$(".book-name").html(data.name);
					$(".author").html(data.author);
					$(".book-type").html(data.type);
					$(".borrow-day").html(data.day);
					$(".number").html(data.number);
					$(".can-borrow").html(data.canBorrow);
				}
			},'json'
		);
	});
	$('.borrow-submit').click(function() {
		var patronName = $('.patron-name').html();
		var patronNumber =$(".card-number").val();
		if (patronName == "" || patronNumber == "") {
			alert("Please enter the patron card number");
			return;
		}
		var bookName = $(".book-name").html();
		var bookNumber = $(".input-book-number").val();
		if (bookName == "" || bookNumber == "") {
			alert("Please enter the book number");
			return;
		}
		if ($(".borrow-number").html() - $(".patron-borrowed").html() == 0) {
			alert("Limited borrow number");
			return;
		}
		if ($(".can-borrow").html() == '0') {
			alert("Unavailable");
			return ;
		}
		location.href = baseUrl + "borrow/borrowBook.do?patronNumber=" + patronNumber + "&bookNumber=" + bookNumber;
	});
</script>