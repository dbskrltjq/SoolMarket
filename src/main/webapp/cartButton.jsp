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
<div class="container">
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
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>