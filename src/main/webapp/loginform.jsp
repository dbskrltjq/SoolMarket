<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap demo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="text-center">
<jsp:include page="common/nav.jsp">
	<jsp:param  name="menu" value="login" />
</jsp:include>

<div class="container" style="width: 40%">
	<main class="form-signin w-100 m-auto border">
	  <form method="post" action="login.jsp" onsubmit="return submitLoginForm()">
	    <img class="mb-4" src="images/logo.png" alt="" width="200" height="200">
	    <h1 class="h3 mb-3 fw-normal">로그인</h1>
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
	}
%>
	
	    <div class="form-floating">
	      <input type="text" class="form-control" name="id" id="id" placeholder="아이디를 입력하세요">
	      <label for="floatingInput">아이디를 입력하세요</label>
	      <div id="id-helper" class="form-text text-bold"></div>
	    </div>
	    <div class="form-floating">
	      <input type="password" class="form-control" name="password" id="password" placeholder="비밀번호를 입력하세요">
	      <label for="floatingPassword">비밀번호를 입력하세요</label>
	    </div>
	    <button class="w-100 btn btn-lg btn-primary" type="submit">로그인</button>
	
	    <div class="checkbox mb-3">
	      <label>
	        <input type="checkbox" value="remember-me"> 아이디 저장
	      </label>
	    </div>
	   	<div>
	   		<a class="btn btn-secondary" href="registerform.jsp" >회원가입 </a>
	   		<a class="btn btn-outline-secondary" href="findId.jsp">아이디찾기</a>
	   		<a class="btn btn-outline-secondary" href="findPassword.jsp">비밀번호찾기</a>
	   	</div>
	  </form>
	</main>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

	
	function submitLoginForm() {
	let idField = document.querySelector("input[name=id]");
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
	return true; 
	}

</script>


</body>
</html>