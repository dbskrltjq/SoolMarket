<%@page import="vo.Pagination"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="vo.Category"%>
<%@page import="java.util.List"%>
<%@page import="dao.CategoryDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  errorPage="../error/500.jsp"%>
    
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
	select {margin: 3px;}
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
	int rows = StringUtil.stringToInt(request.getParameter("rows"), 5);
	
	/* //ProductDao productDao = ProductDao.getInstance();
	int categoryNo = StringUtil.stringToInt(request.getParameter("category"));
	int period = StringUtil.stringToInt(request.getParameter("period"));
	int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
	int totalRows = productDao.getTotalRows(categoryNo);   
	
	//Pagination pagination = new Pagination(rows, totalRows, currentPage);
	//List<Product> products = productDao.getProductsByCategoryNo(period, categoryNo, pagination.getBeginIndex(), pagination.getEndIndex()); */
	
	
	
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
									<div class="d-flex justify-content-between">
										<strong class="me-3"><i class="fas fa-table me-1"></i>  신규 상품</strong>
										<button type="button" class="btn btn-primary " id="register-btn" data-bs-toggle="modal" data-bs-target="#registerModal">상품등록하기</button>
									</div>
									<div class="form-div">
										<form id="register-form" class="row g-3" method="post" action="registerPdForm.jsp">
											<input type="hidden" name="page" />
											<select class="form-select" name="category" onchange="﻿loadProducts();" style="width: auto;">
												<option disabled selected >카테고리 선택</option>
										<%
											for(Category category : categories) {
										%>	
												<option value="<%=category.getNo() %>"><%=category.getName() %></option>
										<%
											}
										%>
											</select>
											<select class="form-select form-select-sm" name="period" onchange="﻿loadProducts();" style="width: auto;">
												<option value="-1">1개월</option>											
												<option value="-3">3개월</option>											
												<option value="-6">6개월</option>											
											</select>
											<select class="form-select form-select-sm float-end" name="rows" onchange="﻿loadProducts();" style="width: auto;">
												<option value="5" <%=rows == 5 ? "selected" : ""%>>5개씩 보기</option>
												<option value="10" <%=rows == 10 ? "selected" : ""%>>10개씩 보기</option>
												<option value="15" <%=rows == 15 ? "selected" : ""%>>15개씩 보기</option>
											</select>
										</form>
									</div>
								</div>
								<div class="card-body">
									<table class="table table-hover text-center" id="product-table">
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
									<nav>
										<ul class="pagination justify-content-center" id="pagination">
											<%-- <li class="page-item">
											<a class="page-link <%=pagination.getCurrentPage() == 1 ? "disabled" : ""%>" href="javascript:loadProducts(<%=pagination.getCurrentPage() - 1%>)">이전</a>
											</li>
									<%
										for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
									%>
											<li class="page-item" id="li-pagination">
											<a class="page-link <%=pagination.getCurrentPage() == num ? "active" : ""%>" href="javascript:loadProducts(<%=num%>)"><%=num%></a>
											</li>
									<%
										}
									%>
											<li class="page-item">
											<a class="page-link <%=pagination.getCurrentPage() == pagination.getTotalPages() ? "disabled" : ""%>" href="javascript:loadProducts(<%=pagination.getCurrentPage() + 1 %>)">다음</a>
											</li> --%>
										</ul>
									</nav>
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
					<label for="name" class="col-sm-3 col-form-label">상품명</label>
					<div class="col-sm-9">
						<input type="text" name="name" id="name" class="form-control">
					</div>
				</div>
				<div class="row mb-3">
					<label for="company" class="col-sm-3 col-form-label">제조사</label>
					<div class="col-sm-9">
						<input type="text" name="company" id="company" class="form-control">
					</div>
				</div>
				<div class="row mb-3">
					<label for="price" class="col-sm-3 col-form-label">정가</label>
					<div class="col-sm-9">
						<input type="text" name="price" id="price" class="form-control">
					</div>
				</div>
				<div class="row mb-3">
					<label for="salePrice" class="col-sm-3 col-form-label">판매가</label>
					<div class="col-sm-9">
						<input type="text" name="salePrice" id="salePrice" class="form-control">
					</div>
				</div>
				<div class="row mb-3">
					<label for="quantity" class="col-sm-3 col-form-label">입고량</label>
					<div class="col-sm-9">
						<input type="number" name="quantity" id="quantity" class="form-control" min="1">
					</div>
				</div>
				<fieldset class="row mb-3">
					<legend class="col-form-label col-sm-3 pt-0">추천상품</legend>
					<div class="col-sm-9">
						<div class="form-check form-check-inline">
  							<input class="form-check-input" type="radio" name="recommended" id="inlineRadio1" value="Y" >
  							<label class="form-check-label" for="inlineRadio1">예</label>
						</div>
						<div class="form-check form-check-inline">
	  						<input class="form-check-input" type="radio" name="recommended" id="inlineRadio2" value="N" checked>
	  						<label class="form-check-label" for="inlineRadio2">아니오</label>
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
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="btn-form-close">닫기</button>
        <button type="button" id="registerBtn" class="btn btn-primary" onclick="submitForm();">등록하기</button>
      </div>
    </div>
  </div>
