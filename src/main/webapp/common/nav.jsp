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
</head>
<body>
<%
	String menu = request.getParameter("menu");

	User user = (User)session.getAttribute("LOGINED_USER");
%>

 <nav class="navbar navbar-expand-lg bg-success p-2 text-dark bg-opacity-50">
  <div class="container-fluid">
    <a class="navbar-brand" aria-current="page" href="/semi/home.jsp">술마켓</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0 ">
        <li class="nav-item">
          <a class="nav-link border-start border-end" aria-current="page" href="/semi/list.jsp?no=100">소주/증류주</a>
        </li>
        <li class="nav-item">
          <a class="nav-link border-end" href="/semi/list.jsp?no=200">리큐르</a>
        </li>
        <li class="nav-item">
          <a class="nav-link border-end" href="/semi/list.jsp?no=300">막걸리</a>
        </li>
        <li class="nav-item">
          <a class="nav-link border-end" href="/semi/list.jsp?no=400">약주/청주</a>
        </li>
        <li class="nav-item">
          <a class="nav-link border-end" href="/semi/list.jsp?no=500">과실주</a>
        </li>
      </ul>
      <form class="d-flex" role="search">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
      
<%
	if (user == null) {
%>
      <a class="nav-link me-3" href="/semi/login.jsp">로그인</a>
      <a class="nav-link me-3" href="/semi/registerform.jsp">회원가입</a>
<%
	} else { 
%>
	  <li class="nav-item">
					<a class="nav-link" aria-current="page" href="/semi/cart.jsp">장바구니</a>
	  </li>	

	  <li class="nav-item">
					<a class="nav-link" aria-current="page" href="/semi/logout.jsp">로그아웃</a>
	  </li>	
<%
	}
%>


    </div>
  </div>
</nav>  
</div><script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>