<%@page import="com.google.gson.Gson"%>
<%@page import="vo.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="dao.UserDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
    
 <%
	String userId =request.getParameter("id");
 	UserDao userDao = UserDao.getInstance();
 	User savedUser = userDao.getUserById(userId);
 	
 	Map<String, Object> result = new HashMap<>();
 	
 	if(savedUser != null) {
		result.put("exist", true);
		result.put("id", userId);
	} else {
		result.put("exist", false);				
		result.put("id", userId);
	}
 	
 	Gson gson = new Gson();
 	String jsonText = gson.toJson(result);
 	out.write(jsonText);
 %>
