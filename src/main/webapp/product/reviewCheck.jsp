<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="dao.ProductReviewDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
    <%
    	int productNo = StringUtil.stringToInt(request.getParameter("productNo"));
    	int userNo = StringUtil.stringToInt(request.getParameter("userNo"));
    	
    	ProductReviewDao productReviewDao = ProductReviewDao.getInstance();
    	int reviewCount = productReviewDao.getReviewCount(productNo, userNo);
    	
    	Map<String, Boolean> result = new HashMap<>();
    	if(reviewCount > 0) {
    		result.put("exist", true);
    	} else {
    		result.put("exist",false);
    	}
    	
    	Gson gson = new Gson();
    	String jsonText = gson.toJson(result);
    	
    	out.write(jsonText);
    %>
