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
<%
	String fail = request.getParameter("fail");

	if ("invalid".equals(fail)) {
%>



		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        ...
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
		        <button type="button" class="btn btn-primary">Save changes</button>
		      </div>
		    </div>
		  </div>
		</div>
	
	
<%
	}
%>

<div class="container">
	<main class="form-signin w-100 m-auto">
	  <form method="post" action="login.jsp" onsubmit="return submitLoginForm()">
	    <img class="mb-4" src="images/logo.png" alt="" width="200" height="200">
	    <h1 class="h3 mb-3 fw-normal">로그인</h1>
	
	    <div class="form-floating">
	      <input type="text" class="form-control" name="id" id="" placeholder="아이디를 입력하세요">
	      <label for="floatingInput">아이디를 입력하세요</label>
	    </div>
	    <div class="form-floating">
	      <input type="password" class="form-control" name="password" id="" placeholder="비밀번호를 입력하세요">
	      <label for="floatingPassword">비밀번호를 입력하세요</label>
	    </div>
	
	    <div class="checkbox mb-3">
	      <label>
	        <input type="checkbox" value="remember-me"> 아이디 저장
	      </label>
	    </div>
	    <button class="w-100 btn btn-lg btn-primary" type="submit">로그인</button>
	  </form>
	</main>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

	function submitLoginFormlet idField = document.querySelector("input[name=id]");
	if (idField.value === '') {
		alert("아이디는 필수입력값입니다.");
		idField.focus();
		return false;
	}
	let passwordField = document.querySelector("input[name=password]");
	if (passwordField.value === '') {
		alert("비밀번호는 필수입력값입니다.");
		passwordField.focus();
		return false;
	}
	return true;() {
		
	}

</script>
</body>
</html>