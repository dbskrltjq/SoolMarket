<%@page import="vo.User"%>
<%@page import="dao.CartItemDao"%>
<%@page import="vo.Cart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error/500.jsp"%>
<%
	
	//세션에서 로그인된 사용자정보를 조회한다.
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		throw new RuntimeException("장바구니는 로그인 후 사용가능한 서비스 입니다.");
	}
	
	int pdNo = Integer.parseInt(request.getParameter("productNo"));
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	
	CartItemDao cartItemDao = CartItemDao.getInstance();
	Cart cart = cartItemDao.getCartItemByPdNo(pdNo);

	cart = new Cart();
	cart.setUserNo(user.getNo());
	cart.setPdNo(pdNo);
	cart.setQuantity(quantity);
	
	cartItemDao.mergeCartItem(cart);
	
	response.sendRedirect("cart.jsp");
	
%>