<%@page import="dao.CartItemDao"%>
<%@page import="vo.Cart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	// 로그인된 유저의 cart에서 변경하고자 하는 cartNo와 수량을 가져온다.
	int cartNo = Integer.parseInt(request.getParameter("cartNo"));
	int quantity = Integer.parseInt(request.getParameter("quantity"));

	// cartPd 객체를 생성하고, 카트 번호와 수량을 넣는다.
	Cart cartPd = new Cart();
	cartPd.setNo(cartNo);
	cartPd.setQuantity(quantity);
	
	// 값이 들어간 객체를 updateCartItem 메소드로 보낸다.
	CartItemDao cartItemDao = CartItemDao.getInstance();
	cartItemDao.updateCartItem(cartPd);
	
	// cart.jsp를 리다이렉트한다.
	response.sendRedirect("cart.jsp");
%>