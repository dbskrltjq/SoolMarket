<%@page import="java.util.List"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.User"%>
<%@page import="vo.Order"%>
<%@page import="dao.OrderDao"%>
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
<style>
	tr { text-align : center; }
	td { text-align : center; padding: 5px;}
</style>
<body>
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="cart"/>
</jsp:include>
<div class="container "  style="padding: 30px;">

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
			<strong>거부</strong>다른 사용자의 장바구니 아이템을 변경할 수 없습니다.
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
	<div class="row">			
  		<div class="col-2">
			<h5 class="border-bottom pb-2  mb-4"><strong>마이페이지</strong></h5>
       		<p><strong class="fs-6">쇼핑정보</strong></p>
       		<p></p>
       		<div class="list-group list-group-flush mb-4">
       			<a href="myOrder.jsp" class="list-group-item list-group-item-action">- 주문목록</a>
       			<a href="#" class="list-group-item list-group-item-action">- 취소 내역</a>
       			<a href="cart.jsp" class="list-group-item list-group-item-action">- 장바구니 보기</a>
			</div>
			<p><strong class="fs-6">회원정보</strong></p>
       		<div class="list-group list-group-flush">
       			<a href="myPagePassword.jsp" class="list-group-item list-group-item-action">- 회원정보 변경</a>
       			<a href="userDeleteForm.jsp" class="list-group-item list-group-item-action">- 회원 탈퇴</a>
       			<a href="#" class="list-group-item list-group-item-action">- 나의 상품문의</a>
			</div>
		</div>
		<div class="col-10 mt-3">
			<div class="card">
				<div class="card-body">
					<table class="order-complete table">
						<colgroup>
							<col width="10%">
							<col width="15%">
							<col width="*">
							<col width="5%">		
							<col width="10%">
							<col width="10%">
	
						</colgroup>
						<thead>
							<tr class="border bg-light p-3">
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
						List<Order> orders = orderDao.getAllOrdersByUserNo(user.getNo());
						
						if(orders.isEmpty()) {
					%>
						<tr>
							<td colspan="6" class="text-center"><strong>주문내역이 없습니다.</strong></td>
						</tr>
					
					<%
						
						} else { 
							for (Order order : orders) {

					%>
							<tr>
								<td><%=order.getNo() %></td>
								<td><%=order.getCreatedDate() %></td>
								<td style="text-align:left">
									<a href="myOrderDetail.jsp?orderNo=<%=order.getNo() %>"><%=order.getTitle() %></a>
								</td>
								<td><%=order.getTotalQuantity() %></td>
								<td><%=order.getStatus() %></td>
								<td><%=StringUtil.numberToString(order.getPaymentPrice()) %></td>
							</tr>
					<%
							}
						}
					%>
						</tbody>
					</table>		
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>