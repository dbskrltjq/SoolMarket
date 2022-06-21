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
</head>
<%
	String userList = request.getParameter("userList");				// (탈퇴x)전체회원조회일 경우 userList에는 "all", 탈퇴회원조회는 "deleted"
	UserDao userDao = UserDao.getInstance();
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
							<h1 class="mt-4">회원 목록</h1>
							<div class="card my-4 ">
								<div class="card-header">
									<i class="fas fa-table me-1"></i> 
							<%
								if ("all".equals(userList)) {
							%>
									<strong>전체 회원 목록</strong>
							<%
								} else {
							%>
									<strong>탈퇴한 회원 목록</strong>
							<%
								}
							%>
								</div>
								<div class="card-body">
									<table class="table" id="datatablesSimple">
									<colgroup>
										<col width="5%">
										<col width="15%">
										<col width="15%">
										<col width="17%">
										<col width="15%">
										<col width="*">
										<col width="7%">
									</colgroup>
										<thead>
											<tr>
												<th>번호</th>
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
										if("all".equals(userList)) {
											List<User> users = userDao.getAllCurrentUsers();
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
											List<User> users = userDao.getAllDeletedUsers();
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
</html>