<%@page import="dto.QuestionDto"%>
<%@page import="vo.Question"%>
<%@page import="util.StringUtil"%>
<%@page import="dao.ProductQuestionDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
	    User user = (User) session.getAttribute("LOGINED_USER");
		if (user == null) {
			response.sendRedirect("../loginform.jsp?fail=deny");
			return;
		}
		
		int questionNo = StringUtil.stringToInt(request.getParameter("quNo"));
		int pdNo = StringUtil.stringToInt(request.getParameter("pdNo"));
		
		ProductQuestionDao dao = ProductQuestionDao.getInstance();
		QuestionDto question = dao.getProductQuestion(questionNo);
		
		if (question == null) {
			response.sendRedirect("detail.jsp?fail=invalid&pdNo=" + pdNo);
			return;
		}
		
		if (question.getUserNo() != user.getNo()) {
			response.sendRedirect("detail.jsp?fail=error&pdNo=" + pdNo);
			return;
		}
		
		question.setDeleted("Y");
		dao.updateQuestionDelete(question);
		
		response.sendRedirect("detail.jsp?pdNo=" + pdNo);
		
    %>
