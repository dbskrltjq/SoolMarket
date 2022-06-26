<%@page import="vo.Order"%>
<%@page import="java.util.List"%>
<%@page import="dao.OrderDao"%>
<%@page import="util.StringUtil"%>
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
<style>
	tr { text-align : center; }
	td { 
			text-align : center; 
			padding: 5px;
		}
	
	.my-order-link {
			 text-decoration-line: none;
			 color : #333333;
		}
</style>
<body>
<div class="container">
	<% 
		User user = (User) session.getAttribute("LOGINED_USER"); 
	%>

   <p>버튼을 누르면 상품이 담깁니다.</p>
   <!-- 여기의 userNo는 session에서 가지고 와야 한다. 
   		userNo를 그대로 넘기면 안 된다. 지금은 계속 로그인하기 번거로워서 값 넣어놓는 거다.-->
      	<a href="cartItemAdd.jsp?userNo=6&pdNo=107&quantity=3" 
	      	id="cart-go-link" 
	      	class="btn btn-outline-secondary btn-sm">상품 추가
      	</a>
      	
   <p>버튼을 누르면 바로구매가 가능합니다..</p>
   <!-- 여기의 userNo는 session에서 가지고 와야 한다. -->
      	<a href="orderNow.jsp?userNo=6&pdNo=107&quantity=3" 
	      	id="order-now-link" 
	      	class="btn btn-outline-secondary btn-sm">바로 구매
      	</a>
      	
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
				<label><%=StringUtil.numberToString(user.getPoint()) %></label>원
			</div>
			<div class="col-3">
				<h6><strong>예치금</strong></h6>
				<label>0</label>원
			</div>
		</div>
		
		<div class="row mt-5">
			<div class="col-12">
				<h6><strong>최근 주문 정보</strong><span> 최근 30일 내에 주문하신 내역입니다.</span></h6>
				<a href="myOrder.jsp" class="my-order-link" style="text-align:right">+ 더보기</a>
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
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>