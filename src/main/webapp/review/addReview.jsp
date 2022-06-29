<%@page import="dao.ReviewDao"%>
<%@page import="vo.Review"%>
<%@page import="util.MultipartRequest"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp"%>
<%
	User user = (User) session.getAttribute("LOGINED_USER");
	if(user == null) {
		throw new RuntimeException("리뷰등록은 로그인후 사용가능한 서비스입니다.");
	}
	
	
	
	MultipartRequest mr = new MultipartRequest(request, "C:\\eclipse\\workspace-web\\semi\\src\\main\\webapp\\reviewImage");
	
	int productNo = Integer.parseInt(mr.getParameter("productNo"));
	int score = Integer.parseInt(mr.getParameter("score"));
	String content = mr.getParameter("content");
	String fileName = mr.getParameter("upfile");
	
	Review review = new Review();
	review.setUserNo(user.getNo());
	review.setPdNo(productNo);
	review.setContent(content);
	review.setScore(score);
	review.setFileName(fileName);
	
	ReviewDao reviewDao = ReviewDao.getInstance();
	reviewDao.insertReview(review);
	
	response.sendRedirect("totalReview.jsp");
	
%>
