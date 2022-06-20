<%@page import="util.PasswordUtil"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");    // 사용자가 입력한 아이디
	String password = request.getParameter("password");			// 사용자가 입력한 비밀번호
	
	UserDao userDao = UserDao.getInstance();
	
	User savedUser = userDao.getUserById(id);
	
	if (savedUser == null) {
		response.sendRedirect("loginform.jsp?fail=invalid");
		return;
	}
	
	// 사용자가 입력한 아이디와 비밀번호로 암호비밀문을 만들고 DB에 저장되어
	// 있는 암호비밀문과 일치하는지 확인한다.
	String secretPassword = PasswordUtil.generateSecretPassword(id, password);
	
	if(!secretPassword.equals(savedUser.getPassword())) {				
		response.sendRedirect("loginform.jsp?fail=invalid");
		return;
	}
	
	// 탈퇴한 사용자일 경우 
	if ("Y".equals(savedUser.getDeleted())) {
		response.sendRedirect("loginform.jsp?fail=deleted");
		return;
	}
	
	session.setAttribute("LOGINED_USER", savedUser);
	
	response.sendRedirect("home.jsp");

%>