<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

<%
	String inputTel = request.getParameter("tel");
	UserDao userDao = UserDao.getInstance();
	User savedUser = userDao.getUserByTel(inputTel);
	String job = request.getParameter("job");
	
	Gson gson = new Gson();
	Map<String, Object> result = new HashMap<>();
	
	if (job != null && "update".equals(job)) {				
    	User user = (User) session.getAttribute("LOGINED_USER");
    	
    	if (user != null && inputTel.equals(user.getTel())) {
    		result.put("exist", false);			
		 	String jsonText = gson.toJson(result);
		 	out.write(jsonText);
		 	return;
    	}
    }
	
	// findId.jsp에서 
	if(job != null && "findId".equals(job)) {
		String inputName = request.getParameter("name");
		
		
		if (savedUser != null && inputName.equals(savedUser.getName()) && "N".equals(savedUser.getDeleted())) {
			
			result.put("pass", true);
			result.put("foundId", savedUser.getId());
    		result.put("name", savedUser.getName());
    		
		} else if(!"N".equals(savedUser.getDeleted())) {
			
			result.put("deleted", true);
			result.put("pass", false);
			
		} else {
			result.put("pass", false);
		}
		
		String jsonText = gson.toJson(result);
	 	out.write(jsonText);
	 	return;
	}
	
	if(savedUser != null) {
		result.put("exist", true);
	} else {
		result.put("exist", false);
	}
	
	String jsonText = gson.toJson(result);
	out.write(jsonText);
	
	
	

%>