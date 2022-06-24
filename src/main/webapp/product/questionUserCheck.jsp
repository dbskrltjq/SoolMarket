<%@page import="vo.User"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="dao.ProductReviewDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
    <%
    	Map<String, Boolean> result = new HashMap<>();
    	Gson gson = new Gson();
    	
    	User user = (User) session.getAttribute("LOGINED_USER");
    
    	if (user == null) {
    		result.put("exist", false);
    		String jsonText = gson.toJson(result);
	    	out.write(jsonText);
	    	return;
	    	
    	} else {
    		result.put("exist", true);
    	}
    	
    	String jsonText = gson.toJson(result);
    	out.write(jsonText);
    %>
