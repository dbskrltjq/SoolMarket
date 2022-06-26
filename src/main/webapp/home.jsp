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
	<div class="container w-60" >
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
		<div class="container-fluid bg-light" >
			<div class="container w-60" style="border: solid;">
				<div class="d-flex justify-content-center">
					<h1><strong>모두가 좋아하는</strong> 우리술</h1>
				</div>
				<div class="row">
					<div class="col-lg-3 col-md-6 mb-4">
						<div class="card h-100">
							<a href="#!"><img class="card-img-top" src="https://via.placeholder.com/700x400" alt="..." /></a>
							<div class="card-body">
								<h4 class="card-title">
									<a href="#!">Item One</a>
								</h4>
								<h5>$24.99</h5>
								<p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet numquam aspernatur!</p>
							</div>
							<div class="card-footer">
								<small class="text-muted">★ ★ ★ ★ ☆</small>
							</div>
						</div>
					</div>
					<div class="col-lg-3 col-md-6 mb-4">
						<div class="card h-100">
							<a href="#!"><img class="card-img-top"
								src="https://via.placeholder.com/700x400" alt="..." /></a>
							<div class="card-body">
								<h4 class="card-title">
									<a href="#!">Item Two</a>
								</h4>
								<h5>$24.99</h5>
								<p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet numquam aspernatur! Lorem ipsum dolor sit amet.</p>
							</div>
							<div class="card-footer">
								<small class="text-muted">★ ★ ★ ★ ☆</small>
							</div>
						</div>
					</div>
					<div class="col-lg-3 col-md-6 mb-4">
						<div class="card h-100">
							<a href="#!"><img class="card-img-top" src="https://via.placeholder.com/700x400" alt="..." /></a>
							<div class="card-body">
								<h4 class="card-title">
									<a href="#!">Item Three</a>
								</h4>
								<h5>$24.99</h5>
								<p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet numquam aspernatur!</p>
							</div>
							<div class="card-footer">
								<small class="text-muted">★ ★ ★ ★ ☆</small>
							</div>
						</div>
					</div>
					<div class="col-lg-3 col-md-6 mb-4">
						<div class="card h-100">
							<a href="#!"><img class="card-img-top" src="https://via.placeholder.com/700x400" alt="..." /></a>
							<div class="card-body">
								<h4 class="card-title">
									<a href="#!">Item Four</a>
								</h4>
								<h5>$24.99</h5>
								<p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet numquam aspernatur!</p>
							</div>
							<div class="card-footer">
								<small class="text-muted">★ ★ ★ ★ ☆</small>
							</div>
						</div>
					</div>
					<div class="col-lg-3 col-md-6 mb-4">
						<div class="card h-100">
							<a href="#!"><img class="card-img-top" src="https://via.placeholder.com/700x400" alt="..." /></a>
							<div class="card-body">
								<h4 class="card-title">
									<a href="#!">Item Five</a>
								</h4>
								<h5>$24.99</h5>
								<p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet numquam aspernatur! Lorem ipsum dolor sit amet.</p>
							</div>
							<div class="card-footer">
								<small class="text-muted">★ ★ ★ ★ ☆</small>
							</div>
						</div>
					</div>
					<div class="col-lg-3 col-md-6 mb-4">
						<div class="card h-100">
							<a href="#!"><img class="card-img-top" src="https://via.placeholder.com/700x400" alt="..." /></a>
							<div class="card-body">
								<h4 class="card-title">
									<a href="#!">Item Six</a>
								</h4>
								<h5>$24.99</h5>
								<p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet numquam aspernatur!</p>
							</div>
							<div class="card-footer">
								<small class="text-muted">★ ★ ★ ★ ☆</small>
							</div>
						</div>
					</div>
				</div>
				<!--         새롭게 만나보는 우리 술                                      -->
				<div class="d-flex justify-content-center">
					<h1><strong>새롭게 만나보는</strong> 우리술</h1>
				</div>
		</div>
	</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</html>