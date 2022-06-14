<%@page import="util.PasswordUtil"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	UserDao userDao = UserDao.getInstance();
	
	User savedUser = userDao.getUserById(id);
	
	if (savedUser == null) {
		response.sendRedirect("loginform.jsp?fail=invalid");
		return;
	}
	
	String secretPassword = PasswordUtil.generateSecretPassword(id, password);
	
	if(!secretPassword.equals(savedUser.getPassword())) {				
		response.sendRedirect("loginform.jsp?fail=invalid");
		return;
	}
	
	session.setAttribute("LOGINED_USER", savedUser);
	
	response.sendRedirect("home.jsp");

%>