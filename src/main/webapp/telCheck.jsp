<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

<%
	String tel = request.getParameter("tel");
	UserDao userDao = UserDao.getInstance();
	User savedUser = userDao.getUserByTel(tel);
	String job = request.getParameter("job");
	
	Gson gson = new Gson();
	Map<String, Object> result = new HashMap<>();
	
	if (job != null) {				
    	User user = (User) session.getAttribute("LOGINED_USER");
    	
    	if (user != null && user.getTel().equals(tel)) {
    		result.put("exist", false);			
		 	String jsonText = gson.toJson(result);
		 	out.write(jsonText);
		 	return;
    	}
    }
	
	if(savedUser != null) {
		result.put("exist", true);
	} else {
		result.put("exist", false);
	}
	
	String jsonText = gson.toJson(result);
	out.write(jsonText);
	
	
	

%>