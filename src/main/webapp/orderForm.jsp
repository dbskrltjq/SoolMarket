<%@page import="java.util.ArrayList"%>
<%@page import="util.StringUtil"%>
<%@page import="java.util.List"%>
<%@page import="dto.CartItemDto"%>
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
<style type="text/css">
	.red {color: red;}
	textarea { resize: none;}
    th { background-color: bg-light; }
</style>
</head>
<body>
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="orderForm"/>
</jsp:include>
<div class="container">
	<!-- 주문한 상품 목록 -->
	<div class="row">
		<div class="col">
		<%
			// 선택 주문 / 전체 주문 전부 가능한 로직
			CartItemDao cartItemDao = CartItemDao.getInstance();		
			String[] values = request.getParameterValues("cartNo");		// cartNo를 받아서 String 배열인 value에 넣는다.
			
			List<CartItemDto> cartItems = new ArrayList<>();			// CartItemDto 데이터타입의 arrayList를 하나 만든다.
			for (String value : values) {	
				// value를 int로 형변환해서 cartNo메소드에 넣는다. 그 결과를 CartItemDto 타입의 dto에 넣는다. 해당 카트번호의 정보가 dto안으로 들어간다.
				CartItemDto dto = cartItemDao.getCartItemByCartNo(StringUtil.stringToInt(value));	
				// cartItems 배열에 dto를 더한다.
				cartItems.add(dto);
			}
			
			int totalPdsPrice = 0;				// 총상품금액(상품*수량*카트갯수)
			int totalDeliveryCharge = 0;		// 배송비(총상품금액 3만원 이상 ? 0원 : 3000원)
			int totalPdsPoint = 0;				// 총포인트
		%>
			
			<form method="post" action="" onsubmit="">
			<table class="order-list table">
				<colgroup>
					<!-- 사진 파일 넣어야 한다. 클릭하면 datail.jsp로 이동해야 한다. -->
					<col width="*">
					<col width="13%">
					<col width="10%">
					<col width="13%">
					<col width="10%">
					<col width="10%">
				</colgroup>
				<thead>
					<tr class="border bg-light p-3" >
						<th>상품/옵션정보</th>
						<th>수량</th>
						<th>상품금액</th>
						<th>할인/적립</th>
						<th>합계금액</th>
						<th>배송비</th>
					</tr>
				</thead>				
				<%
					int count = 0;
						for(CartItemDto item : cartItems) {
							
						totalPdsPrice += item.getPdPrice() * item.getCartItemQuantity();
						totalPdsPoint += item.getPdEarnPoint();
							
						count++;
				%>
						<tr>
							<td class="align-middle">
								<input type="hidden" name="cartNo" value="<%=item.getCartNo()%>"/>
								<a class="text-dark text-decoration-none" href="detail.jsp?pdNo=<%=item.getPdNo()%>" >
									<strong><%=item.getPdName() %></strong>
								</a>
							</td>
							<td class="align-middle">
								<!-- 이 quantity는 ... hidden으로 하면 보이지 않아요 ... 해결책을 강구합시다 ...  -->
								<input type=text class="w-25" name="quantity" value="<%=item.getCartItemQuantity() %>" disabled />
							</td>
							<td class="align-middle">
								<strong><%=StringUtil.numberToString(item.getPdPrice()) %> 원</strong>
							</td>
							<td class="align-middle">
								<em>적립 </em>
								<strong id="order-point-<%=item.getCartNo()%>">+<%=StringUtil.numberToString(item.getPdEarnPoint()) %> 원</strong>
							</td>
							<td class="align-middle">
								<span><strong class="text-danger" id="order-price-<%=item.getCartNo()%>"><%=StringUtil.numberToString(item.getPdPrice() * item.getCartItemQuantity()) %></strong> 원</span>
							</td> 
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
				%>

				</tbody>
			</table>
			</form>
		</div>
	</div>
				
		<!-- 주문자 정보 (로그인한 유저와 동일) -->
		<h4 class="mt-5">주문자 정보</h4>
		<table class="table mb-5">
			<tbody>
				<tr>
					<th class="bg-light">주문하시는 분</th>
					<td><input type="text" value="김민지" disabled /></td>
				</tr>
				<tr>
					<th class="bg-light">주소</th>
					<td><input type="text" value="[53053] 경상남도 통영시 강구안길 29-1(충청도 회초장) 1층 304호" disabled /></td>
				</tr>
				<tr>
					<th class="bg-light">휴대폰 번호</th>
					<td><input type="text" value="010-1111-1111" disabled /></td>
				</tr>
				<tr>
					<th class="bg-light">이메일</th>
					<td><input type="text" value="aaa123@gmail.com" disabled /></td>
				</tr>
			</tbody>
		</table>
	
		<!-- 배송 정보 (입력 가능) -->
		<h4>배송정보</h4>
		<table class="table mb-5 ">
			<tbody>
				<tr>
					<th>배송지 확인</th>
					<td><input type="radio" name="order-receive-select" value="order-receive-user" checked /> 주문자와 동일</td>
					<td><input type="radio" name="order-receive-select" value="order-receive-input" /> 직접 입력</td>
				</tr>
				<tr>
					<th><span class="red">*</span> 받으실 분</th>
					<td><input type="text" value="김민지" /></td>
				</tr>
				<tr>
					<th><span class="red">*</span> 받으실 곳</th>
					<td>
						<input type="text" name="postcode" id="postcode" placeholder="우편번호">
						<input type="button" onclick="findAddr()" value="우편번호 찾기"><br>
						<input type="text" name="addr" id="addr" placeholder="주소"><br>
						<input type="text" name="detailAddr" id="detailAddr" placeholder="상세주소">	
						<input type="text" name="extraAddr" id="extraAddr" placeholder="참고항목">
					</td>
				</tr>
				<tr>
					<th><span class="red">*</span> 휴대폰 번호</th>
					<td><input type="text" value="010-1111-1111" /></td>
				</tr>
				<tr>
					<th>남기실 말씀</th>
					<td><textarea name="memo" rows="1" cols="50" placeholder="요청사항을 입력해 주세요. (최대 30자)" value=""></textarea></td>
				</tr>
			</tbody>
		</table>
		
		<!-- 국세청 필수 체크사항 -->
		<table class="table mb-5 ">
			<tbody>
				<tr>
					<span class="red">* 필수</span> 국세청 고시에 따른 분기별 명세 세무서 정보제공
				</tr>
				<td>
					<label class="form-label">
						<input type="checkbox" class="" name="mustCheckBox" value="mustCheck1" onkeyup=""/> 동의합니다.
					</label>
				</td>
			</tbody>
		</table>
		
		<!-- 결제정보 총총합계금액, 배송비, 포인트, 포인트 사용[ ---원 ] ㅁ 전액사용하기, 최종결제금액 nn원-->
		<h4>배송 정보</h4>
		<table class="table mb-5">
			<tbody>
				<tr>
					<th>상품합계금액</th>
					<td>750,305원</td>
				</tr>		
				<tr>
					<th>배송비</th>
					<td>0원</td>
				</tr>		
				<tr>
					<th>할인 및 적립</th>
					<td>750,305원</td>
				</tr>		
				<tr>
					<th>포인트 사용</th>
					<td>
						<span>[ ] 원</span>
						<span>전액 사용하기</span>
						<span>보유 포인트 : 0원</span></td>
				</tr>		
				<tr>
					<th>최종결제금액</th>
					<td>750,305원</td>
				</tr>		
			</tbody>
		</table>
	
	
		<!-- 결제수단 선택, 결제 : 일반결제 - 신용카드, 계좌이체, 가상계좌만 -->
		<h4>결제수단 선택 / 결제</h4>
		<table class="table mb-5">
			<tbody>
				<tr>
					<th>일반결제</th>
					<td>
						<input type="radio" name="order-receive-select" value="order-pay-credit" checked /> 신용카드
						<input type="radio" name="order-receive-select" value="order-pay-bank" /> 계좌이체
						<input type="radio" name="order-receive-select" value="order-pay-virtual" /> 가상계좌
					</td>
				</tr>
			</tbody>
		</table>
		
		<!-- 최종결제금액 -->
		<table class="table mb-5">
			<tbody>
				<tr>
					<th>최종 결제 금액</th>
					<td>740,305원</td>
				</tr>
			</tbody>
		</table>
		
		<!-- 필수 체크사항 -->
		<input class="mb-5" type="checkbox" name="mustCheckBox" value="mustCheck2" /> 
			(필수) 구매하실 상품의 결제정보를 확인하였으며, 구매진행에 동의합니다.
		
		<!-- 결제하기 버튼 -->	
		<div class="mb-5">
			<a href="home.jsp" class="btn btn-light btn-outline-dark">취소</a>
			<button type="" class="btn btn-primary">결제하기</button>	
		</div>	
	</form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>