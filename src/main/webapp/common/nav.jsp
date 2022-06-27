<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding&display=swap');	
	nav.navbar {font-family: 'Nanum Gothic Coding', monospace;
		 border-bottom-style: solid;
 		 border-bottom-color: coral;
 		 margin-top: 30px;
 		 background-color: white; }
	nav.navbar .nav-link { font-size: large; 
				color:black;
				font-weight: bold;}
	#inline {display: inline-block;}
	nav.navbar i {margin-right: 10px;
	   color: orange;}
</style>
<%
	User user = (User)session.getAttribute("LOGINED_USER");
%>
<!-- 내비바에서 사용되는 주소는 절대주소로 적어야 합니다. -->
 <nav class="navbar navbar-expand-lg  p-2 text-dark sticky-top ">
	  <div class="container-fluid">
		  	<div class="row p-4 mb-3">
		  		<div class="col-2">
				    <a class="navbar-brand" aria-current="page" href="/semi/home.jsp"><img src="/semi/images/mainLogo.png" style="width: 80%;"> </a>
				    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
				      <span class="navbar-toggler-icon"></span>
				    </button>
				</div>
				<div class="collapse navbar-collapse col-6 " id="navbarSupportedContent">
				      <ul class="navbar-nav me-auto mb-2 mb-lg-0 justify-content-center">
				        <li class="nav-item">
				          <a class="nav-link " aria-current="page" href="/semi/list.jsp?categoryNo=100&sort=sell&page=1">소주/증류주</a>
				        </li>
				        <li class="nav-item">
				        	<a class="nav-link " href="/semi/list.jsp?categoryNo=200&sort=sell&page=1">리큐르</a>
				        </li>
				        <li class="nav-item">
				          	<a class="nav-link " href="/semi/list.jsp?categoryNo=300&sort=sell&page=1">막걸리</a>
				        </li>
				        <li class="nav-item">
				         	<a class="nav-link " href="/semi/list.jsp?categoryNo=400&sort=sell&page=1">약주/청주</a>
				        </li>
				        <li class="nav-item">
				          	<a class="nav-link " href="/semi/list.jsp?categoryNo=500&sort=sell&page=1">과실주</a>
				        </li>
				        <li class="nav-item dropdown">
		        		<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
		           		커뮤니티
		        		</a>
		          			<ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
		            			<li><a class="dropdown-item" href="/semi/review/totalReview.jsp">상품후기보기</a></li>
		            			<li><a class="dropdown-item" href="#">1:1문의하기</a></li>
		          			</ul>
		        		</li>
				      </ul>
				      <form class="d-flex position-relative" role="search"  action="/semi/searchList.jsp?sort=sell" onsubmit="savedKeyword();" >
				      	<div class="input-group" >
					        <input class="form-control border-warning" type="text" id="search" name="keyword" placeholder="제품검색 ex)소주" />
					        <button class="btn btn-outline-warning" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>				
							<div class="list-group position-absolute d-none border border-warning rounded" id="keyword-list" style="z-index: 2000; left: 0; top: 40px; width: 80%; font-size: 0.8rem;"  ></div>
							<div class="list-group position-absolute d-none border border-warning rounded" id="remove-list" style="z-index: 2000; right: 0; top: 40px; width: 20%; font-size: 0.8rem;"  ></div>	
					    </div>
				      </form>
				</div>     
				<div class="col-3" style="text-align: right;">
						<%
							if (user == null) {
						%>
						      <a class="nav-link pe-3" id="inline" href="/semi/loginform.jsp"><i class="fa-solid fa-right-to-bracket"></i>로그인</a>
						      <a class="nav-link pe-3"id="inline"  href="/semi/registerform.jsp"><i class="fa-solid fa-user-plus"></i>회원가입</a>
						<%
							} else { 
						%>
							  <a class="nav-link" id="inline" href="/semi/cart.jsp"><i class="fa-solid fa-cart-shopping"></i>장바구니</a>
							  <a class="nav-link" id="inline" href="/semi/myPage.jsp"><i class="fa-solid fa-user"></i>마이페이지</a>
						      <a class="nav-link" id="inline" href="/semi/logout.jsp" onclick="logout();"><i class="fa-solid fa-user-xmark"></i>로그아웃</a>
						<%
							}
						%>
				</div> 
		  	</div>
	  	</div>
