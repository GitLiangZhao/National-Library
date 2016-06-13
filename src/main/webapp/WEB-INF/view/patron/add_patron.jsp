<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	
	
	<div class="modal-body">
		<form class="form-horizontal add-patron-form">
			<div class="control-group form-group">
				<label class="control-label" for="inputCardNumber">Patron Card Number</label>
				<div class="controls">
					<input type="text" id="inputCardNumber" name="cardNumber" disabled> <span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group form-group">
				<label class="control-label" for="inputName">Patron Name</label>
				<div class="controls">
					<input type="text" id="inputName" name="name" onblur="validateInput(this)"> <span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group form-group">
				<label class="control-label">Gender</label>
				<div class="controls">
					<label class="radio inline"> <input type="radio" value="Male"
						name="sex" checked>Male
					</label> 
					<label class="radio inline"> <input type="radio" value="Female"
						name="sex">Female
					</label>
				</div>
			</div>
			<div class="control-group form-group">
				<label class="control-label" for="inputIdCard">Identity Card</label>
				<div class="controls">
					<input type="text" id="inputIdCard" name="idCardNumber" onblur="validateInput(this,isNaN,'Numbers Only')"> <span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group form-group">
				<label class="control-label" for="inputWorkPlace">Work Place</label>
				<div class="controls">
					<input type="text" id="inputWorkPlace" name="workPlace" onblur="validateInput(this)"> <span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group form-group">
				<label class="control-label" for="inputAddress">Address</label>
				<div class="controls">
					<input type="text" id="inputAddress" name="address" onblur="validateInput(this)"> <span class="help-inline"></span>
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
					<input type="text" id="inputPhone" name="phone" onblur="validateInput(this,isNaN,'Number Only')"> <span class="help-inline"></span>
				</div>
			</div>
		</form>
	</div>
	<div class="form-actions modal-footer">
    	<a class="btn btn-primary add-patron-submit">Add</a>
    	<button type="reset" class="btn btn-danger add-patron-cancel">Cancel</button>
    </div>
<script>
	function validateInput(input, fn, msg) {
		var value = $(input).val();
		if (value =="") {
			$(input).closest(".control-group").removeClass("success").addClass("error");
			$(input).next().html("Not NULL");
			return false;
		}
		else if (fn != null && fn(value)) {
			$(input).closest(".control-group").removeClass("success").addClass("error");
			$(input).next().html(msg);
			return false;

		}
		else {
			$(input).closest(".control-group").removeClass("error").addClass("success");
			$(input).next().html("");
			return true;
		}
	}
	// Cancel to add the patron
	$(".add-patron-cancel").click(function() {
		$(".add-patron-form .control-group").removeClass("error success");	// Delete the error and success style
		$(".add-patron-form input").next().html("");			// Delete 'span' prompt message
		$(".add-patron").hide();
		$(".add-patron").modal("hide");
	});
	$(".add-patron-submit").click(function() {
		$(".add-patron").modal("hide");
		if (!validateInput($(".add-patron-form #inputName")))
			return;
		else if (!validateInput($(".add-patron-form #inputIdCard"),isNaN,"Number Only"))
			return;
		else if (!validateInput($(".add-patron-form #inputWorkPlace")))
			return;
		else if (!validateInput($(".add-patron-form #inputAddress")))
			return;
		else if(!validateInput($(".add-patron-form #inputPhone"), isNaN, "Number Only"))
			return;
		// add the patron
		$.post(baseUrl + 'patron/addPatron.do', 
				$(".add-patron-form").serialize(),
				function(data) {
					if (data.status != '200') {
						alert('Failed to add the patron');
					} else {
						searchPatron({cardNumber:data.cardNumber,patronType:data.type});
					}
				},
				'json'
		);
	});
</script>