<%@page import="com.google.gson.Gson"%>
<%@page import="dto.QuestionDto"%>
<%@page import="util.StringUtil"%>
<%@page import="dao.ProductQuestionDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp" trimDirectiveWhitespaces="true"%>
<%
	//세션에서 관리자정보를 조회한다.
	User admin = (User) session.getAttribute("ADMIN");
	if (admin == null) {
		throw new RuntimeException("상품수정 및 관리는 관리자 로그인 후 사용가능한 서비스 입니다.");
	}
	
    Map<String, Object> result = new HashMap<>();
	ProductQuestionDao productQuestionDao = ProductQuestionDao.getInstance();

	String[] questionNoList = request.getParameterValues("questionNos");
	
	for(String questionNoValue : questionNoList) {
		int questionNo = StringUtil.stringToInt(questionNoValue);
		QuestionDto questionDto = productQuestionDao.getProductQuestion(questionNo);
		productQuestionDao.deleteQuestionByNo(questionNo);
	}
	
	QuestionDto questionDto = productQuestionDao.getProductQuestion(StringUtil.stringToInt(questionNoList[0]));
	result.put("deletedCount", questionNoList.length);
	
	
    
    Gson gson = new Gson();
 	String jsonText = gson.toJson(result);
 	out.write(jsonText); 
    

%>