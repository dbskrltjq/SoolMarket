<%@page import="dao.UserDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	UserDao userDao = UserDao.getInstance();
	User user = (User)session.getAttribute("LOGINED_USER");
	
	user.setDeleted("Y");
	userDao.updateUser(user);
	
	session.invalidate();
	
	response.sendRedirect("home.jsp");
	
%>