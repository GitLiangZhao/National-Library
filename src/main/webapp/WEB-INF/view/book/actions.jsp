<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<div>
	<form class="form-search book-form-search" action="searchBook.do"  method="GET">
		<input type="hidden" class="page" name="page" value="${empty pagination.curPage ? 1 : pagination.curPage }">
		<input type="text" class="input-large book-number" placeholder="Title/ISBN" name="query" value="${searchName}">
		<select class="span2 book-type-select" name="bookType">
		</select>
		<a id="search-book" class="btn" >Search</a>
		<a href="${basePath }book/addBook.do" class="btn btn-success add-book-btn">Add Book</a>
	</form>
</div>
<script>
	var bookType = "${bookType}";
	console.log(bookType);
	$.post(baseUrl +"book/getBookTypes.do",{},function(data) {
		$('.book-type-select').empty();
		$(".book-type-select").append("<option value=''>All</option>");
		for(var i in data) {
			/*
			var option = "<option value='" + data[i]['type'] + "'>" + data[i]['type'] + "</option>";
			$(".book-type-select").append(option);
			*/
			//var type = $(".search-type").html();
			var type = bookType;
			console.log(type);
			var option;
			if (type == data[i]['type']) {
				option = "<option selected value='" + data[i]['type'] + "'>" + data[i]['type'] + "</option>";
			} else {
				option = "<option value='" + data[i]['type'] + "'>" + data[i]['type'] + "</option>";
			}
			$(".book-type-select").append(option);
		}
	}, 'json');
	
	$("#search-book").click(function(){
		/*
		var bookNumber = $(".book-number").val();
		if (bookNumber == "" || bookNumber == null) {
			alert("Please enter a ISBN");
			return ;
		}
		else if (isNaN(bookNumber)) {
			alert("ISBN only digits");
			return ;
		}
		*/
		$(".book-form-search").submit();
	});
	
</script>