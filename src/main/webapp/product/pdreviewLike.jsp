<%@page import="vo.Review"%>
<%@page import="vo.ReviewLikeUser"%>
<%@page import="util.StringUtil"%>
<%@page import="dao.ReviewDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User user = (User) session.getAttribute("LOGINED_USER");
	
	int reviewNo = StringUtil.stringToInt(request.getParameter("reviewNo"));

	ReviewDao reviewDao = ReviewDao.getInstance();
	ReviewLikeUser reviewLikeUser = new ReviewLikeUser(reviewNo, user.getNo());
	
	Review review = reviewDao.getReviewByNo(reviewNo);
	
	
	review.setLikeCount(review.getLikeCount() + 1);
	reviewDao.updateReviewLikeCount(review);
	reviewDao.insertReviewLikeUser(reviewLikeUser);
	
	
	response.sendRedirect("detail.jsp");
	

%>