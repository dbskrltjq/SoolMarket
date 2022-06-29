<%@page import="vo.Order"%>
<%@page import="dto.OrderItemDto"%>
<%@page import="java.util.List"%>
<%@page import="util.StringUtil"%>
<%@page import="dao.OrderDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error/500.jsp"%>
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
	<jsp:param name="menu" value="myCancelDetail"/>
</jsp:include>
<div class="container "  style="padding: 30px;">
		
	<% 	
		User user = (User) session.getAttribute("LOGINED_USER");
		if (user==null) {
			response.sendRedirect("loginform.jsp?fail=deny"); 
			return;
		}
	%>
	
	<form id="my-order-detail" method="post">
	<input type="hidden" name="from" value="myOrderDetail" />
	<div class="row">			
  		<div class="col-2">
			<h5 class="border-bottom pb-2  mb-4"><strong>마이페이지</strong></h5>
       		<p><strong class="fs-6">쇼핑정보</strong></p>
       		<p></p>
       		<div class="list-group list-group-flush mb-4">
       			<a href="myOrder.jsp" class="list-group-item list-group-item-action">- 주문목록</a>
       			<a href="myCancel.jsp" class="list-group-item list-group-item-action">- 취소 내역</a>
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
		<h3><strong class="mt-3">주문 취소 상세</strong></h3>
			<div class="card mt-3">
				<div class="card-body">
					<table class="order-complete table ">
						<colgroup>
							<col width="9%">
							<col width="15%">
							<col width="*">
							<col width="10%">		
							<col width="5%">
							<col width="9%">
					</colgroup>
					<thead>
						<tr class="border bg-light p-3">
							<th>주문번호</th>
							<th>날짜 </th>
							<th>상품명</th>
							<th>상품금액</th>
							<th>수량</th>
							<th>총금액</th>
						</tr>
					</thead>
					<tbody>
				<%	
					// 주문 상세정보 로직 설명
					// 주문 상세정보는 주문 후 상세정보 보기 or 나의 주문내역 확인하기 or 나의 최근 주문정보를 클릭해 볼 수 있다.
					// orderNo를 사용해 join 후 데이터를 조회하기에, 항상 value로 orderNo가 전달되어야 한다. -> 제일 먼저 생각해야 함.
					// getOrderItemsByOrderNo에 orderNo를 넣으면 해당 주문의 아이템 정보'들' 이 조회된다. 그래서 List로 받아야 한다. -> 갑자기 헷갈렸던 부분 ;;
					// dtos 안에는 해당 orderNo의 아이템 list가 들어있다. 하나씩 꺼내서 표 안에 넣자. 		 -> 끝!
					OrderDao orderDao = OrderDao.getInstance();
				
					int orderNo = StringUtil.stringToInt(request.getParameter("orderNo"));		
					List<OrderItemDto> dtos = orderDao.getOrderItemsByOrderNo(orderNo);
					Order order = orderDao.getOrderByOrderNo(orderNo);
					
					int totalPdsPrice = 0;				
					int totalDeliveryCharge = 0;
					
					for (OrderItemDto dto : dtos) {
						totalPdsPrice += dto.getSalePrice()*dto.getQuantity();
				%>
						<tr>
							<td class="align-middle"><%=dto.getOrderNo() %></td>
							<td class="align-middle"><%=dto.getCreatedDate() %></td>
							<td style="text-align:left">
								<a class="text-decoration-none" href="product/detail.jsp?pdNo=<%=dto.getPdNo()%>" >
									<img src="pdImages/pd_<%=dto.getPdNo()%>.jpg" style="width: 80px; height: 100px;"  />
								</a>							
								<a class="text-dark text-decoration-none" href="product/detail.jsp?pdNo=<%=dto.getPdNo() %>"><%=dto.getName() %></a>
							</td>
							<td class="align-middle"><%=StringUtil.numberToString(dto.getSalePrice()) %></td>
							<td class="align-middle"><%=StringUtil.numberToString(dto.getQuantity()) %></td>
							<td class="align-middle"><%=StringUtil.numberToString(dto.getTotalPrice()) %></td>
						</tr>
						
				<%	
						} 
					totalDeliveryCharge = totalPdsPrice > 30000 ? 0 : 3000;
				%>
						<tr>
							<td colspan="6" class="text-end">
								총 주문금액 <strong><%=StringUtil.numberToString(totalPdsPrice) %></strong>
								<img src="images/order_price_plus.png" alt="합계">
								택배비 <strong><%=StringUtil.numberToString(totalDeliveryCharge) %></strong>
								<img src="images/order_price_minus.png" alt="빼기">
								포인트 사용금액 <strong><%=StringUtil.numberToString(order.getUsedPoint()) %></strong> 
								<img src="images/order_price_total.png" alt="등호">
								결제금액 <strong><%=StringUtil.numberToString(order.getPaymentPrice()) %></strong>
							</td>
						</tr>
					</tbody>
				</table>
	    	</div>
	    </div>
	</div>
</div>
</form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>