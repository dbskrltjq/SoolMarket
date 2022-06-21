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
	 .list-group-item {font-size:small; }
	 .border {border-color: #DADADA;}
	 p {font-size: small;}
	 h5 {font-weight: bold;}
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
	         		<a href="#" class="list-group-item list-group-item-action">- 주문목록</a>
	         		<a href="#" class="list-group-item list-group-item-action">- 취소 내역</a>
	         		<a href="#" class="list-group-item list-group-item-action">- 장바구니 보기</a>
				</div>
				<p><strong class="fs-6">회원정보</strong></p>
	         	<div class="list-group list-group-flush">
	         		<a href="myPagePassword.jsp" class="list-group-item list-group-item-action">- 회원정보 변경</a>
	         		<a href="userDeleteForm.jsp" class="list-group-item list-group-item-action">- 회원 탈퇴</a>
	         		<a href="#" class="list-group-item list-group-item-action">- 나의 상품문의</a>
				</div>
	      </div>
			<div class="col-8 ms-5">
				<div class="row mb-5 border-bottom">
					<div class="col-12">
						<h5>회원탈퇴</h5>
					</div>
				</div>
				<div class="row mb-5">
					<h5>01. 회원탈퇴 안내</h5>
					<div class="col-12 border">
						<div>
							<p>술마켓 탈퇴안내</p>
							<p></p>
							<p>회원님께서 회원 탈퇴를 원하신다니 저희 쇼핑몰이 많이 부족하고 미흡했나 봅니다.<br>
							   불편하셨던 점이나 불만사항을 알려주시면 적극 반영해서 고객님의 불편함을 해결해 드리도록 노력하겠습니다.</p>
							<p>■ 아울러 회원 탈퇴시의 아래 사항을 숙지하시기 바랍니다.<br>
							   1. 회원 탈퇴 시 회원님의 정보는 상품 반품 및 A/S를 위해 전자상거래 등에서의 소비자 보호에 관한 법률에 의거한<br>
							   고객 정보 보호 정책에 따라 관리됩니다.<br>
							   2. 탈퇴 시 회원님께서 보유하셨던 포인트는 삭제됩니다.
							   </p>
						</div>
					</div>
				</div>
				<div class="row">
					<h5>02. 회원탈퇴 하기</h5>
					<div class="col-12 border" >
						<div class="row mb-3">
							<div class="col-12 text-center pt-3">
								<strong>회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인해 주세요.</strong>
							</div>
						</div>
						<%
            			User user = (User)session.getAttribute("LOGINED_USER");
            		%>
						<form method="post" action="home.jsp" id="pw-form">
							<div class="row p-3 bg-light border text-center">
								<div class="col-12">
										<strong>아이디 <span id="id" class="text-primary me-4"><%=user.getId() %></span></strong>
										<strong>비밀번호 </strong> <input type="password" id="password" />
									<div id="pwHelper"></div>
								</div>
							</div>
							<div class="row my-3">
								<div class="col-12 text-center">
									<button type="button" onclick="pageBack()" class="btn btn-outline-secondary"><strong>이전으로</strong></button>
									<button type="button" class="btn btn-primary" onclick="formSubmitCheck()"><strong style="color: white;">탈퇴</strong>
									</button>
								</div>
							</div>
						</form>
					</div>
				</div>
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
				}  else { 
					alert("회원 탈퇴 처리됩니다.");
					location.href="userDelete.jsp";			// 자바스크립트에서 페이지이동
				}
			}	
	    }
	    xhr.open("GET", 'passwordCheck.jsp?password=' + password);						
	    xhr.send();	
	}
	
	
	function pageBack() {
		
		history.back(); // 브라우저의 방문기록에서 한 페이지 전으로 간다.
	}
</script>
</body>
</html>