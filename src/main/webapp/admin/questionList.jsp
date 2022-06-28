<%@page import="com.google.gson.Gson"%>
<%@page import="vo.Pagination"%>
<%@page import="dto.QuestionDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.ProductQuestionDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="util.StringUtil"%>
<%@page import="util.MultipartRequest"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<%
	ProductQuestionDao dao = ProductQuestionDao.getInstance();

	MultipartRequest mr = new MultipartRequest(request, "");
	
	int categoryNo = StringUtil.stringToInt(mr.getParameter("category")); 	// "전체카테고리" 일 경우 0이다.
	String search = mr.getParameter("search"); // "상품명": "name", "제목": "title", "내용": "content"
	String keyword = mr.getParameter("keyword");
	int period = StringUtil.stringToInt(mr.getParameter("period")); // 오늘 : 0, 7일: -7, 1개월: -30, 전체: -9999
	String answered = mr.getParameter("answered");     // "답변완료" : "Y", "답변필요" : "N"

	int rows = StringUtil.stringToInt(mr.getParameter("rows"));
	int currentPage = StringUtil.stringToInt(mr.getParameter("page"));


	//System.out.println("categoryNo:" + categoryNo + ", search: " + search + ", keyword: " + keyword + " period: " + period + ", answered: " + answered + " rows: " + rows );
	Map<String, Object> result = new HashMap<>();
	
	int totalRows = 0;
	if(categoryNo == 0) {
		if (keyword.isBlank()) {
			totalRows = dao.getTotalRowsWithoutKeyword(period, answered);			
		} else {
			if("name".equals(search)) {
				totalRows = dao.getTotalRowsByPdNameKeyword(keyword, period, answered);
			} else if("title".equals(search)) {
				totalRows = dao.getTotalRowsBytitleKeyword(keyword, period, answered);
			} else if("content".equals(search)) {
				totalRows = dao.getTotalRowsBycontentKeyword(keyword, period, answered);
			}
		}
	} else {
		if (keyword.isBlank()) {
			totalRows = dao.getTotalRowsWithoutKeyword(categoryNo, period, answered);			
		} else {
			if("name".equals(search)) {
				totalRows = dao.getTotalRowsByPdNameKeyword(categoryNo, keyword, period, answered);
			} else if("title".equals(search)) {
				totalRows = dao.getTotalRowsBytitleKeyword(categoryNo, keyword, period, answered);
			} else if("content".equals(search)) {
				totalRows = dao.getTotalRowsBycontentKeyword(categoryNo, keyword, period, answered);
			}			
		}
	}
	
	Pagination pagination = new Pagination(rows, totalRows, currentPage);	
	
	//System.out.println("totalRows: " + totalRows);
	
	List<QuestionDto> questionDtos = null;
	if(categoryNo == 0) {
		if (keyword.isBlank()) {
			questionDtos = dao.getQuestionsWithoutKeyword(period, answered, pagination.getBeginIndex(), pagination.getEndIndex());			
		} else {
			if("name".equals(search)) {
				questionDtos = dao.getQuestionsByPdNameKeyword(keyword, period, answered, pagination.getBeginIndex(), pagination.getEndIndex());
			} else if("title".equals(search)) {
				questionDtos = dao.getQuestionsBytitleKeyword(keyword, period, answered, pagination.getBeginIndex(), pagination.getEndIndex());
			} else if("content".equals(search)) {
				questionDtos = dao.getQuestionsBycontentKeyword(keyword, period, answered, pagination.getBeginIndex(), pagination.getEndIndex());
			}
		}
		
	} else {
		if (keyword.isBlank()) {
			questionDtos = dao.getQuestionsWithoutKeyword(categoryNo, period, answered, pagination.getBeginIndex(), pagination.getEndIndex());			
		} else {
			if("name".equals(search)) {
				questionDtos = dao.getQuestionsByPdNameKeyword(categoryNo, keyword, period, answered, pagination.getBeginIndex(), pagination.getEndIndex());
			} else if("title".equals(search)) {
				questionDtos = dao.getQuestionsBytitleKeyword(categoryNo, keyword, period, answered, pagination.getBeginIndex(), pagination.getEndIndex());
			} else if("content".equals(search)) {
				questionDtos = dao.getQuestionsBycontentKeyword(categoryNo, keyword, period, answered, pagination.getBeginIndex(), pagination.getEndIndex());
			}			
		}
	}
	
	//System.out.println("한페이지 문의 개수: " + questionDtos.size());
	
	result.put("pagination", pagination);
	result.put("questions", questionDtos);
	
	Gson gson = new Gson();
	String jsonText = gson.toJson(result);
 	out.write(jsonText);
	
%>