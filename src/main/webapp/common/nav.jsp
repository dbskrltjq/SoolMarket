<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap demo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/2628157b3b.js" crossorigin="anonymous"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding&display=swap');		
	body {font-family: 'Nanum Gothic Coding', monospace;}
	.nav-link { font-size: large; 
				color:black;
				font-weight: bold;}
	#inline {display: inline-block;}
	i {margin-right: 10px;
	   color: orange;}
</style>
</head>
<body>
<%
	String menu = request.getParameter("menu");

	User user = (User)session.getAttribute("LOGINED_USER");
%>

 <nav class="navbar navbar-expand-lg  p-2 text-dark ">
  <div class="container-fluid">
  	<div class="row p-3">
  		<div class="col-3">
		    <a class="navbar-brand" aria-current="page" href="/semi/home.jsp"><img src="/semi/images/mainLogo.png" style="width: 80%;"> </a>
		    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		      <span class="navbar-toggler-icon"></span>
		    </button>
		</div>
		<div class="collapse navbar-collapse col-6" id="navbarSupportedContent">
		      <ul class="navbar-nav me-auto mb-2 mb-lg-0 ">
		        <li class="nav-item">
		        	<a class="nav-link " aria-current="page" href="/semi/list.jsp?categoryNo=100">소주/증류주</a>
		        </li>
		        <li class="nav-item">
		        	<a class="nav-link " href="/semi/list.jsp?categoryNo=200">리큐르</a>
		        </li>
		        <li class="nav-item">
		        	<a class="nav-link " href="/semi/list.jsp?categoryNo=300">막걸리</a>
		        </li>
		        <li class="nav-item">
		        	<a class="nav-link " href="/semi/list.jsp?categoryNo=400">약주/청주</a>
		        </li>
		        <li class="nav-item">
		        	<a class="nav-link " href="/semi/list.jsp?categoryNo=500">과실주</a>
		        </li>
		        <li class="nav-item dropdown">
		        	<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
		           		커뮤니티
		        	</a>
		          	<ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
		            	<li><a class="dropdown-item" href="review/totalReview.jsp">상품후기보기</a></li>
		            	<li><a class="dropdown-item" href="#">1:1문의하기</a></li>
		          	</ul>
		        </li>
		        
		      </ul>
		      <form class="d-flex" role="search">
		      	<div class="input-group">
			        <input class="form-control border-warning" type="search" placeholder="막걸리" aria-label="Search">
			        <button class="btn btn-outline-warning" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
			    </div>
		      </form>
		</div>     
		<div class="col-3 p-3" style="text-align: center;" >
				<%
					if (user == null) {
				%>
				      <a class="nav-link pe-3" id="inline" href="/semi/login.jsp"><i class="fa-solid fa-right-to-bracket"></i>로그인</a>
				      <a class="nav-link pe-3"id="inline"  href="/semi/registerform.jsp"><i class="fa-solid fa-user-plus"></i>회원가입</a>
				<%
					} else { 
				%>
					  <a class="nav-link" id="inline" href="/semi/cart.jsp">장바구니</a>
				
				      <a class="nav-link" id="inline" href="/semi/logout.jsp">로그아웃</a>
				<%
					}
				%>
		</div> 
  		</div>
  	</div>
</nav>  
</div><script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>