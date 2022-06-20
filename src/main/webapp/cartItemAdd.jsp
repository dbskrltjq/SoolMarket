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
	
/*	CartItemDao cartItemDao = CartItemDao.getInstance();
	// 장바구니 아이템번호에 해당하는 장바구니 아이템 정보 조회
	Cart cart = cartItemDao.getCartItemByItemNo(itemNo);
	// 장바구니 아이템정보가 존재하지 않으면 장바구니 목록을 재요청하는 URL을 응답으로 보내고, 요청파라미터에 오류정보를 추가한다.
	if (cart == null) {
		response.sendRedirect("list.jsp?fail=invalid");
		return;
	}
	
	if (user.getNo() != item.getUserNo()) {
		response.sendRedirect("list.jsp?fail=deny");
		return; 
	}
*/	
	
	int userNo = Integer.parseInt(request.getParameter("userNo"));
	int pdNo = Integer.parseInt(request.getParameter("pdNo"));
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	
	Cart cart = new Cart();
	cart.setUserNo(userNo);
	cart.setPdNo(pdNo);
	cart.setQuantity(quantity);
	
	CartItemDao cartItemDao = CartItemDao.getInstance();
	cartItemDao.mergeCartItem(cart);
	
	response.sendRedirect("cart.jsp");
	
	
	
%>