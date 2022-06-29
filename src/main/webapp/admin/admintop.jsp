<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding&display=swap');	
 html, body {font-family: 'Nanum Gothic Coding', monospace;};
</style>
<!-- 관리자 페이지 상단내비바 -->
<%
	User admin = (User)session.getAttribute("ADMIN");
	//  String name = request.getParameter("name");    ----> 이렇게 하면 X !! 내비바는 여러 페이지에서 사용되므로 이렇게 작성하면
	// 로그인에서 메인화면으로 넘어갈 때 한번만 적용된다. 세션객체를 사용해야 여러 페이지에서 사용할 수 있다.
%>

<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
    <!-- Navbar Brand-->
    <a class="navbar-brand ps-3" href="main.jsp"><%=admin.getName() %> 님 환영합니다!</a> <!-- 처음에 name을 적음. 틀림! -->
    <!-- Navbar Search-->
    <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
        <div class="input-group">
            <a class="nav-link me-3" id="inline" href="/semi/admin/logout.jsp" style="color: white;"><i class="fa-solid fa-user-xmark"></i> <strong>로그아웃</strong></a>
        </div>
    </form>
</nav>