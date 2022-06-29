<%@page import="dao.UserDao"%>
<%@page import="vo.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="util.StringUtil"%>
<%@page import="java.util.List"%>
<%@page import="dto.CartItemDto"%>
<%@page import="dao.CartItemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error/500.jsp"  %>
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
    
    #total-order-charge2 { 
    		color: #189FD8; 
    		font-size: 35px; 
    		font-weight: bold; 
    		vertical-align: sub;
    		}
    		
    #Stotal-order-charge2 {
    		color: #189FD8; 
    		font-size: 20px; 
    		font-weight: bold; 
    		vertical-align: sub;
    		}
    		
    #total-order-text { 
    		font-size: 22px; 
    		font-weight: bold; 
    		vertical-align: sub;
    		}
</style>
</head>
<body>
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="orderForm"/>
</jsp:include>
<div class="container">
<form id="cart-form" method="post">
	<!-- 주문한 상품 목록 -->
	<div class="row">
		<div class="col">
		
		<!--
			로그인된 유저 정보 받아야 한다.
			로그인되지 않은 채로 카트에 접근하려 하면 deny를 반환하고 로그인창으로 이동시킨다. 
		-->
	
		<% 	
			User user = (User) session.getAttribute("LOGINED_USER");
			if (user==null) {
				response.sendRedirect("loginform.jsp?fail=deny"); 
				return;
			}
		%>
		
		<!-- 주문상세내역 -->
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
		
			<h2 class="mt-5 mb-3"><strong>주문서 작성/결제</strong></h2>
			<hr />
			<!-- form 시작!! -->
			<input type="hidden" name="from" value="cart" />
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
								<input type="hidden" name="pdNo" value="<%=item.getPdNo()%>"/>	<!-- hidden!! 잘 사용하자!!! -->
								<a class="text-decoration-none" href="product/detail.jsp?pdNo=<%=item.getPdNo()%>" >
									<img src="pdImages/pd_<%=item.getPdNo()%>.jpg" style="width: 80px; height: 100px;"  />
								</a>							
								<a class="text-dark text-decoration-none" href="product/detail.jsp?pdNo=<%=item.getPdNo()%>" >
									<strong><%=item.getPdName() %></strong>
								</a>
							</td>
							<td class="align-middle">
								<input type=text class="w-25" name="quantity" value="<%=item.getCartItemQuantity() %>" readonly />
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
						
						totalDeliveryCharge = totalPdsPrice > 30000 ? 0 : 3000;
				%>

				</tbody>
			</table>
		</div>
	</div>
	
	<!-- 주문상세내역 하단 -->
	<div class="row mb-3 justify-content-end border">
    	<div class="col-5 p-3">
    		<table class="table table-borderless">
    			<tbody>
    				<tr>
    					<th class="text-end">
    						총 <strong id="total-pds-cnt"><%=cartItems.size() %></strong>개의 상품금액
    						<input type="hidden" name="totalQuantity" value="<%=cartItems.size() %>">
    					</th>
    					<td rowspan="2" class="align-middle text-center"><img src="images/order_price_plus.png" alt="더하기"></td>
    					<th class="text-end">배송비</th>
    					<td rowspan="2" class="align-middle text-center"><img src="images/order_price_total.png" alt="합계"></td>
    					<th class="text-end">합계</th>
    				</tr>
    				<tr>
    					<td class="text-end"><strong id="total-pds-price"><%=StringUtil.numberToString(totalPdsPrice) %></strong>원</td>
    					<td class="text-end"><strong id="total-delivery-charge"><%=StringUtil.numberToString(totalDeliveryCharge) %></strong>원</td>
    					<td class="text-end"><strong id="total-cart-price"><%=StringUtil.numberToString(totalPdsPrice + totalDeliveryCharge) %></strong>원</td>
    				</tr>
    				<tr>
    					<td colspan="5" class="text-end">
    						적립예정 포인트 : <span id="total-pds-point"><%=StringUtil.numberToString(totalPdsPoint) %></span> 원
    					</td>
    				</tr>
    			</tbody>
    		</table>
    	</div>
    </div>
				
		<!-- 주문자 정보 (로그인한 유저와 동일) -->
		<h4 class="mt-5 mb-3"><strong>주문자 정보</strong></h4>
		<table class="table mb-5">
			<tbody>
				<tr>
					<th class="bg-light">주문하시는 분</th>
					<td><input type="text" value="<%=user.getName() %>" id="order-user-name" readonly /></td>
				</tr>
				<tr>
					<th class="bg-light">주소</th>
					<td>
						<input type="text" value="<%=user.getPostCode() %>" class="w-25" id="order-postcode" readonly />
						<input type="text" value="<%=user.getAddress() %>" class="w-50" id="order-addr" readonly />
						<input type="text" value="<%=user.getDetailAddress() %>" class="w-75" id="order-detaile-addr" readonly />
					</td>
				</tr>
				<tr>
					<th class="bg-light">휴대폰 번호</th>
					<td><input type="text" value="<%=user.getTel() %>" id="order-tel" readonly /></td>
				</tr>
				<tr>
					<th class="bg-light">이메일</th>
					<td><input type="text" value="<%=user.getEmail() %>" id="order-email" readonly /></td>
				</tr>
			</tbody>
		</table>
	
		<!-- 배송 정보 (입력 가능) -->
		<h4 class="mt-5 mb-3"><strong>배송정보</strong></h4>
		<table class="table mb-5 ">
			<tbody class="orderReceiveForm ">
				<tr>
					<!-- 기본 체크된 것은 주문자와 동일. 주문자의 정보가 들어간다.
						 직접입력을 누를 경우, 배송정보 form이 모두 초기화된다. 
						 value 사용하기!!! 주문자와 동일한 경우는 위 order-n value 뽑아서 넣자.
						 직접 입력이면 "" <-- 이거 넣으면 빈칸 되니까 ... 이거 넣기 ... reset은 안 쓰는구만
					-->
					<th class="bg-light">배송지 확인</th>
					<td>
						<span><input type="radio" name="orderReceiveSelect" id="receive-place-same" value="order-receive-user" onchange="orderReceiveFormSame();" checked /> 주문자와 동일 &nbsp; &nbsp; </span>
						<span><input type="radio" name="orderReceiveSelect" id="receive-place-input" value="order-receive-input" onchange="orderReceiveFormInput();" /> 직접 입력</span>
					</td>
				</tr>
				<tr>
					<th class="bg-light"><span class="red">*</span> 받으실 분</th>
					<td><input class="receiveForm" type="text" name="receiveName" value="<%=user.getName() %>" id="receive-name" readonly/></td>
				</tr>
				<tr>
					<th class="bg-light"><span class="red">*</span> 주소</th>
						<td class="d-grid gap-3">
							<div class="w-75">
								<input type="text" class="receiveForm" name="receivePostcode" id="receive-postcode" value="<%=user.getPostCode() %>" readonly >
								<button type="button" disabled="disabled" id="post-code-button" class="btn btn-outline-secondary btn-sm" onclick="findAddr();" >우편번호 찾기</button>
							</div> 
							<input type="text" class="receiveForm" name="receiveAddress" id="receive-addr" value="<%=user.getAddress() %>" readonly />
							<input type="text" class="receiveForm" name="receiveDetailAddress" id="receive-detail-addr" value="<%=user.getDetailAddress() %>" readonly />
						</td>
				</tr>
				<tr>
					<th class="bg-light"><span class="red">*</span> 휴대폰 번호</th>
					<td><input type="text" name="receiveTel" class="receiveForm" value="<%=user.getTel() %>" id="receive-tel" readonly /></td>
				</tr>
				<tr>
					<th class="bg-light">남기실 말씀</th>
					<td>
						<textarea name="deliveryMemo" id="delivery-memo" rows="1" cols="50" maxlength='30' 
						placeholder="요청사항을 입력해 주세요. (최대 30자)" onkeyup="deliveryMemoLimit();"></textarea>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- 국세청 필수 체크사항 -->
		<table class="table mb-5 ">
			<tbody>
				<tr>
					<td><span class="red">* 필수</span> 국세청 고시에 따른 분기별 명세 세무서 정보제공 &nbsp; &nbsp; &nbsp;
						<span><label class="form-label">
							<input type="checkbox" name="mustCheckBox" value="mustCheck1" /> 동의합니다.
						</label></span>
					</td>
				</tr>
			</tbody>
		</table>
		
		<!-- 결제정보 총총합계금액, 배송비, 포인트, 포인트 사용[ ---원 ] ㅁ 전액사용하기, 최종결제금액 nn원-->
		<h4 class="mt-5 mb-3"><strong>배송 정보</strong></h4>
		<table class="table mb-5">
			<tbody>
				<tr>
					<th class="bg-light">상품합계금액</th>
					<td>
						<strong id="total-cart-price"><%=StringUtil.numberToString(totalPdsPrice + totalDeliveryCharge) %></strong>원
						<input type="hidden" name="totalPrice" value="<%=StringUtil.numberToString(totalPdsPrice + totalDeliveryCharge) %>"/>
					</td>
				</tr>		
				<tr>
					<th class="bg-light">배송비</th>
					<td><strong id="total-delivery-charge"><%=StringUtil.numberToString(totalDeliveryCharge) %></strong>원</td>
				</tr>		
				<tr>
					<th class="bg-light">포인트 적립</th>
					<td>
						<strong id="total-pds-point"><%=StringUtil.numberToString(totalPdsPoint) %></strong>
						<input type="hidden" name="depositPoint" value="<%=StringUtil.numberToString(totalPdsPoint) %>"/>					
					</td>
				</tr>		
				<tr>
					<th class="bg-light">포인트 사용</th>
					<td>
						<span>
							<input type="number" min="0" max="<%=user.getPoint() %>" id="order-use-point" value="0" name="usedPoint" 
								onkeyup="totalPriceChange();" 
								onclick="totalPriceChange();"
								onchange="totalPriceChange();" />
						</span>
						<small>
							<span><input type="checkbox" id="order-point-checkbox" onchange="useAllPoint();" />전액 사용하기</span>
							<span>(보유 포인트 : 
								<strong id="user-point">
								<%
									UserDao userDao = UserDao.getInstance();
									user = userDao.getUserByNo(user.getNo());
								%>
								<%= 
									StringUtil.numberToString(user.getPoint())
								%>
								</strong>원)
							</span>
						</small>
					</td>
				</tr>		
				<tr>
					<th class="bg-light">최종결제금액</th>
					<td>
						<strong id="total-order-charge"><%=StringUtil.numberToString(totalPdsPrice + totalDeliveryCharge) %></strong>원
						<input type="hidden" name="paymentPrice" id="h-paymentPrice" value="<%=StringUtil.numberToString(totalPdsPrice + totalDeliveryCharge) %>"/>				
					</td>	
				</tr>		
			</tbody>
		</table>
	
	
		<!-- 결제수단 선택, 결제 : 일반결제 - 신용카드, 계좌이체, 가상계좌만 -->
		<h4 class="mt-5 mb-3"><strong>결제수단 선택 / 결제</strong></h4>
		<table class="table mb-5">
			<tbody>
				<tr>
					<th class="bg-light">일반결제</th>
					<td>
						<input type="radio" name="payment" value="신용카드" checked /> 신용카드
						<input type="radio" name="payment" value="계좌이체" /> 계좌이체
						<input type="radio" name="payment" value="가상계좌" /> 가상계좌
					</td>
				</tr>
			</tbody>
		</table>
		
		<!-- 최종결제금액 -->
		<div class="row mb-3 justify-content-end border">
	    	<div class="col p-3">
		    	<table class="table table-borderless ">
	    			<tbody>
	    				<tr>
							<td class="text-end">
								<span id="total-order-text">최종결제금액 &nbsp;</span>
								<span id="total-order-charge2"><%=StringUtil.numberToString(totalPdsPrice + totalDeliveryCharge) %></span>
								<span id="Stotal-order-charge2">원</span>
							</td>
	    				</tr>
	    			</tbody>
	    		</table>
	    	</div>
		</div>
