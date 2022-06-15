<%@page import="dto.CartItemDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.CartItemDao"%>
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

</style>
</head>

<body>
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="cart"/>
</jsp:include>
<div class="container">   
	<div class="row">
		<div class="col">
		<!-- 로그인된 유저 정보 받아야 한다.
		로그인되지 않은 채로 카트에 접근하려 하면 deny를 반환하고 로그인창으로 이동시킨다. -->
		<br />
		<hr />
		<%
			CartItemDao cartItemDao = CartItemDao.getInstance();
			List<CartItemDto> cartItems = cartItemDao.getCartItemByUser(1);
		%>
			<div id="orderStatus">
			<!-- 단계별로 font-color: skyblue, strong 효과가 들어가야 한다. -->
				<span>1. 장바구니 ></span>
				<span>2. 주문서작성/결제 ></span>
				<span>3. 주문완료</span>
			</div>

			<table class="cart-list">
				<colgroup>
					<col width="3%">
					<col>
					<col width="5%">
					<col width="10%">
					<col width="13%">
					<col width="10%">
					<col width="10%">
				</colgroup>
				<thead>
					<tr class="border bg-light p-3" >
						<th>
							<div class="form-element">
								<input type="checkbox" id="allCheck1" checked="checked"/>
								<label for="allCheck1"></label>
							</div>
						</th>
						<th>상품/옵션정보</th>
						<th>수량</th>
						<th>상품금액</th>
						<th>할인/적립</th>
						<th>합계금액</th>
						<th>배송비</th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
				<%
					if(cartItems.isEmpty()) {
				%>
						<tr>
							<td colspan="6" class="text-center"><strong>장바구니가 비어있습니다.</strong></td>
						</tr>
				<%
					} else {
						int count = 0;
						for(CartItemDto item : cartItems) {
							count++;
				%>
						<tr>
							<td><input type="checkbox" /></td>
							<td><a href="detail.jsp?pdNo=<%=item.getPdNo()%>"><strong><%=item.getPdName() %></strong></a></td>
							<td><strong><%=item.getCartItemQuantity() %>개</strong></td>
							<td><strong><%=item.getPdPrice() %>원</strong></td>
							<td>
								<em>적립 상품</em>
								<strong>+<%=item.getPdEarnPoint() %>원</strong>
							</td>
							<td><strong><%=item.getPdPrice() * item.getCartItemQuantity() %>원</strong></td> 
						<% 
							if (count == 1) {
						%>
							<td class="cart-delivary align-middle" rowspan="<%=cartItems.size() %>">
								기본 - 금액별 배송비 0원
								(택배-선결제)
							</td>
						<%
							}
						%>
						</tr>
				<%
						}
					}
				%>

				</tbody>
			</table>
			<div class="btn_left_box">
                <a href="https://soolmarket.com:443/goods/goods_list.php?cateCd=014001" class="shop_go_link"><em>&lt; 쇼핑 계속하기</em></a>
            </div>
			<p>총 <strong id="totalItemsCnt"> 3</strong>개의 상품금액 <strong id="totalItemsPrice">53,000</strong>원</p>
			<span class="btn_left_box">
                    <button type="button" class="btn_order_choice_del" onclick="gd_cart_process('cartDelete');">선택 상품 삭제</button>
            </span>
			<span class="btn_right_box">
                    <button type="button" class="btn_order_choice_buy" onclick="gd_cart_process('orderSelect');">선택 상품 주문</button>
                    <button type="button" class="btn_order_whole_buy" onclick="gd_order_all();">전체 상품 주문</button>
            </span>
            <div><em class="chk_none">주문서 작성단계에서 할인/마일리지 적용을 하실 수 있습니다.</em></div>
		</div>
	</div>
		
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>