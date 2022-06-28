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
			response.sendRedirect("detail.jsp?fail=invalid");
			return;
		}
		
		if (review.getUserNo() != user.getNo()) {
			response.sendRedirect("detail.jsp?fail=deny");
			return;
		}
		
		review.setDeleted("Y");
		reviewDao.updateReviewDelete(review);
		
		response.sendRedirect("detail.jsp?pdNo=" + pdNo);
		
    %>