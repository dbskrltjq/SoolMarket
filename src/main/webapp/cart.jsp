<%@page import="vo.User"%>
<%@page import="util.StringUtil"%>
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
	#cart-notice {
		color: #B8874D;
		color: #B8874D;
		font-size: 12px;
	}
</style>
</head>

<body>
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="cart"/>
</jsp:include>
<div class="container">   
	<div class="row mb-3">
		<div class="col">
		<!-- 로그인된 유저 정보 받아야 한다.
		로그인되지 않은 채로 카트에 접근하려 하면 deny를 반환하고 로그인창으로 이동시킨다. -->
		
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
				response.sendRedirect("../loginform.jsp?fail=deny"); 
				return;
			}
		%>
		
		<hr />
		
		<%
			CartItemDao cartItemDao = CartItemDao.getInstance();
			List<CartItemDto> cartItems = cartItemDao.getCartItemByUser(user.getNo());
			
			int totalPdsPrice = 0;				// 총상품금액(상품*수량*카트갯수)
			int totalDeliveryCharge = 0;		// 배송비(총상품금액 3만원 이상 ? 0원 : 3000원)
			int totalPdsPoint = 0;				// 총포인트
		%>
			<div id="orderStatus">
			<!-- 단계별로 font-color: skyblue, strong 효과가 들어가야 한다. -->
				<span>1. 장바구니 ></span>
				<span>2. 주문서작성/결제 ></span>
				<span>3. 주문완료</span>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col">
			<form id="cart-form" method="post">
			<!-- 여기서 온 거구나! -->
			<input type="hidden" name="from" value="cart" />
			<table class="cart-list table">
				<colgroup>
					<col width="3%">
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
						<th>
							<div class="form-element">
								<input type="checkbox" id="all-toggle-checkbox" onchange="toggleCheckbox(); cntAllCheckbox();" checked="checked"/>
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
							
							totalPdsPrice += item.getPdPrice() * item.getCartItemQuantity();
							totalPdsPoint += item.getPdEarnPoint();
							
							count++;
				%>
						<tr>
							<td class="align-middle">
								<input type="checkbox" 
									name="cartNo" 
									checked="checked" 
									value="<%=item.getCartNo()%>" 
									onchange="changeCheckboxChecked(); updateCartPrice();"/>
							</td>
							<td class="align-middle">
								<a class="text-dark text-decoration-none" href="detail.jsp?pdNo=<%=item.getPdNo()%>" >
									<strong><%=item.getPdName() %></strong>
								</a>
							</td>
							<td class="align-middle">
								<input class="w-50" 
									type="number" 
									min="1" max="100" 
									id="cartPdNum-<%=item.getCartNo()%>" 
									value="<%=item.getCartItemQuantity() %>">
								<button onclick="cartPdUpdown(<%=item.getCartNo()%>);" class="btn btn-outline-secondary btn-sm">확인</button>
							</td>
							<td class="align-middle">
								<strong class="text-danger"><%=StringUtil.numberToString(item.getPdPrice()) %> 원</strong>
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
					}
				%>

				</tbody>
			</table>
			</form>
		</div>
	</div>
	<div class="row mb-3"> <!-- 버튼이 위에 있을지 밑에 있을지 고민 중 -->
    	<div class="col-6">
			<button type="button" id="btn-order-choice-del" class="btn btn-outline-secondary btn-sm" onclick="cartPdDelete(); ">선택 상품 삭제</button>
      		<a href="https://soolmarket.com:443/goods/goods_list.php?cateCd=014001" id="shop-go-link" class="btn btn-outline-secondary btn-sm">쇼핑 계속하기</a>
    	</div>
		<div class="col-6 text-end">
            <button type="button" class="btn btn-primary btn-sm" onclick="orderSelectedCartItems()">선택 상품 주문</button>
            <button type="button" class="btn btn-primary btn-sm" onclick="orderAllCartItems()">전체 상품 주문</button>
       </div>
    </div>
    <div class="row mb-3 justify-content-end border">
    	<div class="col-5 p-3">
    		<table class="table table-borderless">
    			<tbody>
    				<tr>
    					<th class="text-end">총 <strong id="totalPdsCnt"><%=cartItems.size() %></strong>개의 상품금액</th>
    					<td rowspan="2" class="align-middle text-center"><img src="images/order_price_plus.png" alt="더하기"></td>
    					<th class="text-end">배송비</th>
    					<td rowspan="2" class="align-middle text-center"><img src="images/order_price_total.png" alt="합계"></td>
    					<th class="text-end">합계</th>
    				</tr>
    				<tr>
    					<td class="text-end"><strong id="totalPdsPrice"><%=StringUtil.numberToString(totalPdsPrice) %></strong>원</td>
    					<td class="text-end"><strong id="totalDeliveryCharge"><%=StringUtil.numberToString(totalDeliveryCharge) %></strong>원</td>
    					<td class="text-end"><strong id="totalCartPrice"><%=StringUtil.numberToString(totalPdsPrice + totalDeliveryCharge) %></strong>원</td>
    				</tr>
    				<tr>
    					<td colspan="5" class="text-end">
    						적립예정 포인트 : <span id="totalPdsMileage"><%=StringUtil.numberToString(totalPdsPoint) %></span> 원
    					</td>
    				</tr>
    			</tbody>
    		</table>
    	</div>
    </div>
   	<p class="text-end" id="cart-notice">* 주문서 작성단계에서 할인/마일리지 적용을 하실 수 있습니다.</p>
   	<!-- <a href="cartItemAdd.jsp?pdNo=101&quantity=5" id="shop-go-link" class="btn btn-outline-secondary btn-sm">상품 추가</a> -->
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

	// 선택 주문 함수
	function orderSelectedCartItems() {
		// input 중 name이 cartNo인 것 중 체크된 것의 길이를 변수에 담는다. 
		let checkedCheckboxCount = document.querySelectorAll('input[name="cartNo"]:checked').length;	
		// 위의 변수가 0일 경우, 체크된 것이 없으므로 '체크된 장바구니 아이템이 없다'는 알림을 띄우고 종료시킨다.
		if (checkedCheckboxCount === 0) {
			alert("체크된 장바구니 아이템이 없습니다.");
			return;
		}
		
		// 위의 변수가 0이 아니라면, cart-form id를 찾아 form에 대입한다.
		let form = document.getElementById("cart-form");
		// action은 submit할 곳이다. submit을 orderForm으로 하겠다.
		form.setAttribute("action", "orderForm.jsp");
		// submit한다.
		form.submit();
	}
	
	// 전체 주문 함수
	function orderAllCartItems() {
		let checkedCheckboxCount = document.querySelectorAll('input[name="cartNo"]:checked').length;	
		if (checkedCheckboxCount === 0) {
			alert("체크된 장바구니 아이템이 없습니다.");
			return;
		}
		
		// input 중 name이 cartNo인 것을 골라 변수에 넣는다.
		let cartCheckboxNodeList = document.querySelectorAll("input[name='cartNo']");
		// 위의 변수에는 input cartNo배열이 들어 있다. 
		// 배열 인덱스 < 배열 길이가 될 때까지 i번째 배열의 check값을 true로 바꾼다.
	    for (let index = 0; index < cartCheckboxNodeList.length; index++) {
	        let cartCheckbox = cartCheckboxNodeList[index];
	        cartCheckbox.checked = true;
	    }
	    // cart-form id를 찾아 form에 대입하고, submit 되는 곳을 orderForm.jsp로 바꾼다.
	    let form = document.getElementById("cart-form");
		form.setAttribute("action", "orderForm.jsp");
		form.submit();
	}
	
	// 장바구니 아이템 수량 변경할 때 사용하는 함수이다.
	function cartPdUpdown(cartNo) {
		// 카트 아이템 수량 변경하려 number 업다운 버튼 눌렀을 때 발생하는 함수이다.
		let quantity = document.getElementById("cartPdNum-" + cartNo).value;
		// 업다운 버튼이 있는 input에 id를 주고 그 값을 num에 넣었다.
		if (quantity >= 1 && quantity <= 100) {
			location.href="cartItemUpdateQuantity.jsp?cartNo="+cartNo + "&quantity=" + quantity; 
			return;		
		}
		
		if (quantity > 100 || quantity < 1) {
			alert("수량은 1개 이상 100개 이하 선택 가능합니다.");
			location.href="cartItemUpdateQuantity.jsp?cartNo="+cartNo + "&quantity=" + (quantity > 100 ? 100 : 1) ; 
			return;
		}
	}
	
	// 선택 삭제 함수
	function cartPdDelete() {
		//let deletePd = document.querySelectorAll('input[name="cartNo"]:checked');
		//console.log(deletePd);
		let checkedCheckboxCount = document.querySelectorAll('input[name="cartNo"]:checked').length;	
		if (checkedCheckboxCount === 0) {
			alert("체크된 장바구니 아이템이 없습니다.");
			return;
		}
		
		let form = document.getElementById("cart-form");
		form.setAttribute("action", "cartItemDelete.jsp");
		form.submit(); 
	}
	
	// 체크박스 상태 함수
	function changeCheckboxChecked() {
		
	    let checkboxCount = document.querySelectorAll('input[name="cartNo"]').length;
	    let checkedCheckboxCount = document.querySelectorAll('input[name="cartNo"]:checked').length;
	    // n개의 상품금액의 n을 담당한다.
	    document.getElementById("totalPdsCnt").textContent = document.querySelectorAll('input[name="cartNo"]:checked').length; 
	    document.getElementById("all-toggle-checkbox").checked = (checkboxCount === checkedCheckboxCount);
	    updateCartPrice();
	}
	
	// all-toggle-checkbox의 체크상태가 변경되면 input[name=book-checkbox]의 상태를 같이 변경한다.
	function toggleCheckbox() {
	    let allToggleChecboxCheckedStatus = document.getElementById("all-toggle-checkbox").checked;
	    let cartCheckboxNodeList = document.querySelectorAll("input[name='cartNo']");
	    for (let index = 0; index < cartCheckboxNodeList.length; index++) {
	        let cartCheckbox = cartCheckboxNodeList[index];
	        cartCheckbox.checked = allToggleChecboxCheckedStatus;
	    }
	    updateCartPrice();
	}
	
	// 맨 위 체크박스 체크상태에 따라 총 0개 혹은 length개의 상품금액이 나온다.
	function cntAllCheckbox() {
		if (document.getElementById("all-toggle-checkbox").checked) {
			document.getElementById("totalPdsCnt").textContent = document.querySelectorAll('input[name="cartNo"]').length;
		} else {
			document.getElementById("totalPdsCnt").textContent = 0;
		}
	}
	
	// 체크된 상품의 가격에 따라 총구매금액 / 배송비 / 포인트 바뀌게 할 것. 
	function updateCartPrice() {					
		let boxes = document.querySelectorAll("input[name=cartNo]:checked");	// 할 때마다 시행하니까 onchange() 안에 넣어 준다.
		let totalPrice = 0;
		let totalPoint = 0;
		
		for(let i = 0 ; i < boxes.length ; i ++ ) {							// 이대로 f12 콘솔에 치면 값이 그대로 나온다. (위에 변수 정의하고 해야 함)
			let checkbox = boxes[i]; 										// i번째 배열 값 꺼내기
			let no = checkbox.value;										// i번째 배열의 value는 cartNo이다. 여기선 10이라고 하자.
			let strong = document.getElementById("order-price-" + no);		// ex) order-price-10 과 같은 형식의 아이디를 꺼내 변수 strong으로 넣는다.
			let commaPrice = strong.textContent; 							// 변수 strong의 text를 꺼내 변수에 넣는다. 20,000 과 같은 형태이다.
			let text = commaPrice.replaceAll(",", "");						// 20,000 -> 20000과 같은 형태로 바꾼다. (int로 바꾸기 위함)
			let price = parseInt(text);										// 위의 값을 int 형식으로 바꾼다. (왜냐면 string 타입이었음)
			totalPrice += price;											// 체크된 가격들을 totalPrice 변수에 넣는다.
			
			let strongPoint = document.getElementById("order-point-" + no);		
			let commaPoint = strongPoint.textContent; 							
			let textPoint = commaPoint.replaceAll(",", "");						
			let point = parseInt(textPoint);										
			totalPoint += point; 
			
		}	
			let deliveryPrice = 3000;											// 기본 배달료 : 3000원
			if (totalPrice > 30000) {											// 총주문액이 30000원 이상이라면
				deliveryPrice = 0;												// 무료배송 해드립니다!
		}
		
		// 세 자리마다 , 붙이는 형식으로 바꾸어 total ~ 에 대입한다.
		document.getElementById("totalPdsPrice").textContent = new Number(totalPrice).toLocaleString();						// 단순 총가격
		document.getElementById("totalDeliveryCharge").textContent = new Number(deliveryPrice).toLocaleString();			// 배달료
		document.getElementById("totalCartPrice").textContent = new Number(totalPrice + deliveryPrice).toLocaleString();	// 배달료 합한 총가격
		document.getElementById("totalPdsMileage").textContent = new Number(totalPoint).toLocaleString();					// 총포인트
	}


</script>
</body>
</html>