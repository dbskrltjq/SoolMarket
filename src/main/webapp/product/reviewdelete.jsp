<%@page import="vo.User"%>
<%@page import="vo.Review"%>
<%@page import="dao.ProductReviewDao"%>
<%@page import="dao.ReviewDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
	   	User user = (User) session.getAttribute("LOGINED_USER");
		if (user == null) {
			response.sendRedirect("../loginform.jsp?fail=deny");
			return;
		}
		
		int reviewNo = StringUtil.stringToInt(request.getParameter("no"));
		int pdNo = StringUtil.stringToInt(request.getParameter("pdNo"));
		
		ReviewDao reviewDao = ReviewDao.getInstance();
		Review review = reviewDao.getReviewByNo(reviewNo);
		
		if (review == null) {
			throw new RuntimeException("리뷰 정보가 존재하지 않습니다.");
		}
		
		if (review.getUserNo() != user.getNo()) {
			throw new RuntimeException("다른 사람이 작성한 글은 삭제할 수 없습니다.");
		}
		
		review.setDeleted("Y");
		reviewDao.updateReviewDelete(review);
		
		response.sendRedirect("detail.jsp?pdNo=" + pdNo);
		
    %>