</div>
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

	/* function changeRows() {
		document.querySelector("input[name=page]").value = 1;	
		document.getElementById("register-form").submit();		
	}
		
	function clickPageNo(pageNo) {
		// 페이지번호를 바꾸는 경우에만 해당 페이지가 나오게 할 것
		document.querySelector("input[name=page]").value = pageNo;		// 사용자가 페이지번호를 바꾸는 경우에만 해당 페이지가 나오게 한다.
			
		document.getElementById("register-form").submit();
	} */



	// 카테고리변경을 ajax로 했으면, 조회날짜, ~줄씩 보기도 ajax로 해야한다.
	function loadProducts(page) {
		let categoryNo = document.querySelector("select[name=category]").value;
		let period = document.querySelector("select[name=period]").value;
		let rows = document.querySelector("select[name=rows]").value;
		let pageNo = page || 1; 		// js 문법, 인수로 받은 page값이 true면 좌측의 page가 들어가고 false면 1이 들어간다. 
		
		let tbody = document.querySelector("#product-table tbody");
		// location.href = "registerPdForm.jsp?categoryNo=" + categoryNo; 오류이유?
		let xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if(xhr.readyState === 4 && xhr.status === 200) {
				let jsonText = xhr.responseText;
				let result= JSON.parse(jsonText);
				let pagination = result.pagination;
				let products = result.products;
				
				let rows ="";
				for(let index = 0; index < products.length; index++) {
					let product = products[index];
					let category = product.categoryNo;
					let name = product.name;
					let company = product.company;
					let price = product.price;
					let salePrice = product.salePrice;
					let quantity = product.stock;
					let createdDate= product.createdDate;
					let recommended = product.recommended;
					
					rows += "<tr>";
					rows += "<td>" + category + "</td>";
					rows += "<td>" + name + "</td>";
					rows += "<td>" + company + "</td>";
					rows += "<td>" + price + "</td>";
					rows += "<td>" + salePrice + "</td>";
					rows += "<td>" + quantity + "(" + createdDate + ")" + "</td>";
					rows += "<td>" + recommended + "</td>";
					rows += "</tr>";
				}
				tbody.innerHTML = rows;
				
				let paginationContent = "";
				
				paginationContent += '<li class="page-item">';
				if (pagination.currentPage > 1) {
					paginationContent += '<a class="page-link" href="javascript:loadProducts('+(pagination.currentPage - 1)+')">이전</a>';
				} else {
					paginationContent += '<a class="page-link disabled" href="">이전</a>';
				}
				paginationContent += '</li>';
				
				
				for (let num = pagination.beginPage; num <= pagination.endPage; num++) {
					paginationContent += '<li class="page-item">'
					if (pagination.currentPage === num) {
						paginationContent += '<a class="page-link active" href="javascript:loadProducts('+num+')">'+num+'</a>'
					} else {
						paginationContent += '<a class="page-link" href="javascript:loadProducts('+num+')">'+num+'</a>'
					}
					paginationContent += '</li>';
				}
				
				paginationContent += '<li class="page-item">'
				if (pagination.currentPage < pagination.totalPages) {
					paginationContent += '<a class="page-link"  href="javascript:loadProducts('+(pagination.currentPage + 1)+')">다음</a>';
				} else {
					paginationContent += '<a class="page-link disabled" href="">다음</a>';
				}
				paginationContent += '</li>';
				
				
				document.getElementById("pagination").innerHTML = paginationContent;
			}
			
			
		}
		xhr.open("GET", "productList.jsp?categoryNo=" + categoryNo + "&period=" + period + "&rows=" + rows + "&pageNo=" + pageNo);
		xhr.send();
	}
	
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
		
		// 폼을 비동기방식으로 제출하기
		let form = document.getElementById("newProduct-form");
		let formData = new FormData(form);
		
		let xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				loadProducts(1);									// 다시 리스트 출력
				document.getElementById("btn-form-close").click();
				alert("상품등록이 완료되었습니다.");
			}
		}
		xhr.open("POST", "addProduct.jsp");			// 상품추가 jsp 주소를 넣는다. form제출은 POST방식
		xhr.send(formData);							// js의 객체를 담아서 보낸다.
	}  
		
	
	
</script>
</body>
</html>