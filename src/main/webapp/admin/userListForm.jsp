<%@page import="java.util.ArrayList"%>
<%@page import="vo.Pagination"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.User"%>
<%@page import="java.util.List"%>
<%@page import="dao.UserDao"%>
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
	.form-div {display: inline-block;}
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
	String search = request.getParameter("search");				// (탈퇴x)전체회원조회일 경우 search에는 "all", 탈퇴회원조회는 "deleted"
	int currentPage = StringUtil.stringToInt(request.getParameter("page"), 1);
	int rows = StringUtil.stringToInt(request.getParameter("rows"), 5);
	
	UserDao userDao = UserDao.getInstance();
	int totalRows = 0;
	if ("all".equals(search)) {
		totalRows = userDao.getTotalCurrentUsersCnt();
		
	} else if ("deleted".equals(search)) {
		totalRows = userDao.getTotalDeletedUsersCnt();
		
	}
	
	// 페이징처리에 필요한 정보를 제공하는 객체 생성
	Pagination pagination = new Pagination(rows, totalRows, currentPage);
	
	
	
%>
<body>
	<jsp:include page="admintop.jsp"></jsp:include>
	<div class="container-fluid ">
		<div class="row h-100">
			<div class="col-2 p-0">
				<jsp:include page="adminleft.jsp"></jsp:include>
			</div>
			<div class="col-10">
				<div id="layoutSidenav_content">
					<main>
						<div class="container-fluid px-4">
							<h1 class="mt-4">회원 목록</h1>

							<div class="card my-4 ">
								<div class="card-header">
									<i class="fas fa-table me-1"></i>
									<%
								if ("all".equals(search)) {
							%>
									<strong class="me-3">전체 회원 목록</strong>
									<%
								} else {
							%>
									<strong class="me-3">탈퇴한 회원 목록</strong>
									<%
								}
							%>
								<div class="form-div">
									<form id="search-form" class="row g-3" method="get" action="userListForm.jsp">
										<input type="hidden" name="page" />
										<input type="hidden" name="search"  value="<%=search %>" />		<!-- 항상 같은 작업할 때 url은 같도록 -->
										<select class="form-select form-select-sm float-end" name="rows" onchange="changeRows();">
											<option value="5" <%=rows == 5 ? "selected" : ""%>> 5개씩 보기</option> <!-- 페이지를 바꿔도 선택되게 -->
											<option value="10" <%=rows == 10 ? "selected" : ""%>> 10개씩 보기</option>
											<option value="15" <%=rows == 15 ? "selected" : ""%>> 15개씩 보기</option>
										</select>
									</form>
								</div>
								</div>
								<div class="card-body">
									<table class="table table-hover text-center" id="datatablesSimple">
										<colgroup>
											<col width="7%">
											<col width="15%">
											<col width="15%">
											<col width="17%">
											<col width="15%">
											<col width="*">
											<col width="7%">
										</colgroup>
										<thead class="table-light">
											<tr>
												<th>회원번호</th>
												<th>아이디</th>
												<th>이름</th>
												<th>이메일</th>
												<th>전화번호</th>
												<th>주소</th>
												<th>포인트</th>
											</tr>
										</thead>
										<tbody>
											<%
										if("all".equals(search)) {
											List<User> users = userDao.getUsers(pagination.getBeginIndex(), pagination.getEndIndex());
											for(User user : users) {
									%>
											<tr>
												<td><%=user.getNo() %></td>
												<td><%=user.getId() %></td>
												<td><%=user.getName() %></td>
												<td><%=user.getEmail() %></td>
												<td><%=user.getTel() %></td>
												<td><%=user.getAddress() %></td>
												<td><%=user.getPoint() %></td>
											</tr>
											<%
											}
										} else {
											List<User> users = userDao.getDeletedUsers(pagination.getBeginIndex(), pagination.getEndIndex());
											for(User user : users) {
									%>
											<tr>
												<td><%=user.getNo() %></td>
												<td><%=user.getId() %></td>
												<td><%=user.getName() %></td>
												<td><%=user.getEmail() %></td>
												<td><%=user.getTel() %></td>
												<td><%=user.getAddress() %></td>
												<td><%=user.getPoint() %></td>
											</tr>
											<%
											}
										}
									%>
										</tbody>
										<tfoot>
											<tr>

											</tr>
										</tfoot>
									</table>
									<nav>
										<ul class="pagination justify-content-center">
											<li class="page-item">
											<a class="page-link <%=pagination.getCurrentPage() == 1 ? "disabled" : ""%>" href="javascript:clickPageNo(<%=pagination.getCurrentPage() - 1%>)">이전</a>
											</li>
									<%
										for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
									%>
											<li class="page-item">
											<a class="page-link <%=pagination.getCurrentPage() == num ? "active" : ""%>" href="javascript:clickPageNo(<%=num%>)"><%=num%></a>
											</li>
									<%
										}
									%>
											<li class="page-item">
											<a class="page-link <%=pagination.getCurrentPage() == pagination.getTotalPages() ? "disabled" : ""%>" href="javascript:clickPageNo(<%=pagination.getCurrentPage() + 1 %>)">다음</a>
											</li>
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
</body>

<script type="text/javascript">

	function changeRows() {
		document.querySelector("input[name=page]").value = 1;	
		document.getElementById("search-form").submit();		
	}
	
	function clickPageNo(pageNo) {
		// 페이지번호를 바꾸는 경우에만 해당 페이지가 나오게 할 것
		document.querySelector("input[name=page]").value = pageNo;		// 사용자가 페이지번호를 바꾸는 경우에만 해당 페이지가 나오게 한다.
		
		document.getElementById("search-form").submit();
	}
</script>
</html>