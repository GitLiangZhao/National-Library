<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<div class="data-book thumbnail span6 clearfix">
	<div class="caption clearfix">
		<h1>Add Book</h1>
		<hr>
		<form class="form-horizontal add-book-form" action="addBook.do" method="POST">
			<div class="control-group">
				<label class="control-label" for="inputISBN">ISBN</label>
				<div class="controls">
					<input type="text" id="inputISBN" name="isbn" placeholder="978-7-111-29195-4"> <a class="btn btn-primary search-isbn">Search</a><span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="inputBookNumber">ISBN</label>
				<div class="controls">
					<input type="text" id="inputBookNumber" name="bookNumber" onblur="validateInput(this)"> <span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="inputBookName">Book Name</label>
				<div class="controls">
					<input type="text" id="inputBookName" name="bookName" onblur="validateInput(this)"> <span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="inputAuthor">Author</label>
				<div class="controls">
					<input type="text" id="inputAuthor" name="author" onblur="validateInput(this)"> <span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="inputPublisher">Publisher</label>
				<div class="controls">
					<input type="text" id="inputPublisher" name="publisher" onblur="validateInput(this)"> <span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="inputPublishDate">Date of Publish</label>
				<div class="controls">
					<input type="text" id="inputPublishDate" name="pubdate" onblur="validateInput(this)"> <span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="inputPrice">Price</label>
				<div class="controls">
					<input type="text" id="inputPrice" name="priceVo" onblur="validateInput(this)"> <span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="inputType">Category</label>
				<div class="controls">
					<select class="span2 book-type-select" id="inputType" name="bookType">
					</select> <span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="inputStoreLocation">Store Location</label>
				<div class="controls">
					<input type="text" id="inputStoreLocation" name="storeLocation" onblur="validateInput(this)"> <span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="inputNumber">Stock</label>
				<div class="controls">
					<input type="text" id="inputNumber" name="number" onblur="validateInput(this)"> <span class="help-inline"></span>
				</div>
			</div>
			<div class="form-actions">
		    	<a class="btn btn-primary add-book-submit">Add</a>
		    	<button type="reset" class="btn btn-danger add-book-cancel">Cancel</button>
		    </div>
		</form>
	</div>
	
</div>

	<div class="caption span5 clearfix">
		<img class="book-image" src="" style="widht:auto;height:auto;">
	</div>


<script>
	function validateInput(input, fn, msg) {
		var value = $(input).val();
		console.log(value);
		if (value =="") {
			$(input).closest(".control-group").removeClass("success").addClass("error");
			$(input).next().html("Can not be Empty");
			$(input).focus();
			return false;
		}
		else if (fn != null && fn(value)) {
			$(input).closest(".control-group").removeClass("success").addClass("error");
			$(input).next().html(msg);
			$(input).focus();
			return false;

		}
		else {
			$(input).closest(".control-group").removeClass("error").addClass("success");
			$(input).next().html("");
			return true;
		}
	}
	$(".search-isbn").click(function(){
		$(".search-isbn").html("Search...");
		$.post(baseUrl + "book/searchBookByISBN.do",
				{isbn:$("#inputISBN").val()},
				function(data){
					if (data.msg == "book_not_found") {
						$(".search-isbn").next().html("No ISBN match");
						$(".search-ibsn").focus();
						return ;
					}
					$(".search-isbn").html("Search");
					$(".search-isbn").next().html("");
					$("#inputBookNumber").val(data['id']);
					$("#inputBookName").val(data['title']);
					$("#inputAuthor").val(data['author'].join(" "));
					$("#inputPublisher").val(data['publisher']);
					$("#inputPublishDate").val(data['pubdate'].replace('.','-'));
					$("#inputPrice").val(data['price']);
					$(".book-image").attr("src",data['images']['large']);
				},
				'json'
		);
	});
	$(".add-book-submit").click(function() {
		var inputs = $(".add-book-form input");	
		for (var i = 0; i < inputs.length; i++) {
			var name = inputs.get(i).name;
			console.log(name);
			if (name == 'isbn') continue;
			else if (name == 'bookNumber' || name == 'number') {
				if (!validateInput(inputs.get(i), isNaN, "Number Only"))
					return false;
			}
			else if(name != ""){
				if(!validateInput(inputs.get(i)))
					return false;
			}
		}
		// check the ISBN is exists
		$.post(baseUrl + "book/checkBookNumber.do",
				{bookNumber:$("#inputBookNumber").val()},
				function(data){
					if(data == '300') {
						$("#inputBookNumber").closest(".control-group").removeClass("success").addClass("error");
						$("#inputBookNumber").next().html("ISBN is Exists");
						$("#inputBookNumber").focus();
						return false;
					} else {
						$("#inputBookNumber").closest(".control-group").removeClass("error").addClass("success");
						$("#inputBookNumber").next().html("");
						$(".add-book-form").submit();
					}
				},
				'json'
		);
		
	});
	
	$(".add-book-cancel").click(function(){
		$(".data-book").hide();
	});
</script>