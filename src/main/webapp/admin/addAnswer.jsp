<%@page import="dto.ReviewDto"%>
<%@page import="dao.ReviewDao"%>
<%@page import="dto.QuestionDto"%>
<%@page import="dao.ProductQuestionDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 문의글 답글 저장하기
	
	String job = request.getParameter("job");
	

	if ("question".equals(job)) {
		int questionNo = StringUtil.stringToInt(request.getParameter("questionNo"));
		String answerContent = request.getParameter("content");
		
		ProductQuestionDao productQuestionDao = ProductQuestionDao.getInstance();
		QuestionDto questionDto = productQuestionDao.getProductQuestion(questionNo);
		
		questionDto.setAnswerContent(answerContent);
		questionDto.setAnswered("Y");
		
		productQuestionDao.addAnswer(questionDto);
		
		response.sendRedirect("questionDetailForm.jsp?questionNo=" + questionNo + "&pdNo=" + questionDto.getPdNo() + "&userNo=" + questionDto.getUserNo());
		
	} else if("review".equals(job)) {
		
		System.out.println("test");
		int reviewNo = StringUtil.stringToInt(request.getParameter("reviewNo"));
		String answerContent = request.getParameter("content");
		System.out.println(answerContent);
		
		ReviewDao reviewDao = ReviewDao.getInstance();
		ReviewDto reviewDto = reviewDao.getReviewDtoByreviewNo(reviewNo);
		
		reviewDto.setAnswerContent(answerContent);
		reviewDto.setAnswered("Y");
		
		reviewDao.addReviewAnswer(reviewDto);
		
		response.sendRedirect("reviewDetailForm.jsp?reviewNo=" + reviewNo + "&pdNo=" + reviewDto.getPdNo() +"&userNo=" + reviewDto.getUserNo());		
		
		
	}

%>