</form>
<!-- form 끝!!! -->
<!-- 필수 체크사항, 결제하기 버튼 -->	
		<div class="row mb-5 justify-content-end">
	    	<div class="col p-3">
		    	<table class="table table-borderless">
	    			<tbody>
	    				<tr>
	    					<th class="text-center">
								<input class="mb-3" type="checkbox" name="mustCheckBox" value="mustCheck2" /> 
								<span class="red"> (필수)</span> 구매하실 상품의 결제정보를 확인하였으며, 구매진행에 동의합니다.
	    					</th>
	    				</tr>
	    				<tr>
	    					<th class="text-center">
	    						<a href="home.jsp" class="btn btn-light btn-outline-dark">취소</a>
								<button type="button" class="btn btn-primary" onclick="checkedOrderForm();">결제하기</button>	 
	    					</th>
	    				</tr>
	    			</tbody>
	    		</table>
	    	</div>
		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

	// 체크박스를 체크하면 모든 포인트를 사용한다.
	function useAllPoint() {
		// 로직 : 해당 아이디의 체크박스 선택 -> 체크되었는지 확인 -> 만약 체크되었다면 int로 형변환한 포인트를 number의 value에 넣는다.
		// 	     넣은 다음, StringUtil을 사용해 다시 ,을 붙여준다.
		//		 이 함수는 체크박스의 상태가 바뀔 때마다 시행된다.
		if (document.getElementById("order-point-checkbox").checked) {
			let strong = document.getElementById("user-point");			// <strong id="userPoint">0</strong>
			let commaPrice = strong.textContent;						// 2,000 (예시)
			let pointText = commaPrice.replaceAll(",", "");				// 2,000 -> 2000
			let point = parseInt(pointText);							// int로 형변환
			
			let cartStrong = document.getElementById("total-cart-price");			//<strong id="totalCartPrice">14,170</strong>
			let commaCartPrice = strong.textContent;							// '14,170'
			let totalCartText = commaPrice.replaceAll(",", "");				// '14170'
			let price = parseInt(totalCartText);							// 14170
			
				if (point > price) {
					point = price;
				}
			
			document.getElementById("order-use-point").value = point;		// 다시 2000으로 변경된다. number라서 Locale 그거 안 해도 된다.
		
		} else {
			document.getElementById("order-use-point").value = 0;
		}
		
		totalPriceChange();
		
	}
	
	// 포인트가 바뀌면 최종결제금액이 바뀌는 함수이다.
	function totalPriceChange() {
		let strong = document.getElementById("total-cart-price");		//<strong id="totalCartPrice">14,170</strong>
		let commaPrice = strong.textContent;							// '14,170'
		let totalCartText = commaPrice.replaceAll(",", "");				// '14170'
		let price = parseInt(totalCartText);							//  14170
		
		let strongP = document.getElementById("user-point");			// 유저 포인트 가져오는 변수이다.
		let commaPriceP = strongP.textContent;							
		let pointTextP = commaPriceP.replaceAll(",", "");				
		let point = parseInt(pointTextP);							
		
			if (document.getElementById("order-use-point").value < 0) {
				alert("0포인트부터 사용 가능합니다.");
				document.getElementById("order-use-point").value = 0;
			} else if (document.getElementById("order-use-point").value > point) {
				alert("포인트 사용액은 소유한 포인트량을 넘을 수 없습니다.");
				document.getElementById("order-use-point").value = point;
			} else if (document.getElementById("order-use-point").value > price) {
				alert("포인트 사용액은 결제금액을 넘을 수 없습니다.");
				document.getElementById("order-use-point").value = price;
			}
		
		let totalPrice = price - document.getElementById("order-use-point").value;	// 가격 - 14170
		
		document.getElementById("total-order-charge").textContent = new Number(totalPrice).toLocaleString();	// nn,nnn
		document.getElementById("total-order-charge2").textContent = new Number(totalPrice).toLocaleString();	// nn,nnn
		
		document.getElementById("h-paymentPrice").value = document.getElementById("total-order-charge").textContent;
	}

	// 만약 주문자와 동일을 선택한다면 주문자 정보의 value를 들고 와서 넣으면 된다.
	function orderReceiveFormSame() {

		document.querySelector('input[id="receive-name"]').value  = document.querySelector('input[id="order-user-name"]').value;
		document.querySelector('input[id="receive-addr"]').value = document.querySelector('input[id="order-addr"]').value;
		document.querySelector('input[id="receive-detail-addr"]').value = document.querySelector('input[id="order-detaile-addr"]').value;
		document.querySelector('input[id="receive-tel"]').value = document.querySelector('input[id="order-tel"]').value;
		document.querySelector('input[id="receive-postcode"]').value = document.querySelector('input[id="order-postcode"]').value;
		
		document.querySelector('input[id="receive-name"]').readOnly = true;
		document.querySelector('input[id="receive-addr"]').readOnly = true;
		document.querySelector('input[id="receive-detail-addr"]').readOnly = true;
		document.querySelector('input[id="receive-postcode"]').readOnly = true;
		document.querySelector('input[id="receive-tel"]').readOnly = true;
		document.querySelector('#post-code-button').disabled = true;
		
		}
	
	// 배송지정보 직접 입력 선택하면 폼 지워진다.
	function orderReceiveFormInput() {
		
		document.querySelector('input[id="receive-name"]').value = '';
		document.querySelector('input[id="receive-addr"]').value = '';
		document.querySelector('input[id="receive-detail-addr"]').value= '';
		document.querySelector('input[id="receive-tel"]').value = '';
		document.querySelector('input[id="receive-postcode"]').value = '';
		
		document.querySelector('input[id="receive-name"]').readOnly = false;
		document.querySelector('input[id="receive-addr"]').readOnly = true;
		document.querySelector('input[id="receive-detail-addr"]').readOnly = false;
		document.querySelector('input[id="receive-postcode"]').readOnly = true;
		document.querySelector('input[id="receive-tel"]').readOnly = false;
		document.querySelector('#post-code-button').disabled = false;
		}

	
	// 배송정보 직접 입력 선택 시, *표에 빈칸이 있다면 주문으로 넘어가지 못하게 한다.
	// 필수 체크박스 체크 안 하면 결제 못 하게 하는 함수
	// 원래 따로 있었으나, 이상하게 작동해서 한 함수 안에 넣어 -> 위에서 아래로 검사 검사 검사 하도록 만듬.
	function checkedOrderForm() {
		
		let nameField = document.querySelector("input[name=receiveName]");
		if (nameField.value.trim() === '') {
			alert("받으실 분 성함을 입력해 주세요.");
			nameField.focus();
			return;
		}

		let postcodeField = document.getElementById("receive-postcode");	// 천재같당 근데 왜 name 아니고 얘네만 id일까
		let addrField = document.getElementById("receive-addr");
		let detailAddrField = document.getElementById("receive-detail-addr");
		if (!postcodeField.value.trim() || !addrField.value.trim() || !detailAddrField.value.trim()) {
			alert("주소를 입력해주세요.");
			postcodeField.focus();
			return;
		}

		let telField = document.querySelector("input[name=receiveTel]");
		if (telField.value.trim() === '') {
			alert("전화번호를 입력해주세요.")
			telField.focus();
			return;
		}
		
		let checkedMustCheckboxCount = document.querySelectorAll('input[name="mustCheckBox"]:checked').length;	
		if (checkedMustCheckboxCount < 2) {
			alert("필수 체크박스에 모두 체크하셔야 구매하실 수 있습니다.");
			// 체크하지 않은 곳으로 보내는 법
			return;
		}
		
		let form = document.getElementById("cart-form");
		form.setAttribute("action", "order.jsp");
		form.submit(); 

	}
	
	// 배송메세지 최대 30자
	function deliveryMemoLimit() {	
		memo = document.getElementById("delivery-memo").value;
		memoLength = memo.length;
		if (memoLength > 30) {
			alert("배송메세지는 최대 30자까지만 작성 가능합니다.");
			return;
		}
	}
	
	// 다음api를 사용한 주소찾기 기능 구현 부분
	function findAddr() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}
					// 조합된 참고항목을 해당 필드에 넣는다.
					document.getElementById("receive-detail-addr").value = extraAddr;

				} else {
					document.getElementById("receive-detail-addr").value = '';
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('receive-postcode').value = data.zonecode;
				document.getElementById("receive-addr").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("receive-detail-addr").focus();
			}
		}).open();
	}
	

</script>
</body>
</html>