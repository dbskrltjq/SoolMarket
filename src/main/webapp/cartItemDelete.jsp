<%@page import="util.StringUtil"%>
<%@page import="vo.Cart"%>
<%@page import="dao.CartItemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 로그인체크
	// deletePd undefined 뜸
	String[] cartNoValues = request.getParameterValues("cartNo");

	CartItemDao cartItemDao = CartItemDao.getInstance();
	for (String value : cartNoValues) {
		int cartNo = StringUtil.stringToInt(value);
		cartItemDao.deleteCartItem(cartNo);	
	}
	
	// 에러 말고 ...
	// 로그인한 유저와 삭제하려는 유저가 일치하지 않거나, 삭제하려는 상품이 존재하지 않는 경우, 에러로 넘기지 말고 무시한다.
	
	// 장바구니 아이템번호와 일치하는 장바구니 아이템 삭제하기
	
	response.sendRedirect("cart.jsp");
	
%>