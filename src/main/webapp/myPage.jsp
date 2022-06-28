<%@page import="util.StringUtil"%>
<%@page import="vo.Order"%>
<%@page import="java.util.List"%>
<%@page import="dao.OrderDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error/500.jsp"%>
    
<%
	//세션에서 로그인된 사용자정보를 조회한다.
	User user = (User) session.getAttribute("LOGINED_USER");
	if (user == null) {
		throw new RuntimeException("회원정보 수정은 로그인 후 사용가능한 서비스 입니다.");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap demo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
	.list-group-item {font-size:small; }
	span {font-size: small; }
	label {font-size: large; font-weight: bold; color: #189FDB;}
</style>
</head>
<body>
<jsp:include page="common/nav.jsp"></jsp:include>
<div class="container" style="padding: 30px;">
	<div class="row">
		<div class="col-2">
			<h5 class="border-bottom pb-2  mb-4"><strong>마이페이지</strong></h5>

         	<p><strong class="fs-6">쇼핑정보</strong><p>
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
		<div class="col-8 ms-5 mt-3">
			<div class="row border">
				<div class="col-3">
				
					<%=user.getName() %>님의 마이페이지입니다.
				</div>
				<div class="col-3">
					<h6><strong>쿠폰</strong></h6>
					<label>0</label>장
				</div>
				<div class="col-3">
					<h6><strong>포인트</strong></h6>
					<label><%=user.getPoint() %></label>원
				</div>
				<div class="col-3">
					<h6><strong>예치금</strong></h6>
					<label>0</label>원
				</div>
			</div>
			<div class="row mt-5">
				<div class="col-12">
					<h6><strong>최근 주문 정보</strong><span> 최근 30일 내에 주문하신 내역입니다.</span></h6>
				</div>
				<table class="border">
					<colgroup>
							<col width="10%">
							<col width="15%">
							<col width="*">	
							<col width="10%">
							<col width="10%">
							<col width="5%">
					</colgroup>
					<thead>
						<tr class="bg-light">
							<th>주문번호</th>
							<th>날짜</th>
							<th>주문정보</th>
							<th>주문상태</th>
							<th>결제금액</th>
							<th>확인/리뷰</th>
						</tr>
					</thead>
					<tbody class="table-group-divider">
				<%
					OrderDao orderDao = OrderDao.getInstance();
					List<Order> orders = orderDao.getRecentOrdersByUserNo(user.getNo());
					
					if(orders.isEmpty()) {
				%>
					<tr>
						<td colspan="6" class="text-center"><strong>지난 30일간의 주문내역이 없습니다.</strong></td>
					</tr>
				
				<%
					} else {
						for(Order order : orders) {
				%>
						<tr >
							<td><%=order.getNo() %></td>
							<td><%=order.getCreatedDate() %></td>
							<td style="text-align:left">
								<a href="myOrderDetail.jsp?orderNo=<%=order.getNo() %>" class="my-order-link"><%=order.getTitle() %></a>
							</td>
							<td><%=order.getStatus() %></td>
							<td><%= StringUtil.numberToString(order.getPaymentPrice()) %></td>
							<td></td>
						</tr>
				<%
						}
					}
				%>
					</tbody>
			</table>
			</div>
			<div class="row mt-5">
				<h6><strong>최근 본 상품</strong> <span><%=user.getName()%>님께서 본 최근 상품입니다.</span></h6>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>