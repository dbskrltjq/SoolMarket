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
				      <form class="d-flex" role="search" action="/semi/searchList.jsp">
				      	<div class="input-group">
					        <input class="form-control border-warning" type="search" name="keyword" placeholder="제품검색 ex)소주" aria-label="Search">
					        <button class="btn btn-outline-warning" type="button" onclick="searchKeyword();"><i class="fa-solid fa-magnifying-glass"></i></button>
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
	
	function searchKeyword() {
		location.href="/semi/searchList.jsp?sort=sell&keyword=" + document.querySelector("input[name=keyword]").value	
	}
</script>
