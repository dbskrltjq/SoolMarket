<%@page import="vo.Review"%>
<%@page import="vo.ReviewLikeUser"%>
<%@page import="util.StringUtil"%>
<%@page import="dao.ReviewDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp"%>
<%
	User user = (User) session.getAttribute("LOGINED_USER");

	if (user == null) {
		throw new RuntimeException("좋아요 기능은 로그인 후 사용가능한 서비스 입니다.");
	}

	
	int reviewNo = StringUtil.stringToInt(request.getParameter("reviewNo"));

	ReviewDao reviewDao = ReviewDao.getInstance();
	ReviewLikeUser reviewLikeUser = new ReviewLikeUser(reviewNo, user.getNo());
	
	Review review = reviewDao.getReviewByNo(reviewNo);
	
	
	review.setLikeCount(review.getLikeCount() + 1);
	reviewDao.updateReviewLikeCount(review);
	reviewDao.insertReviewLikeUser(reviewLikeUser);
	
	
	response.sendRedirect("totalReview.jsp");
	

%>