<%@page import="vo.PointHistory"%>
<%@page import="dao.HistoryDao"%>
<%@page import="dao.UserDao"%>
<%@page import="dao.OrderDao"%>
<%@page import="vo.Order"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   	<%
   		String fail = request.getParameter("fail");
   		
   		if ("invalid".equals(fail)) {
   	%>
		<div class="alert alert-danger">
			<strong>오류</strong>유효한 요청이 아닙니다. 
		</div>	
	<%
		} else if("deny".equals(fail)) {	
	%>
		<div class="alert alert-danger">
			<strong>거부</strong> 로그인 해주세요.
		</div>
	<%
		}
	%>
		
	<%
		User user = (User) session.getAttribute("LOGINED_USER");
		if (user==null) {
			response.sendRedirect("loginform.jsp?fail=deny"); 
			return;
		}

		int orderNo = StringUtil.stringToInt(request.getParameter("orderNo"));
		
		// Order의 상태를 '취소완료', 취소여부를 'Y'로 바꾸는 로직이다.
		Order order = new Order();
		order.setUserNo(user.getNo());
		order.setNo(orderNo);
		
		OrderDao orderDao = OrderDao.getInstance();
		orderDao.updateCancelOrder(order);
		
		// 사용포인트와 적립포인트를 원상복구 하는 로직이다. -> user
		// orderNo를 getOrderByOrderNo에 넣어 해당 orderNo의 주문정보를 구한다.
		// 해당 주문번호에서 유저포인트 + 사용한 포인트() - 적립된 포인트() 를 한다.
		// user를 업데이트한다.
		UserDao userDao = UserDao.getInstance();
		order = orderDao.getOrderByOrderNo(orderNo);
		
		int usedPoint = order.getUsedPoint();
		int depositPoint = order.getDepositPoint();
		
		// 여기서 User user = new User(); 해버리면 새 거 만들어져서 정보 사라짐 -> userNo도 없음 ... 
		user.setPoint(user.getPoint() + usedPoint - depositPoint);
		userDao.updateUserPoint(user);
		
		// pointHistory에 포인트 변경 이력을 넣는다.
		HistoryDao historyDao = HistoryDao.getInstance();
		PointHistory history = new PointHistory();
		
		if (usedPoint > 0) {
			history.setUserNo(user.getNo()); 			
			history.setOrderNo(orderNo);
			history.setAmount(usedPoint);
			history.setReason("취소-포인트 재적립");
			
			historyDao.insertPointHistory(history);			
		}

		if (depositPoint > 0) {
			history.setUserNo(user.getNo()); 			
			history.setOrderNo(orderNo);
			history.setAmount(depositPoint);
			history.setReason("취소-포인트 회수");
			
			historyDao.insertPointHistory(history);
		}
		
		
		response.sendRedirect("orderCancelComplete.jsp?orderNo="+orderNo);
	%>
	