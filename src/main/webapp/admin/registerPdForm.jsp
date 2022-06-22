<%@page import="vo.Pagination"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="vo.Category"%>
<%@page import="java.util.List"%>
<%@page import="dao.CategoryDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp"%>
    
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
</head>
<%
	//세션에서 로그인된 관리자정보를 조회한다.
	User admin = (User) session.getAttribute("ADMIN");
	if (admin == null) {
		throw new RuntimeException("해당 서비스는 관리자만 이용할 수 있습니다.");
	}
	
	int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
	int rows = StringUtil.stringToInt(request.getParameter("rows"), 5);
	int totalRows = 0;    // 상황에 맞게 다시 수정하기
	Pagination pagination = new Pagination(rows, totalRows, currentPage);
	
	CategoryDao categoryDao = CategoryDao.getInstance();
	List<Category> categories = categoryDao.getCategories();
	
	ProductDao productDao = ProductDao.getInstance();
	List<Product> products = productDao.getAllProducts(pagination.getBeginIndex(), pagination.getEndIndex());
	
	
%>
<body>
<jsp:include page="admintop.jsp"></jsp:include>
	<div class="container-fluid ">
		<div class="row">
			<div class="col-2 p-0">
				<jsp:include page="adminleft.jsp"></jsp:include>
			</div>
			<div class="col-10">
				<div id="layoutSidenav_content">
					<main>
						<div class="container-fluid px-4">
							<h1 class="mt-4">신규상품등록</h1>

							<div class="card my-4 ">
								<div class="card-header">
									<i class="fas fa-table me-1"></i> 
									<strong class="me-3">신규 상품</strong>
									<button type="button" class="btn btn-primary" id="register-btn" data-bs-toggle="modal" data-bs-target="#registerModal">상품등록하기</button>
									<div class="form-div">
										<form id="register-form" class="row g-3" method="post" action="">
											<input type="hidden" name="page" /> <input type="hidden" name="search" value="" />
											<select class="form-select" name="category">
												<option disabled selected >카테고리 선택</option>
										<%
											for(Category category : categories) {
										%>	
												<option value="<%=category.getNo() %>"><%=category.getName() %></option>
										<%
											}
										%>
											</select>
											<select class="form-select form-select-sm">
												<option>1주</option>											
												<option>1개월</option>											
												<option>1년</option>											
											</select>
											<select class="form-select form-select-sm float-end" name="rows" onchange="changeRows();">
												<option value="5">5개씩 보기</option>
												<option value="10">10개씩 보기</option>
												<option value="15">15개씩 보기</option>
											</select>
										</form>
									</div>
								</div>
								<div class="card-body">
									<table class="table table-hover text-center"
										id="datatablesSimple">
										<colgroup>
											<col width="8%">
											<col width="15%">
											<col width="18%">
											<col width="15%">
											<col width="15%">
											<col width="*">
											<col width="10%">
										</colgroup>
										<thead class="table-light">
											<tr>
												<th>상품분류</th>
												<th>상품명</th>
												<th>제조사</th>
												<th>정가</th>
												<th>판매가</th>
												<th>입고량(입고날짜)</th>
												<th>추천상품</th>
											</tr>
										</thead>
										<tbody>
									
										</tbody>
										<tfoot>
											<tr>

											</tr>
										</tfoot>
									</table>
								</div>
							</div>
						</div>

					</main>
					<jsp:include page="adminbottom.jsp"></jsp:include>
				</div>
			</div>
		</div>
	</div>
<!-- 모달만들기 -->
<div class="modal fade" id="registerModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">신규상품등록</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <form id="newProduct-form" class="form-horizontal border bg-light p-3" method="post" enctype="multipart/form-data" action="addProduct.jsp">
				<div class="row mb-3">
					<label for="category" class="col-sm-2 col-form-label">상품 분류</label>
					<div class="col-sm-10">
						<select class="form-select" name="categoryNo">
							<option value="" disabled selected >카테고리 선택</option>
					<%
						for(Category category : categories) {
					%>	
							<option value="<%=category.getNo() %>"><%=category.getName() %></option>
					<%
						}
					%>
						</select>
					</div>
				</div>
				<div class="row mb-3">
					<label for="name" class="col-sm-2 col-form-label">상품명</label>
					<div class="col-sm-10">
						<input type="text" name="name" id="name" class="form-control">
					</div>
				</div>
				<div class="row mb-3">
					<label for="company" class="col-sm-2 col-form-label">제조사</label>
					<div class="col-sm-10">
						<input type="text" name="company" id="company" class="form-control">
					</div>
				</div>
				<div class="row mb-3">
					<label for="price" class="col-sm-2 col-form-label">정가</label>
					<div class="col-sm-10">
						<input type="text" name="price" id="price" class="form-control">
					</div>
				</div>
				<div class="row mb-3">
					<label for="salePrice" class="col-sm-2 col-form-label">판매가</label>
					<div class="col-sm-10">
						<input type="text" name="salePrice" id="salePrice" class="form-control">
					</div>
				</div>
				<div class="row mb-3">
					<label for="quantity" class="col-sm-2 col-form-label">입고량</label>
					<div class="col-sm-10">
						<input type="number" name="quantity" id="quantity" class="form-control" min="1">
					</div>
				</div>
				<fieldset class="row mb-3">
					<legend class="col-form-label col-sm-2 pt-0">추천상품</legend>
					<div class="col-sm-10">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" name="recommended" checked> 
						</div>
					</div>
				</fieldset>
				<div class="row mb-3">
					<label for="quantity" class="col-sm-2 col-form-label">이미지</label>
					<div class="col-sm-10">
						<input type="file" name="upfile" class="form-control">
					</div>
				</div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" id="registerBtn" class="btn btn-primary" onclick="submitForm();">등록하기</button>
      </div>
    </div>
  </div>
</div>
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

		// 체크된 것이 없으면 value는 null
	 function submitForm() {
		let selectField = document.querySelector("select[name=categoryNo]");
		let selectValue = selectField.value;
		if(selectValue === "") {					// select는 false / true 값으로 x, value의 값으로 value값은 항상 문자열
			alert("카테고리를 선택해주세요");		// option 태그에 value 값을 주지 않으면 텍스트 자체가 들어간다.
			selectField.focus();
			return false;
		}
		
		let nameField = document.querySelector("input[name=name]");
		let name = nameField.value.trim();
		if(name === ''){
			alert("상품명을 입력해주세요");
			nameField.focus();
			return false;
		}
		
		let companyField = document.querySelector("input[name=company]");
		let company = companyField.value.trim();
		if(company === ''){
			alert("제조사 입력해주세요");
			companyField.focus();
			return false;
		}
		
		let priceField = document.querySelector("input[name=price]");
		let price = priceField.value.trim();
		if(price === ''){
			alert("정가를 입력해주세요");
			priceField.focus();
			return false;
		}
		
		let salePriceField = document.querySelector("input[name=salePrice]");
		let salePrice = salePriceField.value.trim();
		if(salePrice === ''){
			alert("판매가를 입력해주세요");
			salePriceField.focus();
			return false;
		}
		
		let quantityField = document.querySelector("input[name=quantity]");
		let quantity = quantityField.value.trim();
		if(quantity === ''){
			alert("입고수량을 입력해주세요");
			quantityField.focus();
			return false;
		}
		
		document.getElementById("newProduct-form").submit();
	}  
	
	
</script>
</body>
</html>