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
	span {font-size: x-small;}
	#id-helper {color: red;
				font-size: small;
				font-weight: bold;
	}
</style>
</head>
<body>
<jsp:include page="common/nav.jsp"></jsp:include>
<%
	String id = request.getParameter("id");
	String foundEmail = request.getParameter("foundEmail");
	String revisedEmail = null;
	String revisedTel = null;
	
	if (foundEmail != null) {
		int index = foundEmail.indexOf("@");
		StringBuilder sb = new StringBuilder(foundEmail);
		
		for(int i = 2; i < index; i++) {
			sb.replace(i, i+1, "*");
			//System.out.println(sb);
		}
		revisedEmail = sb.toString();
	}
	
	String foundTel = request.getParameter("foundTel");
	
	if(foundTel != null) {
		
		StringBuilder sb = new StringBuilder(foundTel);
		for(int i = 2; i < 7 ; i++) {
			sb.replace(i, i+1, "*");
		}
		revisedTel = sb.toString();
	}
%>
<div class="container">
	<div class="row justify-content-center pt-5">
		<div class="col-6">
			<h3><strong>비밀번호 찾기</strong></h3>
			<form method="post" class="border py-5 px-5 mt-4" id="find-password-form" action="findPassword.jsp" >
				<input type="hidden" name="foundEmail" value="<%=foundEmail %>"/>
				<input type="hidden" name="foundTel" value="<%=foundTel %>" />
				<div class="row">
					<div class="col-12 border-bottom">
				<%
					if(id != null) {
						
				%>
						<h5>인증수단 선택</h5>
						<p>본인인증 방법을 선택해주세요.</p>
				<%
					} else {
				%>
						<h5>회원 아이디 입력</h5>
						<p>비밀번호를 찾고자 하는 아이디를 입력해주세요.</p>
					</div>
				<%
					}
				%>
				</div>
				<div class="row border-bottom pb-3 mb-3">
					<div class="col">
				<%
					if(id != null) {
				%>		
						<div class="form-check">
							<input class="form-check-input" type="radio" name="findWay" id="found-email" value="email" checked />
							<label class="form-check-label" for="found-email">이메일 인증 ( <%=revisedEmail  %> )</label>
						</div>
						<div class="form-check">
							<input class="form-check-input" type="radio" name="findWay" id="found-tel" value="tel" />
							<label class="form-check-label" for="found-tel">휴대폰 인증 ( <%=revisedTel %> )</label>
						</div>
				<%
					} else {
				%>
						<input type="text" name="id" placeholder="아이디" /><br>
						<span>아이디를 모르시나요?<a href="findId.jsp"><strong>아이디 찾기</strong></a></span>
						<div id="id-helper"></div>
				<%
					}
				%>
					</div>	
				</div>
				<div class="row">
					<div class="col">
				<%
					if (id != null) {
				%>  
						<button type="button" id="nextBtn" class="btn btn-primary" onclick="changePassword();">다음</button>
				<%
					} else {
				%>
						<button type="button" id="nextBtn" class="btn btn-primary" onclick="findId();">다음</button>
				<%
					}
				%>
					</div>				
				</div>
			</form>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

	let formField = document.getElementById("find-password-form");
	let hiddenEmailField = document.querySelector("input[name=foundEmail]");
	let hiddenTelField = document.querySelector("input[name=foundTel]");
	
	function changePassword() {
		
		formField.action = "resetPassword.jsp";
		formField.submit();
		return;
	}

	function findId() {
		let idHelper = document.getElementById("id-helper");
		let idField = document.querySelector("input[name=id]");
		let idValue = idField.value.trim();
		
		if (idValue === '') {
			idHelper.textContent = "아이디를 입력해주세요";
			return;
		}
	
		let xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function() {
				
				if(xhr.readyState === 4 && xhr.status === 200) {
					let jsonText = xhr.responseText;
					let result = JSON.parse(jsonText);
					
					if(result.exist) {
						formField.action = "findPassword.jsp?id=" + result.id;
						hiddenEmailField.value = result.email;
						hiddenTelField.value = result.tel;
						formField.submit();
						return;
						
					} else {
						idHelper.textContent = "회원정보를 찾을 수 없습니다.";
						return false;
					}
					
				}
			}
		
		xhr.open("GET", "idCheck.jsp?id=" + idValue);
		xhr.send();
		
	}	

</script>
</body>
</html>