<%@page import="vo.User"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="dao.ProductReviewDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
    <%
    	Map<String, Object> result = new HashMap<>();
    	Gson gson = new Gson();

    	User user = (User) session.getAttribute("LOGINED_USER");
    	//	user_no는 session에서 항상 꺼내기 절대로 단독으로 주고 받지말기
    	if (user == null) {
    		result.put("error", "deny");
	    	String jsonText = gson.toJson(result);
	    	out.write(jsonText);
	    	
	    	return;
    	}
    
    	int productNo = StringUtil.stringToInt(request.getParameter("productNo"));    	
    	ProductReviewDao productReviewDao = ProductReviewDao.getInstance();
    	int reviewCount = productReviewDao.getReviewCount(productNo, user.getNo());
    	
    	if(reviewCount >= 1) {
    		result.put("exist", true);
    	} else {
    		result.put("exist", false);
    	}
    	
    	String jsonText = gson.toJson(result);
    	out.write(jsonText);
    	
    	return;
    %>
