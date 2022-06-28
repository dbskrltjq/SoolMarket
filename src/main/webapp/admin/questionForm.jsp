<!DOCTYPE html>
<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="util.StringUtil"%>
<%@page import="java.util.List"%>
<%@page import="dao.CategoryDao"%>
<%@page import="vo.Category"%>
<%@page import="vo.User" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp" trimDirectiveWhitespaces="true"%>
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
	#search-form .row { padding-bottom: 5px; height: 20%;}
	#search-form {font-size: small;}
	#search-form select {width: auto;}
	#search-form .col-1 {background-color: #DDDDDD; margin: 0%;}
	#search-form th {width: 10%;}
	table label {margin-right: 10px;}
	
</style>
<%
	//세션에서 로그인된 관리자정보를 조회한다.
	User admin = (User) session.getAttribute("ADMIN");
	if (admin == null) {
		throw new RuntimeException("해당 서비스는 관리자만 이용할 수 있습니다.");
	}  
%>
</head>
<%
	CategoryDao categoryDao = CategoryDao.getInstance();
	List<Category> categories = categoryDao.getCategories();
	int rows = StringUtil.stringToInt(request.getParameter("rows"), 5);
%>
<body>
	<jsp:include page="admintop.jsp"></jsp:include>
	<div class="container-fluid">
		<div class="row h-100">
			<div class="col-2 p-0">
				<jsp:include page="adminleft.jsp"></jsp:include>
			</div>
			<div class="col-10">
				<div id="layoutSidenav_content">
					<main>
						<div class="container-fluid px-4">
							<h2 class="my-4">상품문의 관리</h2>
							<form class="form" id="search-form" method="post" enctype="multipart/form-data">
								<strong style="font-size: x-small;"><span style="color: red;">※</span>검색조건을 입력해주세요.</strong>
								<table class="table border">
									<tr class="border">
										<th class="bg-light">상품분류</th>
										<td>
											<select class="form-select form-select-sm" name="category">
												<option value="" disabled selected>카테고리 선택</option>
												<option value="0">전체</option>
										<%
											for (Category category : categories) {
										%>
												<option value="<%=category.getNo()%>"><%=category.getName()%></option>
										<%
											}
										%>
											</select>
										</td>
										<th class="bg-light">검색분류</th>
										<td style="display: inline-flex;">
											<select class="form-select form-select-sm" name="search">
												<option value="" selected disabled>검색조건</option>
												<option value="name">상품명</option>
												<option value="title">제목</option>
												<option value="content">내용</option>
											</select> 
											<input type="text" class="form-control form-control-sm" name="keyword" placeholder="키워드 입력" style="width: auto;"/>
										</td>
									</tr>
									<tr class="border">
										<th class="bg-light">문의기간조회</th>
											<td>
												<input class="form-check-input" type="radio" name="period" value="0" checked >
							  					<label class="form-check-label" for="inlineRadio1">오늘</label>
							  					<input class="form-check-input" type="radio" name="period" id="inlineRadio2" value="7" >
								  				<label class="form-check-label" for="inlineRadio2">7일</label>
								  				<input class="form-check-input" type="radio" name="period" id="inlineRadio2" value="30" >
								  				<label class="form-check-label" for="inlineRadio2">1개월</label>
								  				<input class="form-check-input" type="radio" name="period" id="inlineRadio2" value="9999" >
								  				<label class="form-check-label" for="inlineRadio2">전체</label>		
											</td>
										<th class="bg-light">처리상태</th>
											<td>
						  							<input class="form-check-input" type="radio" name="answered" value="Y" >
						  							<label class="form-check-label" for="inlineRadio1">답변완료</label>
							  						<input class="form-check-input" type="radio" name="answered" id="inlineRadio2" value="N" checked>
							  						<label class="form-check-label" for="inlineRadio2">답변필요</label>
											</td>
									</tr>
								</table>
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
										<col width="8%">
										<col width="8%">
										<col width="20%">
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
		//document.getElementById("all-toggle").innerHTML ='<input type="checkbox" id="all-toggle-checkbox" onchange="toggleCheckbox();"/>' 
		
		let selectCategoryValue = document.querySelector("select[name=category]").value;
		if(selectCategoryValue === '') {
			alert("카테고리를 선택해주세요!");
			return;
		}
		
		
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
					let pdName = question.pdName;
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
					rows += "<td>" + pdName + "</td>"
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
	    let checkboxNodeList = document.querySelectorAll("input[name='checkbox']");
	    for (let index = 0; index < checkboxNodeList.length; index++) {
	        let checkbox = checkboxNodeList[index];
	        checkbox.checked = allToggleChecboxCheckedStatus;
	    }
	}
	
	function changeCheckboxChecked() {
	    let checkboxCount = document.querySelectorAll('input[name="checkbox"]').length;
	    let checkedCheckboxCount = document.querySelectorAll('input[name="checkbox"]:checked').length;
	
	    document.getElementById("all-toggle-checkbox").checked = (checkboxCount === checkedCheckboxCount);
	}







</script>
</body>
</html>