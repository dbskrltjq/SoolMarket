<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap demo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
	.radioDiv {text-align: left;}
	p {font-size: small;}
	h3 {text-align: left;}

</style>
</head>
<body class="text-center">
<jsp:include page="common/nav.jsp">
	<jsp:param  name="menu" value="login" />
</jsp:include>

<div class="container w-60" >
	<div class="row justify-content-center pt-5">
		<div class="col-6">
			<h3><strong>로그인</strong></h3>
	  		<form method="post" class="border p-5 mb-5" id="login-form" action="login.jsp?job=user"  onsubmit="return submitLoginForm()">
	    		<img class="mb-4" src="images/mainLogo.png" alt="" width="400" height="130">
	    		<div class="radioDiv mt-5">
		    		 <div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="radiobox" id="user-radio" value="option1" checked onchange="changeRadio();">
						<label class="form-check-label" for="inlineCheckbox1">회원</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="radiobox" id="admin-radio" value="option2" onchange="changeRadio();">
						<label class="form-check-label" for="inlineCheckbox2">관리자</label>
					</div>
		    		<p>관리자로 로그인하실 경우 관리자에 표시해주세요.</p>
				</div>
	    		<h1 class="h3 mb-3 fw-normal" id="login-title">회원 로그인</h1>
		<%
			String fail = request.getParameter("fail");
		
			if ("invalid".equals(fail)) {
		%>
				<div class="alert alert-danger">
					<strong>로그인 실패</strong> 아이디 혹은 비밀번호가 올바르지 않습니다.
				</div>
		<%
			} else if ("deleted".equals(fail)) {
		%>
				<div class="alert alert-danger">
					<strong>로그인 실패</strong> 이미 탈퇴한 계정입니다.
				</div>
		<%
			} else if("notUser".equals(fail)) {
		%>
				<div class="alert alert-danger">
					<strong>로그인 실패</strong> 관리자용으로 로그인해주세요.
				</div>
		<%
			} else if ("deny".equals(fail)) {
		%>
				<div class="alert alert-danger">
					<strong>서비스 거부</strong> 로그인이 필요한 서비스 입니다.
				</div>
		<%
			}
		%>
	    <div class="form-floating">
	      <input type="text" class="form-control" name="id" id="id" placeholder="아이디를 입력하세요">
	      <label for="floatingInput">아이디를 입력하세요</label>
	      <div id="id-helper" class="form-text text-bold"></div>
	    </div>
	    <div class="form-floating">
	      <input type="password" class="form-control" name="password" id="password" onkeydown="keydown(event);" placeholder="비밀번호를 입력하세요">
	      <label for="floatingPassword">비밀번호를 입력하세요</label>
	    </div>
	    <button class="w-100 btn btn-lg btn-primary mt-3" type="submit">로그인</button>
	
	    <div class="checkbox my-3">
	      <label>
	        <input type="checkbox" id="idSaveCheck" name="saved" value="yes"> 아이디 저장
	      </label>
	    </div>
	   	<div>
	   		<a class="btn btn-secondary" href="registerform.jsp" >회원가입 </a>
	   		<a class="btn btn-outline-secondary" href="findId.jsp" >아이디찾기</a>
	   		<a class="btn btn-outline-secondary" href="findPassword.jsp">비밀번호찾기</a>
	   	</div>
	  </form>
	  </div>
	  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

	// 페이지가 나타나자 마자 아이디가 화면에 보여져야 한다.
	// 따라서 함수 안에 작성하는 것이 아니다!
	let idField = document.querySelector("input[name=id]");
	let idSaveCheckField = document.getElementById("idSaveCheck");
	
	let isChecked = localStorage.getItem("checked");
	if(isChecked === 'yes') {
		idSaveCheckField.checked = true;
		idField.value = localStorage.getItem("savedId");
	}
	
	
	
	// 아이디 저장/삭제 기능
	/* idSaveCheckField.onchange = function() {
		let idValue = idField.value.trim();
		
		if (idSaveCheckField.checked) {
			if (idValue == "") {				
				alert("아이디를 먼저 입력하세요");	// 아이디를 입력하지 않고 아이디 저장 체크박스를 눌렀을 경우
				idSaveCheckField.checked = false;	// 이건 내가 추가
				return;
			}
			localStorage.setItem("savedId", idValue);	// "savedId" : idValue 의 key : value 형식으로 localStroage에 저장한다.
			localStorage.setItem("checked", "yes");		// "checked" : "yes" 도 저장한다.
		} else {
			localStorage.setItem("checked", "no");		
			localStorage.removeItem("savedId");			// 아이디 저장 체크박스의 체크를 해제하면 localStroage에 있는 값을 삭제한다.
		}
	}  */

	function keydown(e) {
		if(e.repeat) {
	        e.preventDefault();
	    }
		
		// 비밀번호 입력란에서 space는 인식하지 못하도록 한다.
		if(e.keyCode === 32) {
			e.preventDefault();
		}
	}
	
	function submitLoginForm() {
		let idValue = idField.value.trim();
		if (!idValue) {
			alert("아이디는 필수입력값입니다.");
			idField.focus();
			return false;
		}
		let passwordField = document.querySelector("input[name=password]");
		let passwordValue = passwordField.value.trim();
		if (!passwordValue) {
			alert("비밀번호는 필수입력값입니다.");
			passwordField.focus();
			return false;
		}
		
		if(document.getElementById("admin-radio").checked){							// 관리자 로그인일 경우
			document.getElementById("login-form").action = "login.jsp?job=admin";
		}
		
		let idSaveCheckField = document.getElementById("idSaveCheck");
		if (idSaveCheckField.checked) {
			localStorage.setItem("savedId", idValue);	// "savedId" : idValue 의 key : value 형식으로 localStroage에 저장한다.
			localStorage.setItem("checked", "yes");		// "checked" : "yes" 도 저장한다.
		} else {
			localStorage.setItem("checked", "no");		
			localStorage.removeItem("savedId");			// 아이디 저장 체크박스의 체크를 해제하면 localStroage에 있는 값을 삭제한다.
		}
		
		return true; 
	}

	function changeRadio() {
		
		if(document.getElementById("user-radio").checked) {
			document.getElementById("login-title").textContent = "회원 로그인";
		} else {
			document.getElementById("login-title").textContent = "관리자 로그인";
		}
		
	}
	
</script>


</body>
</html>