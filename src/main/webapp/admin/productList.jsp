<%@page import="vo.Product"%>
<%@page import="java.util.List"%>
<%@page import="dao.ProductDao"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	int categoryNo = StringUtil.stringToInt(request.getParameter("categoryNo"));
	ProductDao productDao = ProductDao.getInstance();
	List<Product> products = productDao.getProductsByCategoryNo(categoryNo);

	Gson gson = new Gson();
	Map<String, Object> result = new HashMap<>();
	
	result.put("productList", products);
	
	String jsonText = gson.toJson(result);
 	out.write(jsonText);
	


%>