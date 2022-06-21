<%@page import="vo.User"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="dao.ProductReviewDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
    <%
    	Map<String, Object> result = new HashMap<>();
    	
    	User user = (User) session.getAttribute("LOGINED_USER");
    
    	ProductReviewDao productReviewDao = ProductReviewDao.getInstance();
    	int reviewUserCount = productReviewDao.getReviewUserCount(user.getNo());
    	
    	if(reviewUserCount > 0) {
    		result.put("exist",false);
    	} else {
    		result.put("exist",true);
    	}
    	
    	Gson gson = new Gson();
    	String jsonText = gson.toJson(result);
    	
    	out.write(jsonText);
    %>
