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
	<form class="border bg-light p-3 " method="post" action="register.jsp" onsubmit="return submitRegisterForm()">
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
				<span>*</span> 주소 
					<input type="text" name="postcode" id="postcode" placeholder="우편번호">
					<input type="button" onclick="findAddr()" value="우편번호 찾기"><br>
					<input type="text" name="addr" id="addr" placeholder="주소"><br>
					<input type="text" name="detailAddr" id="detailAddr" placeholder="상세주소">	
					<input type="text" name="extraAddr" id="extraAddr" placeholder="참고항목">
			
			<a href="home.jsp" class="btn btn-secondary">취소</a>
			<button type="submit" class="btn btn-primary">회원가입</button>
		</div>
	</form>

   
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
					idHelperElement.textContent = result.id + "은 이미 존재하는 아이디입니다.";
					isIdChecked = false;
				} else {
					classList.add("text-success");
					idHelperElement.textContent = result.id + "은 사용가능한 아이디입니다.";
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
				} else {
					classList.add("text-success");
					emailHelperElement.textContent = "사용가능한 이메일입니다.";
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
		
		let telField = document.querySelector("input[name=tel]");
		if (telField.value === '') {
			alert("전화번호를 입력해주세요.")
			telField.focus();
			return false;
		}
		
		let postcodeField = document.getElementById("posecode");
		let addrField = document.getElementById("addr");
		let detailAddrField = document.getElementById("detailAddr");
		if (postcodeField.value === '' || addrField === '' || detailAddrField === '') {
			alert("주소를 입력해주세요.")
			postcodeField.focus();
			return false;
		}
		
		
		return true;
	} 
	
	// 다음api를 사용한 주소찾기 기능 구현 부분
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
                    document.getElementById("extraAddr").value = extraAddr;
                
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


</script>
</body>
</html>