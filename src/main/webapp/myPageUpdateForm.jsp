<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error/500.jsp"%>
<%
	//세션에서 로그인된 사용자정보를 조회한다.
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		throw new RuntimeException("회원정보 수정은 로그인 후 사용가능한 서비스 입니다.");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap demo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
	.list-group-item {font-size:small; }
	span {color: red; font-weight: bold;}
	small {font-size: small;}
	
	input {width: 50%;}	
</style>
</head>
<body>
<jsp:include page="common/nav.jsp"></jsp:include>
<%
	 user = (User)session.getAttribute("LOGINED_USER");
%>
<div class="container" style="padding: 30px;">
	<div class="row">
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
		<div class="col-10">
			<div class="row mb-5 border-bottom">
            	<div class="col-12">
               		<h5><strong>회원정보 변경</strong></h5>
            	</div>
         	</div>
         	<div class="col-12 border-bottom">
         	<%
         		String name = request.getParameter("name");
         		if (name != null) { // 모달창 변경?
         	%>
         		<span><%=name %></span>님의 정보가 변경되었습니다.
         	<%
         		}
         	%>
         		<h6><strong>기본정보</strong></h6> 
         		<p style="font-size: xx-small; text-align: right;"><span>*</span>표시는 반드시 입력해야할 항목입니다.</p>
         	</div>
         	<form action="userInfoUpdate.jsp" method="post" onsubmit="return submitForm();" class="bg-light">
         		<table class="table">
	   	      		<tr>
	   	      			<th><span>*</span> 아이디</th>
	   	      			<td><%=user.getId() %></td>
	   	      		</tr>
	   	      		<tr>
	   	      			<th><span>*</span> 비밀번호</th>
	   	      			<td>
	   	      				<button type="button" id="pwButton" onclick="pwUpdate()" class="btn btn-outline-secondary btn-sm">비밀번호 변경</button> 
	   	      				<div id="pwUpdateForm" class="mt-2 d-none">
	   	      					<table class="table table-sm table-borderless w-50">
	   	      						<tr>
	   	      							<th class="align-middle"><small>새 비밀번호</small></th>
	   	      							<td><input type="password" id="password1" class="form-control form-control-sm h-55 w-75" disabled></td>
	   	      							<!--  -->
	   	      						</tr>
	   	      						<tr>
	   	      							<th class="align-middle"><small>새 비밀번호 확인</small></th>
	   	      							<td>
	   	      								<input type="password" name="password" id="password2" class="form-control form-control-sm h-55 w-75" disabled onkeyup="passwordCheck();s">
	   	      							</td>
	   	      							<td>
	   	      								<small id="password-helper"></small>
	   	      							</td>
	   	      						</tr>
	   	      					</table>
	   	      				</div>
	   	      			</td>
	   	      		</tr>
	   	      		<tr>
	   	      			<th><span>*</span> 이름</th>
	   	      			<td><input type="text" name="name" value="<%=user.getName() %>" /></td>
	   	      		</tr>
	   	      		<tr>
	   	      			<th><span>*</span> 이메일</th>
	   	      			<td>
	   	      				<input type="email" name="email" value="<%=user.getEmail() %>">
	   	      				<select name="domain" onchange="changeDomain()">
	   	      					<option selected="selected" disabled="disabled" >직접입력</option>
	   	      					<option value="@naver.com">naver.com</option>
	   	      					<option value="@hanmail.net">hanmail.net</option>
	   	      					<option value="@gmail.com">gmail.com</option>
	   	      					<option value="@nate.com">nate.com</option>
	   	      				</select>
	   	      				<div id="email-helper" class="form-text text-bold"></div>
	   	      			</td>
	   	      		</tr>
	   	      		<tr>
	   	      			<th><span>*</span> 휴대폰번호</th>
	   	      			<td>
	   	      				<input type="text" name="tel" value="<%=user.getTel() %>">
	   	      				<button type="button" class="btn btn-outline-secondary btn-sm" onclick="telCheck();">인증하기</button>
	   	      			</td>
	   	      		</tr>
	   	      		<tr>
	   	      			<th><span>*</span> 주소</th>
	   	      			<td  class="d-grid gap-3">
	   	      				<div class="w-50">
	   	      					<input type="text" value="<%=user.getPostCode() %>"  class="" name="postcode" id="postcode" placeholder="우편번호" readonly="readonly">
	   	      					<button type="button" class="btn btn-outline-secondary btn-sm" onclick="findAddr();" >우편번호 찾기</button>
	   	      				</div>
							<input type="text" value="<%=user.getAddress() %>" name="addr" id="addr" placeholder="주소" readonly="readonly">
							<input type="text" value="<%=user.getDetailAddress() %>" name="detailAddr" id="detailAddr" placeholder="상세주소">	
	   	      			</td>
	   	      		</tr>
         		</table>
         		<div class="row my-3">
            		<div class="col-12 text-center">
            			<button type="button" class="btn btn-secondary" onclick="pageBack();">취소</button>
               			<button type="submit" class="btn btn-primary"><strong style="color: white;">정보수정</strong></button>
            		</div>
         		</div>
         	</form>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

	let isPwChecked = false;
	let isEmailChecked = true;

	// 비밀번호변경 버튼을 누르면 새비밀번호를 입력하는 폼이 출력된다.
	function pwUpdate() {
		
		let password1 = document.getElementById("password1")
		let password2 = document.getElementById("password2")
			
		let div = document.getElementById("pwUpdateForm");
		if (div.classList.contains('d-none')) {
			div.classList.remove('d-none');
			password1.disabled = false;
			password2.disabled = false;
			password1.value = '';
			password2.value = '';
		} else {
			div.classList.add('d-none');
			password1.disabled = true;
			password2.disabled = true;
		}
		
		//pwUpdateFormField.innerHTML = '<p>현재 비밀번호 <input type="password" /></p><p>새 비밀번호 <input type="password" /></p><p>새 비밀번호 확인 <input type="password" /></p>'
 				
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
			isPwChecked = false;
			passwordHelperElement.textContent = "비밀번호가 일치하지 않습니다."; 
			return;
			
		}
		if (password1 === password2) {
			classList.add("text-success");
			isPwChecked = true;
			passwordHelperElement.textContent = "비밀번호가 일치합니다."
		}
	}
	
	function changeDomain() {
		
		let inputEmailField = document.querySelector("input[type=email]");
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
		
		let emailHelperElement = document.getElementById("email-helper");
		
		let xhr = new XMLHttpRequest();
			    
		xhr.onreadystatechange = function() {					
		if (xhr.readyState === 4 && xhr.status === 200) {	
			let jsonText = xhr.responseText;				
			let result = JSON.parse(jsonText);	
			
				if(result.exist) {
					emailHelperElement.textContent = "이미 존재하는 이메일입니다.";
					isEmailChecked = false;
				} else {
					emailHelperElement.textContent = "사용가능한 이메일입니다.";
					isEmailChecked = true;
						}
				}
		}
		
		// 같은 emailCheck.jsp를 사용하더라도 요청을 주는 측에서 어떤 작업을(job=update) 하는지 알려준다. 
		// 그러면 요청을 받는 쪽(emailCheck.jsp)에서는 받는 값에 따라 기능을 달리 구현하면 된다.
		xhr.open("GET", 'emailCheck.jsp?job=update&email=' + inputEmailField.value);						
		xhr.send();	
	}

	// 전화번호 중복체크 
	function telCheck() {
			
			let telElement = document.querySelector("input[name=tel]");
			let telValue = telElement.value;
			
			let xhr = new XMLHttpRequest();
			
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					let jsonText = xhr.responseText;
					let result = JSON.parse(jsonText);
					
					if(result.exist) {
						alert("이미 존재하는 전화번호입니다.");
						telElement.focus();
						isTelChecked = false;
					} else {
						alert("사용가능한 전화번호입니다.");
						isTelChecked = true;
					}
					
				}
				
			}
			xhr.open("GET", 'telCheck.jsp?job=update&tel=' + telValue );						
		    xhr.send();	
		}

	function submitForm() {
		
		let passwordField1 = document.getElementById("password1");
		let passwordField2 = document.getElementById("password2");
		
		// 필드가 활성화돼서 비밀번호를 바꾸려는 사용자인 경우
		if (!passwordField1.disabled) {
			if (passwordField1.value === '' || passwordField2.value === '' || !isPwChecked) {
				alert("비밀번호를 다시 확인해주세요");
				passwordField1.focus();
				return false;
			}			
		}
		// 비밀번호를 변경하지 않는 사용자의 경우: userInfoUpdate.jsp로 넘어가는 password의 요청파라미터 값이 null이 된다. 
		
		let nameField = document.querySelector("input[name=name]");
		if (!nameField.value.trim()) {
			alert("이름을 입력해주세요.");
			nameField.focus();
			return false;
		}
		let emailField = document.querySelector("input[name=email]");
		if (!emailField.value.trim() || !isEmailChecked) {
			alert("이메일을 다시 확인해주세요");
			emailField.focus();
			return false;
		}
		
		
		let telField = document.querySelector("input[name=tel]");
		if (!telField.value.trim()) {
			alert("전화번호를 입력해주세요.");
			telField.focus();
			return false;
		}
		
		let postcodeField = document.getElementById("postcode");
		let addrField = document.getElementById("addr");
		let detailAddrField = document.getElementById("detailAddr");
		if (!postcodeField.value.trim() || !addrField.value.trim() || !detailAddrField.value.trim()) {
			alert("정확한 주소를 입력해주세요.")
			detailAddrField.focus();
			return false;
		}
		
		
		return true;
	} 
		
	


//다음api를 사용한 주소찾기 기능 구현 부분
function findAddr() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("detailAddr").value = extraAddr;
            
            } else {
                document.getElementById("extraAddr").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("addr").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailAddr").focus();
        }
    }).open();
}

	function pageBack() {
		history.back();
	}

</script>
</body>
</html>