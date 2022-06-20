<%@page import="vo.User"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.Cart"%>
<%@page import="dao.CartItemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error/500.jsp"%>
<%
	
	//세션에서 로그인된 사용자정보를 조회한다.
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		throw new RuntimeException("장바구니는 로그인 후 사용가능한 서비스 입니다.");
	}

	// 장바구니가 빈 상태에서 선택상품 삭제를 누르면 에러 500이 뜬다.
	// cartNo로 아무것도 전달되지 않아 for문에 null이 전달되기 때문이다.
	// 이를 방지하기 위해, 아예 '선택상품 삭제'를 누를 때부터 check된 상품이 0이라면 그 값이 서버로 가지도 못하게 return 해버리자.
	String[] cartNoValues = request.getParameterValues("cartNo");

	CartItemDao cartItemDao = CartItemDao.getInstance();
	for (String value : cartNoValues) {
		int cartNo = StringUtil.stringToInt(value);
		cartItemDao.deleteCartItem(cartNo);	
	}
	
	// 로그인한 유저와 삭제하려는 유저가 일치하지 않거나, 삭제하려는 상품이 존재하지 않는 경우, 에러로 넘기지 말고 무시한다.
	// 따로 에러메세지 띄우지 말고 for문 내에서 무시하면 된다.
	
	response.sendRedirect("cart.jsp");
	
%>