<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<div class="modal-body">
	<form class="form-horizontal modify-patron-form">
		<div class="control-group form-group">
			<label class="control-label" for="inputCardNumber">Patron Card Number</label>
			<div class="controls">
				<input class="patron-card-number" type="text" id="inputCardNumber" name="cardNumber" disabled> <span class="help-inline"></span>
			</div>
		</div>
		<div class="control-group form-group">
			<label class="control-label" for="inputName">Patron Name</label>
			<div class="controls">
				<input class="patron-name" type="text" id="inputName" name="name" onblur="validateInput(this)"> <span class="help-inline"></span>
			</div>
		</div>
		<div class="control-group form-group">
			<label class="control-label">Gender</label>
			<div class="controls">
				<label class="radio inline"> <input type="radio" value="Male"
					name="sex">Male
				</label> 
				<label class="radio inline"> <input type="radio" value="Female"
					name="sex">Female
				</label>
			</div>
		</div>
		<div class="control-group form-group">
			<label class="control-label" for="inputIdCard">Identity Card</label>
			<div class="controls">
				<input class="patron-id-card" type="text" id="inputIdCard" name="idCardNumber" onblur="validateInput(this,isNaN,'Number Only')"> <span class="help-inline"></span>
			</div>
		</div>
		<div class="control-group form-group">
			<label class="control-label" for="inputWorkPlace">Work Place</label>
			<div class="controls">
				<input class="patron-work-place" type="text" id="inputWorkPlace" name="workPlace" onblur="validateInput(this)"> <span class="help-inline"></span>
			</div>
		</div>
		<div class="control-group form-group">
			<label class="control-label" for="inputAddress">Address</label>
			<div class="controls">
				<input class="patron-address" type="text" id="inputAddress" name="address" onblur="validateInput(this)"> <span class="help-inline"></span>
			</div>
		</div>
		<div class="control-group form-group">
			<label class="control-label" for="inputType">Membership</label>
			<div class="controls">
				<select class="span2 patron-select" id="inputType" name="type">
				</select> <span class="help-inline"></span>
			</div>
		</div>
		<div class="control-group form-group">
			<label class="control-label" for="inputPhone">Mobile</label>
			<div class="controls">
				<input class="patron-phone" type="text" id="inputPhone" name="phone" onblur="validateInput(this,isNaN,'Number Only')"> <span class="help-inline"></span>
			</div>
		</div>
		<div class="control-group form-group">
			<label class="control-label" for="inputBorrowedNum">Number of Borrow</label>
			<div class="controls">
				<input class="patron-borrowed-book" type="text" id="inputBorrowedNum" name="borrowed" onblur="validateInput(this,isNaN,'Number Only')"> <span class="help-inline"></span>
			</div>
		</div>
		<div class="control-group form-group">
			<label class="control-label" for="inputIsLost">Report Loss </label>
			<div class="controls">
				<select class="span2 patron-select-lost" id="inputIsLost" name="isLost">
					<option value="0">No</option>
					<option value="1">Yes</option>
				</select> <span class="help-inline"></span>
			</div>
		</div>
	</form>
</div>
	<div class="form-actions modal-footer">
    	<a class="btn btn-primary modify-patron-submit">Modify</a>
    	<button type="reset" class="btn btn-danger modify-patron-cancel">Cancel</button>
    </div>
<script>
	$(".modify-patron-cancel").click(function(){
		$(".modify-patron").hide();
		$(".modify-patron").modal("hide");
	});
	$(".modify-patron-submit").click(function() {
		$(".patron-card-number").attr("disabled", false);
		var data = $(".modify-patron-form").serialize();
		$(".patron-card-number").attr("disabled", true);
		console.log(data);
		$.post(baseUrl + "patron/updatePatron.do",
				data,
				function(result) {
					if (result.status != '200') {
						alert('Failed to modify the patron');
					} else {
						searchPatron({cardNumber:result.cardNumber,patronType:result.type});
					}
				},
				'json'
		);
	});
</script>