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
	span {color: red;}
</style>
</head>
<body>
<jsp:include page="common/nav.jsp"></jsp:include>
<div class="container" style="width: 60%;">
	<form form class="border bg-light p-3 " method="post" action="loginComplete.jsp">
		<div class="form-group">
			<legend>기본정보</legend>
			<div>
				<label class="form-label"><span>*</span> 아이디</label>
				<input type="text" class="form-control required" name="id" onkeyup="idCheck()"  />
				<div class="form-text text-bold" id="id-helper" ></div>
			</div>
				<label class="form-label"><span>*</span> 비밀번호 <input type="password" class="form-control" id="password1" name="password" /></label>
				<label class="form-label"><span>*</span> 비밀번호 확인 <input type="password" class="form-control" id="password2" onkeyup="passwordCheck()"/></label>
				<div id="password-helper" class="form-text text-bold"></div>
			<div>
				<span>*</span> 이름 <input type="text" class="form-control" name="name" />
				<span>*</span> 이메일 <input type="text" class="form-control" name="email" onkeyup="emailCheck()" />
				<div id="email-helper" class="form-text text-bold"></div>
			</div>
				<span>*</span> 휴대폰번호 <input type="text" class="form-control" name="tel" />
				<span>*</span> 주소 <input type="text" class="form-control" name="postCode" placeholder="우편번호"/>
				<input type="text" class="form-control" name="address" placeholder="기본주소"/>		
				<input type="text" class="form-control" name="detailAddress" placeholder="상세주소"/>		
			
			<a href="home.jsp" class="btn btn-secondary">취소</a>
			<button type="submit" class="btn btn-primary">회원가입</button>
		</div>
	</form>

   
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	let isIdChecked = false;
	let isEmailChecked = false;
	
	function idCheck() {
		
		let idHelperElement = document.querySelector("#id-helper");
		let idElement = document.querySelector("input[name=id]");			
	    let idValue = idElement.value;	
	    
	    let classList = idHelperElement.classList;
	    classList.remove("text-danger", "text-success");
	    
	    if (idValue === "") {
		       classList.add("text-danger");								 	
		       idHelperElement.textContent = "아이디는 필수입력값입니다.";			
		       isIdChecked = false;
		       return;         
		    }
		    if (idValue.length < 3) {
		       classList.add("text-danger");
		       idHelperElement.textContent = "아이디는 3글자 이상 20글자 이하로 작성합니다.";
		       isIdChecked = false;
		       return;
		    }
		    if (idValue.length > 20) {
		       classList.add("text-danger");
		       idHelperElement.textContent = "아이디는 3글자 이상 20글자 이하로 작성합니다.";
		       isIdChecked = false;
		       return;
		    }
		
		    idHelperElement.textContent = "";    
		    
		let xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {					
			if (xhr.readyState === 4 && xhr.status === 200) {	
				let jsonText = xhr.responseText;				
				let result = JSON.parse(jsonText);				     
				if(result.exist) {
					classList.add("text-danger");
					idHelperElement.textContent = "이미 존재하는 아이디입니다.";
					isIdChecked = false;
				} else {
					classList.add("text-success");
					idHelperElement.textContent = "사용가능한 아이디입니다.";
					isIdChecked = true;
				}
			}
	    }
	    xhr.open("GET", 'idCheck.jsp?id=' + idValue);						
	    xhr.send();		
	}
	
	// 비밀번호 일치여부 확인
	function passwordCheck() {
		let password1 = document.getElementById("password1").value;
		let password2 = document.getElementById("password2").value;
		let passwordHelperElement = document.getElementById("password-helper");
		
		let classList = passwordHelperElement.classList;
		classList.remove("text-danger", "text-success");
		
		if (password1 !== password2) {
			classList.add("text-danger");
			passwordHelperElement.textContent = "비밀번호가 일치하지 않습니다."; 
			return;
			
		}
		if (password1 === password2) {
			classList.add("text-success");
			passwordHelperElement.textContent = "비밀번호가 일치합니다."
		}
	}
	
	
	function emailCheck() {
		
		let emailHelperElement = document.getElementById("email-helper");
		let emailElement = document.querySelector("input[name=email]");	
		let emailValue = emailElement.value;
		
		let classList = emailHelperElement.classList;
	    classList.remove("text-danger", "text-success");
	    
	    if (emailValue === "") {
		       classList.add("text-danger");								 	
		       emailHelperElement.textContent = "아이디는 필수입력값입니다.";			
		       isEmailChecked = false;
		       return;         
		    }
	    
	    let xhr = new XMLHttpRequest();
	    
	    xhr.onreadystatechange = function() {					
			if (xhr.readyState === 4 && xhr.status === 200) {	
				let jsonText = xhr.responseText;				
				let result = JSON.parse(jsonText);				     
				if(result.exist) {
					classList.add("text-danger");
					emailHelperElement.textContent = "이미 존재하는 이메일입니다.";
					isEmailChecked = false;
				} else {
					classList.add("text-success");
					emailHelperElement.textContent = "사용가능한 이메일입니다.";
					isEmailChecked = true;
				}
			}
	    }
	    xhr.open("GET", 'emailCheck.jsp?email=' + emailValue);						
	    xhr.send();	
		
	}
	
	function submitRegisterForm() {
		let idField = document.querySelector("input[name=id]");
		if (idField.value === '') {
			alert("아이디는 필수입력값입니다.");
			idField.focus();
			return false;
		}
		
		if (!isIdChecked) {
			alert("유효한 아이디가 아니거나 사용할 수 없는 아이디입니다.")
			idField.focus();
			return false;
		}
		
		let passwordField = document.querySelector("input[name=password]");
		if (passwordField.value === '') {
			alert("비밀번호는 필수입력값입니다.");
			passwordField.focus();
			return false;
		}
		let nameField = document.querySelector("input[name=name]");
		if (nameField.value === '') {
			alert("이름은 필수입력값입니다.");
			nameField.focus();
			return false;
		}
		let emailField = document.querySelector("input[name=email]");
		if (emailField.value === '') {
			alert("이메일은 필수입력값입니다.");
			emailField.focus();
			return false;
		}
		
		if (!isEmailChecked) {
			alert("사용할 수 없는 이메일입니다.");
			emailField.focus();
			return false;
			
		}
		
		return true;
	} 


</script>
</body>
</html>