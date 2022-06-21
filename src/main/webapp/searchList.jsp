<%@page import="dao.ProductDao"%>
<%@page import="vo.Pagination"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.Category"%>
<%@page import="vo.Product"%>
<%@page import="java.util.List"%>
<%@page import="dao.CategoryDao"%>
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
<jsp:include page="common/nav.jsp">
	<jsp:param name="menu" value="list"/>
</jsp:include>
<%
	CategoryDao categoryDao = CategoryDao.getInstance();
	ProductDao productDao = ProductDao.getInstance();
	
	String keyword = request.getParameter("keyword");
	if (keyword == null || keyword.isEmpty()) {
		keyword = "안동소주";
	}
	int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);			// 현재페이지 지정
	int rows = StringUtil.stringToInt(request.getParameter("rows"), 5);					// 페이지에 표시될 행 개수
	
	String sort = request.getParameter("sort");
	String categoryName = request.getParameter("categoryName");
	String company = request.getParameter("company");
	
	if (categoryName == null) {
		categoryName = "";
	} 
	
	if (company == null) {
		company = "";
	} 
	
	List<Product> productCompanyByKeyword = productDao.getCompanyByKeyword(keyword);			// 매개변수 개수 수정
	List<Category> categoryNameByKeyword = categoryDao.getCategoryNameByKeyword(keyword);		// 매개변수 개수 수정

	int totalQuantity = productDao.getTotalQunatity(keyword);
	
	int totalRows = 0;						
	if (!categoryName.isEmpty() && company.isEmpty()) {
			totalRows = productDao.getTotalRowsByCategory(keyword, categoryName);
	} else if (categoryName.isEmpty() && !company.isEmpty()) {
			totalRows = productDao.getTotalRowsByCompany(keyword, company);
	} else if (!categoryName.isEmpty() && !company.isEmpty()){
			totalRows = productDao.getTotalRows(keyword, categoryName, company);
	} else {
			totalRows = productDao.getTotalRows(keyword);
	}
	
	Pagination pagination = new Pagination(rows, totalRows, currentPage);

	List<Product> productList = null;
	if (categoryName.isEmpty() && company.isEmpty()) {
		if ("low".equals(sort)) {
			productList = productDao.getItemByMinPrice(keyword, pagination.getBeginIndex(), pagination.getEndIndex());
		} else if ("high".equals(sort)) {
			productList = productDao.getItemByMaxPrice(keyword, pagination.getBeginIndex(), pagination.getEndIndex());
		} else if ("date".equals(sort)) {
			productList = productDao.getItemByDate(keyword, pagination.getBeginIndex(), pagination.getEndIndex());
		} else {
			productList = productDao.getItemBySaleQuantity(keyword, pagination.getBeginIndex(), pagination.getEndIndex());
		}		
	} else if (!categoryName.isEmpty() && company.isEmpty()) {
		productList = productDao.getItemByOptionCategory(keyword, categoryName, pagination.getBeginIndex(), pagination.getEndIndex());
	} else if (categoryName.isEmpty() && !company.isEmpty()) {
		productList = productDao.getItemByOptionCompany(keyword, company, pagination.getBeginIndex(), pagination.getEndIndex());
	} else {
		productList = productDao.getItemByOption(keyword, categoryName, company, pagination.getBeginIndex(), pagination.getEndIndex());
	}

	
