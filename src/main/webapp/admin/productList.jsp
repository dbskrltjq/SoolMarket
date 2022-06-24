<%@page import="vo.Pagination"%>
<%@page import="vo.Product"%>
<%@page import="java.util.List"%>
<%@page import="dao.ProductDao"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	ProductDao productDao = ProductDao.getInstance();

	int categoryNo = StringUtil.stringToInt(request.getParameter("categoryNo"));
	int period = StringUtil.stringToInt(request.getParameter("period"));
	int rows = StringUtil.stringToInt(request.getParameter("rows"));
	int currentPage = StringUtil.stringToInt(request.getParameter("pageNo"));
	int totalRows = productDao.getTotalRows(categoryNo, period);
	String keyword = request.getParameter("keyword");
	
	Pagination pagination = new Pagination(rows, totalRows, currentPage);
	Map<String, Object> result = new HashMap<>();
	
	List<Product> products = productDao.getProductsByCategoryNo(period, categoryNo, pagination.getBeginIndex(), pagination.getEndIndex());
	if(keyword != "") {
		products = productDao.getProductsByCategoryNo(period, keyword, categoryNo, pagination.getBeginIndex(), pagination.getEndIndex());
	}

	result.put("pagination", pagination);
	result.put("products", products);

	Gson gson = new Gson();
	String jsonText = gson.toJson(result);
 	out.write(jsonText);
	


%>