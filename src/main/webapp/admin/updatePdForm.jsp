<!DOCTYPE html>
<%@page import="util.StringUtil"%>
<%@page import="vo.Category"%>
<%@page import="java.util.List"%>
<%@page import="dao.CategoryDao"%>
<%@page import="vo.User" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp"%>
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
							<h1 class="mt-4">상품정보수정</h1>

							<div class="card my-4 ">
								<div class="card-header">
									<div class="d-flex justify-content-between">
										<strong class="me-3"><i class="fas fa-table me-1"></i>상품정보수정</strong>
										<button type="button" class="btn btn-primary " id="update-btn">상품수정하기</button>
									</div>
									<div class="form-div ">
										<form id="update-form" class="row g-3" method="post">
												<div class="col-3 input-group ">
												<input type="hidden" name="page" />
												<select class="form-select form-select-sm" name="category" onchange="﻿loadProducts();" style="width: auto;">
													<option disabled selected >카테고리 선택</option>
											<%
												for(Category category : categories) {
											%>	
													<option value="<%=category.getNo() %>"><%=category.getName() %></option>
											<%
												}
											%>
												</select>
												<select class="form-select form-select-sm float-end" name="search" onchange="﻿loadProducts();" style="width: auto;">
													<option value="" selected disabled>검색조건</option>
													<option value="company">제조사</option>
													<option value="name">상품명</option>
												</select>
												<input type="text" class="form-control" name="keyword" placeholder="키워드 입력" style="width: auto;"/>
												<select class="form-select form-select-sm" name="period" onchange="﻿loadProducts();" style="width: auto;">
													<option value="-9999">전체보기</option>
													<option value="-1">1개월</option>											
													<option value="-3">3개월</option>											
													<option value="-6">6개월</option>	
												</select>
												</div>
												<button type="button" class="btn btn-outline-secondary" onclick="searchByKeyword();">검색</button>
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
												<th>재고량</th>
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
<script type="text/javascript">

	function loadProducts(page) {
		let categoryNo = document.querySelector("select[name=category]").value;
		let period = document.querySelector("select[name=period]").value;
		let rows = document.querySelector("select[name=rows]").value;
		let pageNo = page || 1; 
		
		let search = document.querySelector("select[name=search]").value;
		let keyword = document.querySelector("input[name=keyword]").value;
		
		let tbody = document.querySelector("#product-table tbody");
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
		
		xhr.open("GET", "productList.jsp?categoryNo=" + categoryNo + "&period=" + period + "&rows=" + rows + "&pageNo=" + pageNo + "&search=" + search + "&keyword=" + keyword);
		xhr.send();
		
	}
	
	function searchByKeyword() {
		let form = document.getElementById("update-form");
		let formData = new FormData(form);
		
		let xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				loadProducts(1);
			}
		}
		xhr.open("POST", "productList.jsp");			
		xhr.send(formData);		 
	
		
	}
	
	
</script>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</html>