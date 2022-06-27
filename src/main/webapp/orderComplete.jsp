<%@page import="java.util.ArrayList"%>
<%@page import="vo.Order"%>
<%@page import="java.util.List"%>
<%@page import="util.StringUtil"%>
<%@page import="dao.OrderDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap demo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="orderComplete"/>
</jsp:include>
<div class="container">
	<div class="row">
		<div class="col">
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
					<strong>거부</strong>다른 사용자의 주문 완료 페이지를 볼 수 없습니다.
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
			%>
			
		    <h1>주문 완료!</h1>
		    <h2> <%=user.getName() %>님의 주문이 완료되었습니다. </h2>
  		</div>
    </div>
    
    <!-- table 표 형식으로 시킨 상품 보여준다. -->
    <!-- 날짜 주문번호 (사진) 상품명 수량 상품금액 합계금액 주문상태 총총금액 -->
    <div class="row">
    	<div class="col">
    		<input type="hidden" name="from" value="orderComplete" />
			<table class="order-complete table">
				<colgroup>
					<col width="10%">
					<col width="10%">
					<col width="*">
					<col width="5%">		
					<col width="10%">
					<col width="10%">

				</colgroup>
				<thead>
					<tr>
						<th>주문번호</th>
						<th>날짜</th>
						<th>주문정보</th>
						<th>수량</th>
						<th>주문상태</th>
						<th>결제금액</th>
					</tr>
				</thead>
				<tbody>
			<%
				OrderDao orderDao = OrderDao.getInstance();
			
				int orderNo = StringUtil.stringToInt(request.getParameter("orderNo"));		
				Order order = orderDao.getOrderByOrderNo(orderNo);

			%>
					<tr>
						<td><%=order.getNo() %></td>
						<td><%=order.getCreatedDate() %></td>
						<td><%=order.getTitle() %></td>
						<td><%=order.getTotalQuantity() %></td>
						<td><%=order.getStatus() %></td>
						<td><%=StringUtil.numberToString(order.getPaymentPrice()) %></td>
					</tr>
				</tbody>
			</table>
    	</div>
    </div>
    
    <!-- 버튼 -->
   	<div class="row mb-3"> 
		<div class="col-6">
      		<a href="myOrderDetail.jsp?orderNo=<%=order.getNo() %>" id="myorder-go-link" class="btn btn-outline-secondary btn-sm">내 주문정보로 가기</a>
      		<a href="home.jsp" id="shop-go-link" class="btn btn-primary btn-sm">홈으로 가기</a>
    	</div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>