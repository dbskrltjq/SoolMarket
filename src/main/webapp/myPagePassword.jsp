<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error/500.jsp" %>
<%
	User user = (User)session.getAttribute("LOGINED_USER");
	if (user == null) {
		throw new RuntimeException("회원정보 수정은 로그인 후 사용가능한 서비스 입니다."); 
	}
%>
<!DOCTYPE html>
<!-- 회원정보 수정 페이지 넘어가기 전의 비밀번호 재입력 페이지 -->
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap demo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
	 .list-group-item {font-size:small; }
</style>
	
</head>

<body>
<jsp:include page="common/nav.jsp"></jsp:include>

<div class="container" style="padding: 30px;">
   <div class="row ">
      <div class="col-2">
         <h5 class="border-bottom pb-2  mb-4"><strong>마이페이지</strong></h5>

         	<p><strong class="fs-6">쇼핑정보</strong><p>
         	<div class="list-group list-group-flush mb-4">
         		<a href="myOrder.jsp" class="list-group-item list-group-item-action">- 주문목록</a>
         		<a href="#" class="list-group-item list-group-item-action">- 취소 내역</a>
         		<a href="cart.jsp" class="list-group-item list-group-item-action">- 장바구니 보기</a>
			</div>
			<p><strong class="fs-6">회원정보</strong></p>
         	<div class="list-group list-group-flush">
         		<a href="myPagePassword.jsp" class="list-group-item list-group-item-action">- 회원정보 변경</a>
         		<a href="userDeleteForm.jsp" class="list-group-item list-group-item-action">- 회원 탈퇴</a>
         		<a href="#" class="list-group-item list-group-item-action">- 나의 상품문의</a>
			</div>
      </div>
      <div class="col-10">
         <div class="row mb-5 border-bottom">
            <div class="col-12">
               <h5><strong>회원정보 변경</strong></h5>
            </div>
         </div>
         <div class="row mb-5">
            <div class="col-12 text-center">
               <strong>회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인해 주세요.</strong>
            </div>
         </div>
         
	     <form method="post" action="myPageUpdateForm.jsp" id="pw-form">
         	<div class="row p-3 bg-light border text-center">
            	<div class="col-12">
                	<strong>아이디 <span id="id" class="text-primary me-4"><%=user.getId() %></span></strong>
                  	<strong>비밀번호 </strong> <input type="password" id="password" />
                  	<div id="pwHelper"></div>
            	</div>
         	</div>
         	<div class="row my-3">
            	<div class="col-12 text-center">
               		<a href="myPage.jsp" class="btn btn-outline-secondary"><strong>취소</strong></a>
               		<button type="button" class="btn btn-primary" onclick="formSubmitCheck()"><strong style="color: white;">인증하기</strong></button>
            	</div>
         	</div>
         </form>
      </div>
   </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

	function formSubmitCheck() {
		
		let pwHelperField = document.getElementById("pwHelper");
		let passwordField = document.getElementById("password");
		let password = passwordField.value;
		
		
		if(password === '') {
			alert("비밀번호를 입력해주세요");
			passwordField.focus();
			return;
		}
		
		
		let xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {					
			if (xhr.readyState === 4 && xhr.status === 200) {	
				let jsonText = xhr.responseText;				
				let result = JSON.parse(jsonText);	
					
				if(!result.check) {
					pwHelperField.textContent = "비밀번호를 정확하게 입력해주세요." ;
					passwordField.focus();
					return;			// return false해도 form이 제출되는 이유 : formSubmitCheck()함수안에 ajax함수가 있으므로 
									// 해결방법: 버튼태그의 type을 button으로 변경하고, onClick했을 때 formSubmitCheck() 함수가 실행되도록 한다.
									// {"check" : true} 가 내려왔을 때 폼이 제출되도록한다.
				}  else { document.getElementById("pw-form").submit(); }
			}	
	    }
	    xhr.open("GET", 'passwordCheck.jsp?password=' + password);						
	    xhr.send();	
	}

</script>

</body>

</html>