%>
<div class="container">
	<div class="row">
		<div class="col-2">
			<form role="search" action="/semi/searchList.jsp?">
				<div class="border-bottom pb-2 mb-2">
					<div class="border-bottom pb-1 mb-1 mt-3"><strong><p>카테고리</p></strong></div>
					<input type="hidden" name="keyword" value="<%=keyword %>" />
					<%
						for (Category category : categoryNameByKeyword) {
					%>
					<div class="form-check">
					  <input class="form-check-input" type="checkbox" name="categoryName" value="<%=category.getName() %>" id="flexCheckDefault" />
					  <label class="form-check-label" for="flexCheckDefault"><%=category.getName() %></label>
					</div>
					<%
						}
					%>
				</div>
				<div class="border-bottom pb-2 mb-2">
					<div class="border-bottom pb-1 mb-1 mt-3"><strong><p>브랜드</p></strong></div>
					<%
						for (Product product : productCompanyByKeyword) {
					%>
					<div class="form-check">
					  <input class="form-check-input" type="checkbox" name="company" value="<%=product.getCompany() %>" id="flexCheckDefault" />
					  <label class="form-check-label" for="flexCheckDefault"><%=product.getCompany() %></label>
					</div>
					<%
						}
					%>
				</div>
				<div>
					  <button class="btn btn-outline-primary" type="submit">검색</button>
				</div>		
			</form>				
		</div>	
				
				
				
	<div class="col-10">			
	<div class="mt-3">
		<p><strong>"<%=keyword %>" 검색결과 <%=totalRows %>개</strong></p>
	</div>
	<div>
		<form>
		 <div class="row mb-3 border-top border-bottom border-1 p3">
	 		<div class="col p-2">
	 			<a href="searchList.jsp?sort=sell&rows=<%=rows %>&keyword=<%=keyword %>" class="btn btn-outline-primary">판매량순</a>	 
	 			<a href="searchList.jsp?sort=low&rows=<%=rows %>&keyword=<%=keyword %>" class="btn btn-outline-primary">낮은가격순</a>	 	
	 			<a href="searchList.jsp?sort=high&rows=<%=rows %>&keyword=<%=keyword %>" class="btn btn-outline-primary">높은가격순</a>	 	
	 			<a href="searchList.jsp?sort=date&rows=<%=rows %>&keyword=<%=keyword %>" class="btn btn-outline-primary">등록일순</a>
				
				<select class="form-control form-control-sm w-25 float-end" name="rows" onchange="changeRows();">
					<option value="5" <%=rows == 5 ? "selected" : "" %>> 5개씩 보기</option>
					<option value="10" <%=rows == 10 ? "selected" : "" %>> 10개씩 보기</option>
					<option value="20" <%=rows == 20 ? "selected" : "" %>> 20개씩 보기</option>
				</select>
	 		</div>
		 </div>
		</form>
	</div>
	<div class="row">
	<%
		for (Product product : productList) {
	%>
            <div class="col-lg-3 col-md-6 mb-4">
               <div class="card h-100">
                   <a href="product/detail.jsp?productNo=<%=product.getNo() %>" class="text-dark text-decoration-none"><img class="card-img-top" src="images/cate_01.jpg" alt="..." />
                   	 <div class="card-body">
                       <h5 class="card-title fs-6 text-bold"><%=product.getName() %></h5>
                       <p class="mb-1"><del><%=product.getPrice() %></del> 원</p>
                       <p><strong class="text-danger"><%=product.getSalePrice() %></strong> 원</p>
                       <p class="card-text">상품설명(생략가능)</p>
                     </div>
                     <div class="card-footer"><small class="text-muted"><%=product.getReviewScore() %></small></div>
                   	</a>
               </div>
            </div>  
    <%
		}
    %>             
	<nav>
			<ul class="pagination justify-content-center">
				<li class="page-item">
					<a class="page-link <%=pagination.getCurrentPage() == 1 ? "disabled" : "" %>" href="javascript:clickPageNo(<%=pagination.getCurrentPage() - 1 %>)">이전</a>
				</li>
		<%
			for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
		%>
				<li class="page-item">
					<a class="page-link <%=pagination.getCurrentPage() == num ? "active" : "" %>" href="javascript:clickPageNo(<%=num %>)"><%=num %></a>
				</li>
		<%
			}
		%>
				<li class="page-item">
					<a class="page-link <%=pagination.getCurrentPage() == pagination.getTotalPages() ? "disabled" : "" %>" href="javascript:clickPageNo(<%=pagination.getCurrentPage() + 1 %>)">다음</a>
				</li>
			</ul>
	</nav>
		<form id="search-form" class="row g-3" method="get">
			<input type="hidden" name="keyword" value="<%=keyword== null ? "" : keyword %>" />
			<input type="hidden" name="sort" value="<%=sort == null ? "" : sort %>" />	
			<input type="hidden" name="page" />
			<input type="hidden" name="rows" />
			<input type="hidden" name="categoryName" value="<%=categoryName == null ? "" : categoryName %>" />
			<input type="hidden" name="company" value="<%=company == null ? ""  : company %>" />	
		</form>
  </div>
</div>
</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script>
	function changeRows() {
		document.querySelector("input[name=page]").value = 1;
		document.querySelector("input[name=rows]").value = document.querySelector("select[name=rows]").value;
		document.getElementById("search-form").submit();
	}
	function clickPageNo(pageNo) {
		document.querySelector("input[name=page]").value = pageNo;
		document.querySelector("input[name=rows]").value = document.querySelector("select[name=rows]").value;
		document.getElementById("search-form").submit();
	}


</script>
</body>
</html>