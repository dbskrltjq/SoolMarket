<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

 <%
 	Map<String, Boolean> result = new HashMap<>();
 	Gson gson = new Gson();

 	String email = request.getParameter("email");
    String job = request.getParameter("job");
    
    if (job != null) {
    	User user = (User) session.getAttribute("LOGINED_USER");
    	
    	if (user != null && user.getEmail().equals(email)) {
    		result.put("exist", false);			
		 	String jsonText = gson.toJson(result);
		 	out.write(jsonText);
		 	return;
    	}
    }
    
 	UserDao userDao = UserDao.getInstance(); 	
 	User savedUser = userDao.getUserByEmail(email); 	 	
 	
 	if (savedUser != null) {
	 	result.put("exist", true); 			
 		
 	} else {
 		result.put("exist", false);	
 	}
 	
 	String jsonText = gson.toJson(result);
 	out.write(jsonText);
 	return;
 %>