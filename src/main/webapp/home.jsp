<%@page import="util.StringUtil"%>
<%@page import="vo.Product"%>
<%@page import="java.util.List"%>
<%@page import="dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap demo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
	#carouselExampleControls {padding: 40px;}
</style>
</head>
<body>
	<jsp:include page="common/nav.jsp">
		<jsp:param name="menu" value="home" />
	</jsp:include>
	<div class="container w-60 " >
		<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="images/homeSample1.jfif" class="d-block w-100" alt="...">
				</div>
				<div class="carousel-item">
					<img src="images/homeSample2.jfif" class="d-block w-100" alt="...">
				</div>
				<div class="carousel-item">
					<img src="images/homeSample3.jfif" class="d-block w-100" alt="...">
				</div>
			</div>
			<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
	</div>
	<div class="container-fluid bg-light mb-5" >
		<div class="container w-60">
			<div class="d-flex justify-content-center mt-3 mb-5">
				<h1 class="mt-5"><strong>우리 술이 처음인 당신을 위해</strong></h1>
			</div>
			<div class="row d-flex justify-content-between slides">
		<%
			ProductDao productDao = ProductDao.getInstance();
			List<Product> products = productDao.getPdByRecommend();
			
			for (Product product : products) {
		%>
				<div class="col-lg-3 col-md-6 mb-4 ">
					<div class="card h-100">
						<a href="product/detail.jsp?pdNo=<%=product.getNo()%>" class="text-dark text-decoration-none">
							<img class="card-img-top" src="pdImages/pd_<%=product.getNo()%>.jpg" alt="상품 준비중입니다." />
						</a>
						<div class="card-body">
						<a href="product/detail.jsp?pdNo=<%=product.getNo()%>" class="text-dark text-decoration-none">
							<p><%=product.getName() %></p>
						</a>
							<span><strong class=""><%=StringUtil.numberToString(product.getSalePrice()) %></strong>원 &nbsp;</span>
							<span class="mb-1"><del><small><%=StringUtil.numberToString(product.getPrice()) %></small></del>원</span>
						</div>
					</div>
				</div>
		<%
			}
		%>
			</div>
		</div>
	</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</html>