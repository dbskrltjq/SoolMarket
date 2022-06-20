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
   <!-- 여기의 userNo는 session에서 가지고 와야 한다. -->
      	<a href="cartItemAdd.jsp?userNo=6&pdNo=101&quantity=5" 
	      	id="cart-go-link" 
	      	class="btn btn-outline-secondary btn-sm">상품 추가
      	</a>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>