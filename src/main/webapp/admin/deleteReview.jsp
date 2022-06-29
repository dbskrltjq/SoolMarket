<%@page import="com.google.gson.Gson"%>
<%@page import="dto.ReviewDto"%>
<%@page import="util.StringUtil"%>
<%@page import="dao.ReviewDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" errorPage="../error/500.jsp" %>
<%
	//세션에서 관리자정보를 조회한다.
	User admin = (User) session.getAttribute("ADMIN");
	if (admin == null) {
		throw new RuntimeException("상품수정 및 관리는 관리자 로그인 후 사용가능한 서비스 입니다.");
	}
	
    Map<String, Object> result = new HashMap<>();
	ReviewDao reviewDao = ReviewDao.getInstance();

	String[] reviewNoList = request.getParameterValues("reviewNos");
	
	for(String reviewNoValue : reviewNoList) {
		int reviewNo = StringUtil.stringToInt(reviewNoValue);
		ReviewDto reviewDto = reviewDao.getReviewDtoByreviewNo(reviewNo);
		reviewDao.deleteReviewByNo(reviewNo);
	}
	
	result.put("deletedCount", reviewNoList.length);
	
	
    
    Gson gson = new Gson();
 	String jsonText = gson.toJson(result);
 	out.write(jsonText); 
    

%>