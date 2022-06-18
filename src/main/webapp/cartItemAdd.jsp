<%@page import="dao.CartItemDao"%>
<%@page import="vo.Cart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//세션에서 로그인된 사용자 정보 조회하기
	// 연습 : userNo = 1
	
	// 요청URL : http://localhost/semi/cart/add.jsp?pdNo=100&quantity=5
	// 요청파라미터
	//		name 	value
	//		pdNo	101
	// 연습 : 상품번호 101, 양 5
	
	//int pdNo = Integer.parseInt(request.getParameter("pdNo"));
	//int quantity = Integer.parseInt(request.getParameter("quantity"));

	/* 
	
	Cart cart = new Cart();
	cart.setPdNo(pdNo);
	cart.setUserNo(1);
	cart.setQuantity(quantity);
	
	CartItemDao cartItemDao = CartItemDao.getInstance();
	cartItemDao.mergeCartItem(cart);
	
	response.sendRedirect("cart.jsp");
	
	*/
	
%>