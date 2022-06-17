<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap demo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
	input[type=email] {display: inline-block; width: 60%}
	label {font-size: small;}
	#id-helper {font-size: small;
				color: red;	}
</style>
</head>

<body>
<jsp:include page="common/nav.jsp"></jsp:include>
<div class="container">
	<div class="row justify-content-center pt-5">
		<div class="col-6">
			<h3><strong>아이디 찾기</strong></h3>
			<%
				String foundId = request.getParameter("foundId");
				String name = request.getParameter("name");
			%>
						<form method="post" class="border py-5 px-5 mt-4" id="find-id-form" action="findId.jsp" >
						<%
							if (foundId != null && name != null) {
						%>
							<h3><%=name %>님의 아이디는<%=foundId %>입니다.</h3>
						<%
							} else {
						%>
							<div class="row">
								<div class="col-12">
									<h5>회원 아이디 찾기</h5>
									<div class="form-check form-check-inline">
										<label><input class="form-check-input" type="radio" id="inlineCheckbox1" name="findWay" value="email" onchange="change();" checked />이메일</label> 
									</div>
									<div class="form-check form-check-inline">
										<label><input class="form-check-input" type="radio" id="inlineCheckbox2" name="findWay" onchange="change();" value="tel">휴대폰번호</label> 
									</div>
								</div>
							</div>
							<div class="row border-bottom pb-3 mb-3">
								<div class="col-8">
									<div class="row">
										<div class="col-12 p-2">
											<input type="text" name="name" class="form-control" placeholder="이름" />
										</div>
										<div class="col-12 p-2">
											<input type="email" name="email" class="form-control" placeholder="가입메일주소" />
											<select name="domain" onchange="changeDomain();">
											<option selected="selected" disabled="disabled">직접입력</option>
											<option value="@naver.com">naver.com</option>
											<option value="@hanmail.net">hanmail.net</option>
											<option value="@gmail.com">gmail.com</option>
											<option value="@nate.com">nate.com</option>
											</select>
											<div id="id-helper"></div>
										</div>
									</div>
								</div>
								<div class="col-4">
									<button type="button" id="find-id-btn" class="btn btn-dark w-100 h-100"><strong>아이디찾기</strong></button>
								</div>
							</div>
							<%
							}
							%>
						</form>
					<div class="row justify-content-end">
						<div class="col-9">
							<a href="findPassword.jsp" class="btn btn-outline-secondary"><strong>비밀번호 찾기</strong></a>
							<a href="login.jsp" class="btn btn-primary"><strong>로그인 하기</strong></a>
						</div>
					</div>
			</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

	function changeDomain() {
		
		let inputEmailField = document.querySelector("input[name=email]");
		let inputEmailValue = inputEmailField.value;		// inputEmailValue는 단순히 value 값을 담고있는 변수
		let selectValue = document.querySelector("select[name=domain]").value;
		
		// 이메일의 input 값에 @가 포함되어 있으면 true를 반환한다.
		if(inputEmailValue.includes("@")) {
			let index = inputEmailValue.indexOf("@");
			let frontEmail = inputEmailValue.substring(0, index);
			inputEmailField.value = frontEmail + selectValue;		// input[type=email] 원본에 접근해야 한다.
			// console.log(inputEmailValue);
			
		} else {
			
			inputEmailField.value = inputEmailValue + selectValue;
		}
	}
	
	function change() {
		let checkedWay = document.querySelector("input[name=findWay]:checked").value;
		
	}
	
	// 버튼을 클릭했을 경우 : 이름과 이메일이 올바르게 입력되었을 때 폼을 제출한다.
	let btn = document.getElementById("find-id-btn");
	btn.onclick = function() {
		
		let helperField = document.getElementById("id-helper");
		let nameField = document.querySelector("input[name=name]");
		let emailField = document.querySelector("input[name=email]");
		
		let nameValue = nameField.value;
		let emailValue = emailField.value;
		
		if(nameValue === "") {
			helperField.textContent = "이름을 입력해주세요";
			nameField.focus();
			return;
		}
		
		if(emailValue === "") {
			helperField.textContent = "이메일을 입력해주세요";
			emailField.focus();
			return;
		}
		
		
		
		
		let xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if(xhr.readyState === 4 && xhr.status === 200) {
				let jsonText = xhr.responseText;				
				let result = JSON.parse(jsonText);	
				alert("결과 : " + result.pass + " 이름: " + result.name + " 아이디: " + result.foundId );
				if(result.pass) {
					//helperField.textContent = "회원정보를 찾았습니다.";
					document.getElementById("find-id-form").action = "findId.jsp?foundId=" + result.foundId + "&name=" + result.name; 
					document.getElementById("find-id-form").submit();	// 질문: 제출할 때 파라미터값 주는 법? 
				} else {
					helperField.textContent = "회원정보를 찾을 수 없습니다.";
					emailField.focus();
					return;
				}
			}
		}
		xhr.open("GET", 'emailCheck.jsp?job=findId&name=' + nameField.value + '&email=' + emailField.value);						
	    xhr.send();	
		
		
	}
	
	

</script>
</body>
</html>