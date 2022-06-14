<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

 <%
 	String email = request.getParameter("email");
 	UserDao userDao = UserDao.getInstance();
 	
 	User savedUser = userDao.getUserByEmail(email);
 	
 	Map<String, Boolean> result = new HashMap<>();
 	
 	if (savedUser != null) {
 		result.put("exist", true);
 	} else {
 		result.put("exist", false);	
 	}
 	
 	Gson gson = new Gson();
 	String jsonText = gson.toJson(result);
 	out.write(jsonText);
 	
 %>