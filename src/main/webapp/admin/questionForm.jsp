<!DOCTYPE html>
<%@page import="util.StringUtil"%>
<%@page import="java.util.List"%>
<%@page import="dao.CategoryDao"%>
<%@page import="vo.Category"%>
<%@page import="vo.User" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	#search-form .row { padding-bottom: 5px; height: 20%;}
	#search-form {font-size: small;}
	#search-form select {width: auto;}
	#search-form .col-1 {background-color: #DDDDDD; }
</style>
</head>
<%
	CategoryDao categoryDao = CategoryDao.getInstance();
	List<Category> categories = categoryDao.getCategories();
	int rows = StringUtil.stringToInt(request.getParameter("rows"), 5);
%>
<body>
	<jsp:include page="admintop.jsp"></jsp:include>
	<div class="container-fluid">
		<div class="row">
			<div class="col-2 p-0">
				<jsp:include page="adminleft.jsp"></jsp:include>
			</div>
			<div class="col-10">
				<div id="layoutSidenav_content">
					<main>
						<div class="container-fluid px-4">
							<h2 class="mt-4">상품문의 관리</h2>
							<ol class="breadcrumb mb-4">
								<li class="breadcrumb-item active">Dashboard</li>
							</ol>
							<form id="search-form" method="post" enctype="multipart/form-data">
									<div class="row">
										<div class="col-1">
											<strong>상품분류</strong>
										</div>
										<div class="col-5">
											<select class="form-select form-select-sm" name="category">
												<option disabled selected>카테고리 선택</option>
												<option value="0">전체</option>
											<%
											for (Category category : categories) {
											%>
												<option value="<%=category.getNo()%>"><%=category.getName()%></option>
											<%
											}
											%>
											</select>
										</div>
										<div class="col-1">
											<strong>검색분류</strong>
										</div>
										<div class="col-5 d-inline-flex">
											<select class="form-select form-select-sm" name="search">
												<option value="" selected disabled>검색조건</option>
												<option value="name">상품명</option>
												<option value="title">제목</option>
												<option value="content">내용</option>
											</select> 
											<input type="text" class="form-control form-control-sm" name="keyword" placeholder="키워드 입력" style="width: auto;"/>
											<!-- <button type="button" class="btn btn-outline-secondary me-5"><i class="fas fa-search"></i></button> -->
										</div>
									</div>
									<div class="row">
										<div class="col-1">
											<strong>문의등록일</strong>
										</div>
										<div class="col-5  d-inline-flex">
											<input type="date"><span class="mx-1"> ~ </span><input class="me-2" type="date">
											<div class="col-9 " style=" width: auto;">
												<div class="form-check form-check-inline">
						  							<input class="form-check-input" type="radio" name="period" value="0" checked >
						  							<label class="form-check-label" for="inlineRadio1">오늘</label>
												</div>
												<div class="form-check form-check-inline">
							  						<input class="form-check-input" type="radio" name="period" id="inlineRadio2" value="7" >
							  						<label class="form-check-label" for="inlineRadio2">7일</label>
												</div>
												<div class="form-check form-check-inline">
							  						<input class="form-check-input" type="radio" name="period" id="inlineRadio2" value="30" >
							  						<label class="form-check-label" for="inlineRadio2">1개월</label>
												</div>
												<div class="form-check form-check-inline">
							  						<input class="form-check-input" type="radio" name="period" id="inlineRadio2" value="9999" >
							  						<label class="form-check-label" for="inlineRadio2">전체</label>
												</div>
											</div>
										</div>
										<div class="col-1">
											<strong>처리상태</strong>
										</div>
										<div class="col-5 d-inline-flex">
											<div class="col-sm-9">
												<div class="form-check form-check-inline">
						  							<input class="form-check-input" type="radio" name="answered" value="Y" >
						  							<label class="form-check-label" for="inlineRadio1">답변완료</label>
												</div>
												<div class="form-check form-check-inline">
							  						<input class="form-check-input" type="radio" name="answered" id="inlineRadio2" value="N" checked>
							  						<label class="form-check-label" for="inlineRadio2">답변필요</label>
												</div>
												
											</div>
										</div>
									</div>
									<div class="row d-flex justify-content-center mt-3">
											<button type="button" class="btn btn-primary btn-sm me-2" id="search-btn" onclick="loadQuestions();" style="width: 8%;">검색</button>
											<input type="reset" class="btn btn-outline-secondary btn-sm" style="width: 8%;"/>
									</div>
							
							<div class="row">
								<h6>총 1개</h6>
							</div>
							<div class="row d-flex justify-content-between my-2">
								<div class="">
									<button class="btn btn-outline-primary btn-sm">삭제</button>
									<!-- <select class="form-select form-select-sm me-2" name="period" onchange="﻿">
										<option value="">등록일순</option>
										<option value="">오래된순</option>
									</select> -->
									<select class="form-select form-select-sm float-end" name="rows" onchange="">
										<option value="5" <%=rows == 5 ? "selected" : ""%>>5개씩
											보기</option>
										<option value="10" <%=rows == 10 ? "selected" : ""%>>10개씩
											보기</option>
										<option value="15" <%=rows == 15 ? "selected" : ""%>>15개씩
											보기</option>
									</select>
									<input type="hidden" name="page" />
								</div>
							</div>
							</form>
							<div>
								<table class="table table-hover table-borderless text-center border-top border-bottom" id="question-table">
									<colgroup>
										<col width="5%">
										<col width="8%">
										<col width="15%">
										<col width="*">
										<col width="18%">
										<col width="15%">
									</colgroup>
									<thead class="table-light">
										<tr>
											<th id=all-toggle><input type="checkbox" id="all-toggle-checkbox" onchange="toggleCheckbox();" /></th>
											<th>상품분류</th>
											<th>상품번호</th>
											<th>제목</th>
											<th>등록일</th>
											<th>비고</th>
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
					</main>
					<jsp:include page="adminbottom.jsp"></jsp:include>

				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">

	function loadQuestions(page) {
		document.getElementById("all-toggle").innerHTML ='<input type="checkbox" id="all-toggle-checkbox" onchange="toggleCheckbox();"/>' 
		
		
		let tbody = document.querySelector("#question-table tbody");
		
		let pageNo = page || 1; 
		document.querySelector("input[name=page]").value = pageNo;
		let searchForm = document.getElementById("search-form");
		let formData = new FormData(searchForm);
		
		let xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if(xhr.readyState === 4 && xhr.status === 200) {
				let jsonText = xhr.responseText;
				let result= JSON.parse(jsonText);
				let pagination = result.pagination;
				let questions = result.questions;
				
				
				let rows ="";
				for(let index = 0; index < questions.length; index++) {
					let question = questions[index];
					
					let questionNo = question.no
					let categoryNo = question.categoryNo;
					let pdNo = question.pdNo;
					let userNo = question.userNo;
					let title = question.title;
					let createdDate = question.createdDate;
					
					let answered = question.answered;
					
					if("Y" === answered) {
						answered = "답변완료";
					} else {
						answered = "답변필요";
					}					
					
					rows += "<tr> ";
					rows += '<td><input type="checkbox" name="checkbox" value="' + questionNo + '" onchange="changeCheckboxChecked();"/></td>'; // 수정
					rows += "<td data-product-category-no='"+ categoryNo + "'>" + categoryNo + "</td>";
					rows += "<td>" + pdNo + "</td>"
					rows += "<td><a href='questionDetailForm.jsp?questionNo=" + questionNo + "&pdNo=" + pdNo + "&userNo=" + userNo +"'>" + title + "</a></td>"; 
					rows += "<td>" + createdDate + "</td>";
					rows += "<td>" + answered + "</td>";
					rows += "</tr>";
				}
				tbody.innerHTML = rows;
				
				let paginationContent = "";
				
				paginationContent += '<li class="page-item">';
				if (pagination.currentPage > 1) {
					paginationContent += '<a class="page-link" href="javascript:loadQuestions('+(pagination.currentPage - 1)+')">이전</a>';
				} else {
					paginationContent += '<a class="page-link disabled" href="">이전</a>';
				}
				paginationContent += '</li>';
				
				
				for (let num = pagination.beginPage; num <= pagination.endPage; num++) {
					paginationContent += '<li class="page-item">'
					if (pagination.currentPage === num) {
						paginationContent += '<a class="page-link active" href="javascript:loadQuestions('+num+')">'+num+'</a>'
					} else {
						paginationContent += '<a class="page-link" href="javascript:loadQuestions('+num+')">'+num+'</a>'
					}
					paginationContent += '</li>';
				}
				
				paginationContent += '<li class="page-item">'
				if (pagination.currentPage < pagination.totalPages) {
					paginationContent += '<a class="page-link"  href="javascript:loadQuestions('+(pagination.currentPage + 1)+')">다음</a>';
				} else {
					paginationContent += '<a class="page-link disabled" href="">다음</a>';
				}
				paginationContent += '</li>';
				
				
				document.getElementById("pagination").innerHTML = paginationContent;
			}
		}
		
		xhr.open("POST", "questionList.jsp");
		xhr.send(formData);
		
	} 

















	function toggleCheckbox() {
	    let allToggleChecboxCheckedStatus = document.getElementById("all-toggle-checkbox").checked;
	    let pdCheckboxNodeList = document.querySelectorAll("input[name='pdCheckbox']");
	    for (let index = 0; index < pdCheckboxNodeList.length; index++) {
	        let pdCheckbox = pdCheckboxNodeList[index];
	        pdCheckbox.checked = allToggleChecboxCheckedStatus;
	    }
	}
	
	function changeCheckboxChecked() {
	    let checkboxCount = document.querySelectorAll('input[name="pdCheckbox"]').length;
	    let checkedCheckboxCount = document.querySelectorAll('input[name="pdCheckbox"]:checked').length;
	
	    document.getElementById("all-toggle-checkbox").checked = (checkboxCount === checkedCheckboxCount);
	}







</script>
</body>
</html>