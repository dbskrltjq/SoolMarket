<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="dao.OrderDao"%>
<%@page import="vo.Order"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
    
<%
	User user = (User) session.getAttribute("LOGINED_USER");
	
	//int reviewNo = Integer.parseInt(request.getParameter("reveiwNo"));
	
	OrderDao orderDao = OrderDao.getInstance();
	int orderCount = orderDao.getOrderCount(user.getNo());
	
	Map<String, Boolean> result = new HashMap<>();
	
	if (orderCount > 0){
		result.put("exist", true);
	} else {
		result.put("exist", false);
	}
	
	Gson gson = new Gson();
	
	String jsonText = gson.toJson(result);
	
	out.write(jsonText);
	
	
%>