</nav>  

<script src="https://kit.fontawesome.com/2628157b3b.js"></script>
<script type="text/javascript">

	function logout() {
		alert("로그아웃되었습니다.")
		return;
	}
	
	let recentKeyword = document.getElementById('search');
	recentKeyword.addEventListener('click', function() {openKeywordList();});
	
	let array = new Array();
	
	function savedKeyword() {
		let keywords = document.querySelector("input[name=keyword]").value;
		let text = localStorage.getItem("keyword") || '[]';
		let array = JSON.parse(text);
		
		if (keywords === "") {
			return;
		} else {
			array.unshift(keywords);
		}
		
		text = JSON.stringify(array);
		localStorage.setItem("keyword", text);
	}
	
	function openKeywordList() {
		
		let keywordList = document.getElementById('keyword-list');
		let removeList = document.getElementById('remove-list');
		
		if (keywordList.hasChildNodes()) {
			return keywordOnOff();
		}		
		
		refreshKeywordList();	
		keywordOnOff();
	}
	
	function refreshKeywordList() {
		
		let keywordList = document.getElementById('keyword-list');
		let removeList = document.getElementById('remove-list');
		
		keywordList.innerHTML = "";
		keywordList.innerHTML = "";
		
		removeList.innerHTML = "";
		removeList.innerHTML = "";

		let text = localStorage.getItem("keyword") || '[]';			
		array = JSON.parse(text);	
		
		let buttonK = null;
		let buttonR = null;
		let li = null;
		
		for (let i=0; i < array.length; i++) {
			
			buttonK = document.createElement("button");
			buttonR = document.createElement("button");
			
			buttonK.classList.add('list-group-item');
			buttonK.classList.add('list-group-item-action');
			buttonK.classList.add('border-warning');
			
			buttonR.classList.add('list-group-item');
			buttonR.classList.add('list-group-item-action');		
			buttonR.classList.add('border-warning');
			
			buttonK.setAttribute('type', 'button');
			buttonR.setAttribute('type', 'button');
			
			buttonK.innerText = array[i];
			buttonR.innerText = 'X';
			buttonK.addEventListener('click', function () {searchKeyword(i);});
			buttonR.addEventListener('click', function () {deleteKeyword(i);});
			keywordList.append(buttonK);
			removeList.append(buttonR);
		}
		
		
		if (array.length === 0) {
			keywordList.innerText = '최근검색어 내역이 없습니다.';
		} else {
			let deleteAll = document.createElement("button");
			deleteAll.classList.add('list-group-item');
			deleteAll.classList.add('list-group-item-action');
			deleteAll.setAttribute('type', 'button');
			deleteAll.innerText = '전체삭제';
			deleteAll.addEventListener('click', function () {removeAll();});
			keywordList.append(deleteAll);
		}
	}
	
	function keywordOnOff() {
		
		let keywordList = document.getElementById('keyword-list');
		let removeList = document.getElementById('remove-list');
		
		if (keywordList.classList.contains('d-none') && removeList.classList.contains('d-none')) {
			keywordList.classList.remove('d-none');
			removeList.classList.remove('d-none');
		} else { 
			keywordList.classList.add('d-none');
			removeList.classList.add('d-none');
		}
	}
	
	function deleteKeyword(i) {	
		let text = localStorage.getItem("keyword") || '[]';			
		array = JSON.parse(text);	
		
		array.splice(i, 1);
		text = JSON.stringify(array);
		localStorage.setItem("keyword", text);
		
		refreshKeywordList();
	}
	
	function removeAll() {
		
		localStorage.setItem("keyword", []);
		refreshKeywordList();
	}
	
	function searchKeyword(i) {
		let keywordList = document.getElementById('keyword-list');
		let keyword = keywordList.childNodes[i];
		let text = localStorage.getItem("keyword");
		array = JSON.parse(text);
		
		let formerKeyword = keyword.innerText;
		
		location.href="/semi/searchList.jsp?keyword=" + formerKeyword;
		
		array.unshift(formerKeyword);
		array.splice(i+1, 1);
		
		text = JSON.stringify(array);
		localStorage.setItem("keyword", text);
		
	}
	
</script>