<%@page import="dto.QuestionDto"%>
<%@page import="dao.ProductQuestionDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 문의글 답글 저장하기
	int questionNo = StringUtil.stringToInt(request.getParameter("questionNo"));
	String answerContent = request.getParameter("content");
	
	ProductQuestionDao productQuestionDao = ProductQuestionDao.getInstance();
	QuestionDto questionDto = productQuestionDao.getProductQuestion(questionNo);
	
	questionDto.setAnswerContent(answerContent);
	questionDto.setAnswered("Y");
	
	productQuestionDao.addAnswer(questionDto);
	
	response.sendRedirect("questionDetailForm.jsp?questionNo=" + questionNo + "&pdNo=" + questionDto.getPdNo() + "&userNo=" + questionDto.getUserNo());

%>