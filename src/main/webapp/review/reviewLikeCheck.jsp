<%@page import="vo.Review"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.ReviewLikeUser"%>
<%@page import="dao.ReviewDao"%>
<%@page import="dao.OrderDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
    
<%
	User user = (User) session.getAttribute("LOGINED_USER");
	int reviewNo = StringUtil.stringToInt(request.getParameter("reviewNo"));
	
	ReviewDao reviewDao = ReviewDao.getInstance();
	Review review = reviewDao.getReviewByNo(reviewNo);
	
	Map<String, Boolean> result = new HashMap<>();

	
	
	
	if(review.getUserNo() == user.getNo()){
		result.put("same", true);
	} else{
		result.put("same", false);
	}
	
	ReviewLikeUser reviewLikeUser = reviewDao.getReviewLikeUser(reviewNo,user.getNo());
	if(reviewLikeUser != null) {
		result.put("already", true);
	} else {
		result.put("already", false);
	}
	
	Gson gson = new Gson();
	String jsonText = gson.toJson(result);
	
	out.write(jsonText);
%>
