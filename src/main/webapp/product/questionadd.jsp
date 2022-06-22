<%@page import="dao.ProductQuestionDao"%>
<%@page import="vo.Question"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		response.sendRedirect("../loginform.jsp?fail=deny");
		return;
	}
	
	int pdNo = Integer.parseInt(request.getParameter("pdNo"));
	String title = request.getParameter("title");
	String content =request.getParameter("content");

	Question question = new Question();
	question.setUserNo(user.getNo());
	question.setPdNo(pdNo);
	question.setTitle(title);
	question.setContent(content);
	
	ProductQuestionDao productQuestionDao = ProductQuestionDao.getInstance();
	productQuestionDao.insertQuestion(question);
	
	response.sendRedirect("detail.jsp?pdNo="+pdNo);
%>