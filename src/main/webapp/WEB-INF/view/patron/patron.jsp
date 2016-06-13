<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<div>
	<form class="form-search patron-form-search" action="searchPatronbyPage.do" method="POST">
		<input type="hidden" name="page" class="page">
		<input type="text" class="input-large card-number" placeholder="Enter Member ID">
		<select class="span2 patron-select">
		</select>
		<a id="search-patron" class="btn">Search</a>
		<a class="btn btn-success add-patron-btn">Add Patron</a>
	</form>
	<div class="no-record_result" style="width:100%;float:left;">
		<h1>Result<small>${searchName } <span class="search-type">${searchType}</span> ${empty pagination.items ? 'No' : pagination.items} records</small></h1>
		<hr>
	</div>
	<div class="list-patron" style="float:left;">
		<%@ include file="../patron/list.jsp" %>
		<%@ include file="../pagination.jsp" %>
	</div>
	<div class="data-patron modal fade" tabindex='-1' role='dialog' aria-labelledby='myModalLable' aria-hidden='true' style="display:none;">
		<div class="modal-dialog">
			<div class="caption patron-caption modal-content">
				<div class="modal-header">
					<button id="close-button" type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria=hidden="true">&times;</span>
						<hr>
					</button>
					<h1 class="patron-name modal-title">&nbsp;<small class="patron-sex"></small></h1>
					
				</div>
				<div class="modal-body" >
					<p>Patron Card Number: <span class="patron-card-number"></span></p>
					<p>Mobile: <span class="patron-phone"></span></p>
					<p>Identity Card: <span class="patron-id-card"></span></p>
					<p>Work Place: <span class="patron-work-place"></span></p>
					<p>Address: <span class="patron-address"></span></p>
					<p>Membership: <span class="patron-type"></span></p>
					<p>Created Date: <span class="patron-create-time"></span></p>
					<p>Number of Borrow: <span class="patron-borrowed-book"></span></p>
					<p>Report Loss: <span class="patron-lost"></span></p>
				</div>
				<div class="modal-footer form-actions">
						<button class="btn btn-primary patron-modify">Modify</button>
						<button class="btn btn-danger patron-delete">Delete</button>
				</div>
			</div>
		</div>
	</div>
	<div class="no-record" style="width:50%;float:left;display:none;">
		<h1><small>No records</small></h1>
	</div>
	<div class="modify-patron modal fade" tabindex='-1' role='dialog' aria-labelledby='myModalLable' aria-hidden='true' style="display:none;">
		<div class="modal-dialog">
			<div class="caption patron-caption modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria=hidden="true">&times;</span>
						<hr>
					</button>
					<h1>Modify Patron</h1>
				</div>		
				<%@ include file="modify_patron.jsp" %>
			</div>
		</div>
	</div>
	<div class="add-patron modal fade" tabindex='-1' role='dialog' aria-labelledby='myModalLable' aria-hidden='true' style="display:none;">
		<div class="modal-dialog">
			<div class="caption patron-caption modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria=hidden="true">&times;</span>
						<hr>
					</button>
					<h1>Add Patron</h1>
				</div>
				<%@ include file="add_patron.jsp" %>
			</div>
		</div>
	</div>
</div>
<script>
function pageClick(page) {
	$(".page").val(page);
	$(".patron-form-search").submit();
}
$(document).ready(function() {
	$("#search-patron").click(function() {
		var cardNumber = $(".card-number").val();
		if (cardNumber == "undefined" || cardNumber == "" || cardNumber == null) {
			alert("Patron card number can not be empty");
			return ;
		}
		if (isNaN(cardNumber)) {
			alert("Patron card number can only be a number");
			return ;
		}
		var patronType = $(".patron-select").val();
		searchPatron({cardNumber:cardNumber, patronType:patronType});
	});
	$("#close-button").click(function(){
		 parent.location.reload(); 
	});
	$(".add-patron-btn").click(function() {
		$(".add-patron-cancel").click();
		$(".data-patron").hide();
		$(".no-record").hide();
		$(".modify-patron").hide();
		$(".add-patron").slideDown("slow");
		$(".add-patron").modal("show");
		$.post(baseUrl + "patron/getNewCardNumber.do",
				{},
				function(data) {
					$("input[name='cardNumber']").val(data);
				},
				'json'
		);
	});
	// Modify Patron
	$(".patron-modify").click(function() {
		$(".data-patron").hide();
		$(".data-patron").modal("hide");
		$(".no-record").hide();
		$(".add-patron").hide();
		$(".modify-patron").slideDown("slow");
		$(".modify-patron").modal("show");
		var cardNumber = $(".patron-card-number").html();
		var patronType = $(".patron-type").html();
		$.post(baseUrl + "patron/searchPatron.do", 
				{cardNumber:cardNumber, patronType:patronType},
				function(result) {
					var data = result.patron;
					$(".patron-card-number").val(data['cardNumber']);
					$(".patron-name").val(data['name']);
					if(data['sex'] == 'Male') {
						$("input[value='Male']").attr("checked", true);
						$("input[value='Female']").attr("checked", false);
					} else {
						$("input[value='Female']").attr("checked", true);
						$("input[value='Male']").attr("checked", false);
					}
					$(".patron-id-card").val(data['idCardNumber']);
					$(".patron-work-place").val(data['workPlace']);
					$(".patron-address").val(data['address']);
					$(".patron-phone").val(data['phone']);
					$(".patron-borrowed-book").val(data['borrowed']);
					$(".patron-select-lost").val(data['isLost']);
				},
				'json'
		);
	});
	
	// Delete Patron
	$(".patron-delete").click(function(){
		if(confirm("Confirm?")) {
			$.post(baseUrl + "patron/deletePatron.do",{cardNumber:$(".patron-card-number").html()},
					function(result){
						if (result.status == '200') {
							$(".data-patron").hide();
							$(".data-patron").modal("hide");
							alert("Delete Successfully");
						}
					},
			'json');
		}
		reload();
	});
});
function dateParser(milliSeconds) {
	var date = new Date();
	date.setMilliseconds(milliSeconds);
	var dateStr = date.getFullYear() + "-" + (date.getMonth()+1) + "-" + date.getDate();
	return dateStr;
}

// Search Patron
// data: {cardNumber:.., patronType:..}
function searchPatron(data) {
	$(".data-patron").hide();
	$(".no-record").hide();
	$(".add-patron").hide();
	$(".modify-patron").hide();
	$.post(baseUrl + "patron/searchPatron.do",
			data,
			function(map) {
				if(map.status == "300" ) {
					$(".no-record").show();
					$(".no-record_result").hide();
					return;
				}
				var data = map.patron;
				$(".patron-name").html(data['name'] + "&nbsp;<small>" + data["sex"] + "</small>");
				$(".patron-sex").html(data['sex']);
				$(".patron-card-number").html(data['cardNumber']);
				$(".patron-phone").html(data['phone']);
				$(".patron-id-card").html(data['idCardNumber']);
				$(".patron-work-place").html(data['workPlace']);
				$(".patron-address").html(data['address']);
				$(".patron-type").html(data['type']);
				$(".patron-create-time").html(dateParser(data['createTime']));
				$(".patron-borrowed-book").html(data['borrowed']);
				$(".patron-lost").html(data['isLost'] == "0" ? "No" : "Yes");
				$(".data-patron").slideDown("slow");
				$(".data-patron").modal("show");
				$(".modify-patron").modal("hide");
				$(".modify-patron").close();
			},
			'json');
}


	function reload(){
		 parent.location.reload(); 
	}
</script>

