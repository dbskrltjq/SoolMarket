<%@page import="dao.ProductReviewDao"%>
<%@page import="vo.User"%>
<%@page import="vo.Review"%>
<%@page import="util.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User user = (User) session.getAttribute("LOGINED_USER");
	
	if (user == null) {
		throw new RuntimeException("리뷰 등록은 로그인후 사용 가능한 서비스 입니다.");
	}

	int userNo = user.getNo();
	
	ProductReviewDao productReviewDao = ProductReviewDao.getInstance();

	MultipartRequest mr = new MultipartRequest(request,"C:\\eclipse\\workspace-web\\review-file");
	
	// 리뷰 요청파라미터 조회
	int pdNo = Integer.parseInt(mr.getParameter("productNo"));
	int score = Integer.parseInt(mr.getParameter("reviewScore"));
	String content = mr.getParameter("reviewContent");
	String reviewFileName = mr.getFilename("reviewFileName");
	
	Review review = new Review();
	review.setPdNo(pdNo);
	review.setUserNo(userNo);
	review.setScore(score);
	review.setContent(content);
	review.setFileName(reviewFileName);
	
	productReviewDao.insertReview(review);
	
	response.sendRedirect("detail.jsp?productNo=" + pdNo);
%>