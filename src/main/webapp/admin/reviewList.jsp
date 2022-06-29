<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="vo.Pagination"%>
<%@page import="dao.ReviewDao"%>
<%@page import="dto.ReviewDto"%>
<%@page import="java.util.List"%>
<%@page import="util.StringUtil"%>
<%@page import="util.MultipartRequest"%>
<%@page import="dao.ProductReviewDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp" trimDirectiveWhitespaces="true"%>


<%
	User admin = (User)session.getAttribute("ADMIN");
	if (admin == null) {
		throw new RuntimeException("해당 서비스는 관리자만 이용할 수 있습니다.");
	}  
	
	ReviewDao reviewDao = ReviewDao.getInstance();
	MultipartRequest mr = new MultipartRequest(request, "");
	
	int categoryNo = StringUtil.stringToInt(mr.getParameter("category"));
	String search = mr.getParameter("search"); // "상품명": "name", "제목": "title", "내용": "content"
	String keyword = mr.getParameter("keyword");
	int period = StringUtil.stringToInt(mr.getParameter("period")); // 오늘 : 0, 7일: -7, 1개월: -30, 전체: -9999
	String deleted = mr.getParameter("deleted");     //  "삭제" : "Y", "보유" : "N"
	
	
	int rows = StringUtil.stringToInt(mr.getParameter("rows"));
	int currentPage = StringUtil.stringToInt(mr.getParameter("page"));
	
	//System.out.println("categoryNo:" + categoryNo + ", search: " + search + ", keyword: " + keyword + " period: " + period + ", deleted: " + deleted + " rows: " + rows );
	
	int totalRows = 0;
	
	if(keyword.isBlank()) {
		totalRows = reviewDao.getTotalRowsByCategoryNo(categoryNo, deleted, period);
	} else {
		if("name".equals(search)) {
			totalRows = reviewDao.getTotalRowsByPdNameKeyword(categoryNo, deleted, keyword, period);
		} else if("title".equals(search)) {
			totalRows = reviewDao.getTotalRowsByTitleKeyword(categoryNo, deleted, keyword, period);
		} else if("content".equals(search)) {
			totalRows = reviewDao.getTotalRowsByContentKeyword(categoryNo, deleted, keyword, period);
		}
	}
	//System.out.println("totalRows: " + totalRows);
	Pagination pagination = new Pagination(rows, totalRows, currentPage);
	
	
	 List<ReviewDto> reviewDtos = null;
	
	if(keyword.isBlank()) {
			reviewDtos = reviewDao.getReviewDtoByCategoryNo(categoryNo, deleted, period, pagination.getBeginIndex(), pagination.getEndIndex());
		} else {
			if("name".equals(search)) {
				reviewDtos = reviewDao.getReviewDtoByPdNameKeyword(categoryNo, deleted, keyword, period, pagination.getBeginIndex(), pagination.getEndIndex());
			} else if("title".equals(search)) {
				reviewDtos = reviewDao.getReviewDtoByTitleKeyword(categoryNo, deleted, keyword, period, pagination.getBeginIndex(), pagination.getEndIndex());
			} else if("content".equals(search)) {
				reviewDtos = reviewDao.getReviewDtoByContentKeyword(categoryNo, deleted, keyword, period, pagination.getBeginIndex(), pagination.getEndIndex());
			}
		}
	
	//System.out.println(reviewDtos.size());
	
	Map<String, Object> result = new HashMap<>();
	result.put("pagination", pagination);
	result.put("reviews", reviewDtos);
	
	Gson gson = new Gson();
	String jsonText = gson.toJson(result);
 	out.write(jsonText); 
	
	
	
	
	
	
%>