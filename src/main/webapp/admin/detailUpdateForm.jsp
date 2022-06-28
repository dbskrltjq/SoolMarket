<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="vo.Category"%>
<%@page import="java.util.List"%>
<%@page import="dao.CategoryDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>관리자 페이지</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
	<link href="css/styles.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
	html, body {
		height: 100%;
		}
	.container-fluid {
		height: 95%;
		border-collapse: collapse;
		}
</style>
</head>
<%
	//세션에서 로그인된 관리자정보를 조회한다.
	User admin = (User) session.getAttribute("ADMIN");
	if (admin == null) {
		throw new RuntimeException("해당 서비스는 관리자만 이용할 수 있습니다.");
	}  
	CategoryDao categoryDao = CategoryDao.getInstance();
	List<Category> categories = categoryDao.getCategories();
%>
<body>
<jsp:include page="admintop.jsp"></jsp:include>
	<div class="container mt-3 mb-5">
	<div class="row" id="detail-row">
		<div class="col-6">
			<div>
				<img alt="" src="../images/sample1.jpg" class="img-thumbnail" >
			</div>
		</div>
		<div class="col-6">
	<%
		//로그인된 유저 객체 확인
		User user = (User) session.getAttribute("LOGINED_USER");
		
		int productNo = Integer.parseInt(request.getParameter("pdNo"));
	
		ProductDao productDao = ProductDao.getInstance();
		Product product = productDao.getProductByNo(productNo);
		
		
		
		int totalpdPrice = 0;
	%>
			<h3 class="ps-2 fs-2"><%=product.getName() %></h3>
			<hr>
			<table class="table-boardless" id="product-table">
				<tbody>
					<tr>
						<th class="p-2">상품명</th>
						<td class="p-2"><%=product.getName() %></td>
					</tr>
					<tr>
						<th class="p-2">상품번호</th>
						<td class="p-2"><%=product.getNo() %></td>
					</tr>
					<tr>
						<th class="p-2">제조회사</th>
						<td class="p-2"><%=product.getCompany() %></td>
					</tr>
					<tr>
						<th class="p-2">정가</th>
						<td class="p-2 text-decoration-line-through"><%=product.getPrice() %>원</td>
					</tr>
					<tr>
						<th class="p-2">판매가</th>
						<td class="p-2"><span id="sale-price"><%=product.getSalePrice()%></span>원</td>
						<%--총상품금을 수량에 따라서 변경하기 위해 판매가에 id값을 붙인다. --%>
					</tr>
					<tr>
						<th class="p-2">수량</th>
						<td>
							<%-- productNo와 수량값을 전달해주기 위해 form을 만들고 id 값을 줍니다.
									*form은 티가 나지 않기 때문에 상품 설명란쪽에 넣어도 상관없습니다.
								form문안에 hidden으로 productNo을 뽑아낼 수 있는 input을 넣고
								고객이 입력한 상품 수량 값을 가져오는 quantity input을 넣습니다.--%>
							<form id="product-form">
							<input type="hidden" name="productNo" value="<%=product.getNo() %>" />
							<%--총상품금을 수량에 따라서 변경하기 위해 수량 input박스에 id값을 붙인다. --%>
							<input class=" p-2" name="quantity" type="number" min="1" max="100" id="product-quantity" value="1" onchange="updateTotalPrice()">
							</form>
						</td>
					</tr>
					<tr>
						<th class="p-2">총상품금액</th>
						<td class="p-2"><span id="total-price"><%=product.getSalePrice()%></span>원</td>
						<%--총상품금을 수량에 따라서 변경하기 위해 id값을 붙인다. --%>
					</tr>
					<tr>
				</tbody>
			</table>
			<hr />
			<%-- 버튼 형식으로 만들고 onclick기능을 넣어 클릭시 function-cart(),buy()가 실행되게 합니다. 비 로그인시 버튼이 활성화 되지 않게 했습니다. --%>
			<button type="button" onclick="cart()" class="btn btn-lg  <%=user == null ? "btn-outline-secondary disabled" : "btn-outline-primary" %>">장바구니</button>
			<button type="button" onclick="buy()" class="me-3 btn btn-lg  <%=user == null ? "btn-outline-secondary disabled" : "btn-outline-primary" %>">바로구매</button>
		</div>
	</div>
	
	<div class="row mt-5 mb-3 text-center">
		<div class="col-12">
			<nav class="nav nav-pills flex-column flex-sm-row  g-2">
			  <a class="border flex-sm-fill text-sm-center nav-link active rounded-0" aria-current="page" href="#detail-row">상세정보</a>
			  <a class="border flex-sm-fill text-sm-center nav-link rounded-0" href="#review-row">구매평</a>
			  <a class="border flex-sm-fill text-sm-center nav-link rounded-0" href="#qna-row">Q&A</a>
			</nav>
		</div>
	</div>

	<div class="row mb-3" id="review-row">
		<div class="col-12">
			<div class="card-body">
				<h3>구매평</h3>

				<form class="row g-3" method="post" action="reviewRegister.jsp" enctype="multipart/form-data">
					<input type="hidden" name="productNo" value="<%=product.getNo() %>" />
					
						<select class="form-select form-select-sm" name="reviewScore" aria-label=".form-select-sm example">
		  					<option selected>평점을 입력해주세요</option>
		 					<option value="5">★★★★★</option>
		 					<option value="4">★★★★</option>
		  					<option value="3">★★★</option>
		  					<option value="2">★★</option>
		  					<option value="1">★</option>
						</select>
					
					<div class="col-11">
						<textarea rows="2" class="form-control" name="reviewContent" placeholder="전통주와 함께한 좋은 기억을 다른 분들과 나눠주세요♥" onclick="reviewCheck(<%=product.getNo() %>);" ></textarea>
					</div>
					<div class="col-1">
						<button type="submit" name="reviewBotten" class="btn btn-outline-secondary w-100 h-100">리뷰등록</button>
					</div>
					<div class="form-label"></div>
					<input type=file class="form-control" name="reviewFileName" />
				</form>
			</div>
		</div>
	</div>
	
	<hr/>
	<div class="row mb-3" id="qna-row">
		<div class="col-12 d-flex justify-content-between">
			<h3>상품 Q&A</h3>
				
				<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#product-question-write" onclick="">
	 				 상품문의 글쓰기
				</button>
				
			<div>
				<a href="productQuestionForm.jsp?pdNo=<%=product.getNo() %>" class="btn btn-primary btn-sm  " >상품문의 글쓰기</a>
				<a href="productQuestionlist.jsp" class="btn btn-outline-secondary btn-sm  " >상품문의 전체보기</a>
			</div>
			
		</div>
	</div>
	
</div>
	
	

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>