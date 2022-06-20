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
	label { width: 40%;}
	#password-helper {font-size: small; font-weight: bold; text-align: ;}
</style>
</head>
<body>
<jsp:include page="common/nav.jsp"></jsp:include>
<div class="container">
	<div class="row justify-content-center pt-5">
		<div class="col-6">
			<h3><strong>비밀번호 변경</strong></h3>
			<%
				String foundEmail = request.getParameter("foundEmail");
				String foundTel = request.getParameter("foundTel");
				String name = request.getParameter("name");
			%>
			<form method="post" class="border py-5 px-5 mt-4" id="reset-password-form" action="userInfoUpdate.jsp?job=resetPassword" >
				<input type="hidden" name="foundEmail" value="<%=foundEmail %>" />
				<input type="hidden" name="foundTel"  value="<%=foundTel %>" />
					
		<%
			if(name != null) {
		%>
				<div class="row">
					<div class="col-12 border-bottom mb-4">
						<h5><strong><%=name %></strong>님의 비밀번호 재설정 완료</h5>
						<p>재설정한 비밀번호로 다시 로그인해주세요.</p>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<a href="loginform.jsp" class="btn btn-primary">로그인하기</a>
					</div>
				</div>
		<%
			} else {
		%>
				<div class="row">
					<div class="col-12 border-bottom">
						<h5>비밀번호 재설정</h5>
						<p>비밀번호를 다시 설정해 주세요.</p>
					</div>
				</div>
				<div class="row my-3">
						<div class="col-9">
							<div class="mb-2">
								<input type="hidden" name="email" />
								<label>새 비밀번호 : </label>
								<input type="password" name="password" id="password1" placeholder="새 비밀번호" />
							</div>
							<div>
								<label>새 비밀번호 확인 : </label>
								<input type="password" name="password2" id="password2" onkeyup="passwordCheck();" placeholder="새 비밀번호 확인" />
							</div>
							<div id="password-helper"></div>
						</div>	
					</div>
				<div class="row justify-content-center">
					<div class="col-4">
						<button type="button" class="btn btn-outline-secondary btn-lg" onclick="pageBack();">이전</button>
						<button type="submit" class="btn btn-primary btn-lg">확인</button>
					</div>				
				</div>
			</form>
			<%
				}
			%>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

	window.onkeydown = function(e) {
		console.log(e.keyCode);
		if(e.keyCode === 32) {
			e.preventDefault();
		}
	}
	
	function passwordCheck() {
		let password1 = document.getElementById("password1").value;
		let password2 = document.getElementById("password2").value;
		let passwordHelperElement = document.getElementById("password-helper");

		let classList = passwordHelperElement.classList;
		classList.remove("text-danger", "text-success");

		if (password1 !== password2) {
			classList.add("text-danger");
			passwordHelperElement.textContent = "비밀번호가 일치하지 않습니다.";
			isPasswordChecked = false;
			return;

		}
		if (password1 === password2) {
			classList.add("text-success");
			passwordHelperElement.textContent = "비밀번호가 일치합니다."
			isPasswordChecked = true;
			return;
		}
	} 

	function pageBack() {
		history.back();
	}

</script>
</body>
</html>