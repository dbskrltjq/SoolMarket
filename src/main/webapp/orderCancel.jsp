<%@page import="vo.PointHistory"%>
<%@page import="dao.HistoryDao"%>
<%@page import="dao.UserDao"%>
<%@page import="vo.User"%>
<%@page import="java.util.List"%>
<%@page import="dto.OrderItemDto"%>
<%@page import="dao.OrderDao"%>
<%@page import="vo.Order"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error/500.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap demo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<style>

</style>
<body>
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="myOrderDetail"/>
</jsp:include>
<div class="container "  style="padding: 30px;">
		
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
		
		// 사용포인트와 적립포인트를 원상복구 하는 로직이다. -> user
		// orderNo를 getOrderByOrderNo에 넣어 해당 orderNo의 주문정보를 구한다.
		// 해당 주문번호에서 유저포인트 + 사용한 포인트() - 적립된 포인트() 를 한다.
		// user를 업데이트한다.
		UserDao userDao = UserDao.getInstance();
		order = orderDao.getOrderByOrderNo(orderNo);

		if (order.getUserNo() != user.getNo()) {
			throw new RuntimeException("올바르지 않은 접근입니다.");
		}
		
		orderDao.updateCancelOrder(order);
		
		int usedPoint = order.getUsedPoint();
		int depositPoint = order.getDepositPoint();
		
		// 포인트 정보 업데이트 위해 user 다시 불러온다.
		user = userDao.getUserByNo(user.getNo()); 
		StringUtil.numberToString(user.getPoint());

		// 여기서 User user = new User(); 해버리면 새 거 만들어져서 정보 사라짐 -> userNo도 없음 ... 
		// 그렇다고 안 하니 말도 안 되는 오류 발생 -> 로그인된 유저의 환불 포인트가 쌓이고 쌓이고 쌓인다. 로그아웃되면 초기화됨.
		// getUserByNo 메소드 사용해서 값 집어넣으면 정보도 새로운 포인트 정보도 알 수 있다.
		int setPoint = (user.getPoint() + usedPoint - depositPoint);
		user.setPoint(setPoint);

		// pointHistory에 포인트 변경 이력을 넣는다.
		HistoryDao historyDao = HistoryDao.getInstance();
		PointHistory history = new PointHistory();
		userDao.updateUserPoint(user);
		
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

		
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script>

</script>
</body>
</html>