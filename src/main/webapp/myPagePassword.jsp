<%@page import="vo.User"%>
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
	.container {border: solid 2px black; margin-top: 60px}
</style>

</head>

<body>
<jsp:include page="common/nav.jsp"></jsp:include>

<div class="container">
   <div class="row">
      <div class="col-3">
         <h3>마이 페이지</h3>

         <h4>쇼핑정보</h4>
         <ul>
            <li>주문</li>
         </ul>
                  
      </div>
      <div class="col-9">
         <div class="row mb-5 border-bottom">
            <div class="col-12">
               <h4>회원정보 변경</h4>
            </div>
         </div>
         <div class="row mb-5">
            <div class="col-12 text-center">
               <strong>회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인해 주세요.</strong>
            </div>
         </div>
         <form method="post" action="myPageUpdate.jsp" onsubmit="return formSubmitCheck()">
         <div class="row p-3 bg-light border text-center">
            <div class="col-12">
            <%
            	User user = (User)session.getAttribute("LOGINED_USER");
            %>
               <p class="m-3">
                  <strong>아이디 <span id="id" class="text-primary me-4"><%=user.getId() %></span></strong>
                  <strong>비밀번호 </strong> <input type="password" id="password" /> 
                  <div id="pwHelper"></div>
               </p>
            </div>
         </div>
         <div class="row my-3">
            <div class="col-12 text-center">
               <a href="" class="btn btn-outline-secondary">취소</a>
               <button type="submit" class="btn btn-warning">인증하기</button>
            </div>
         </div>
         </form>
      </div>
   </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

	function formSubmitCheck() {
		let userId = document.getElementById("id").value;
		
		let pwHelperField = document.getElementById("pwHelper");
		let passwordField = document.getElementById("password");
		let password = passwordField.value;
		
		
		if(password === '') {
			alert("비밀번호를 입력해주세요");
			passwordField.focus();
			return false;
		}
		
		if (password !== '') {
		let xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {					
			if (xhr.readyState === 4 && xhr.status === 200) {	
				let jsonText = xhr.responseText;				
				let result = JSON.parse(jsonText);				     
				if(!result.check) {
					pwHelperField.textContent = "비밀번호를 정확하게 입력해주세요." ;
				} 
			}
	    }
	    xhr.open("GET", 'passwordCheck.jsp?password=' + password);						
	    xhr.send();	
	    return false;
		}
	}
	
</script>
</body>

</html>