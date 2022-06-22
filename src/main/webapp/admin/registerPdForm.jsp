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
</head>
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
							<h1 class="mt-4">상품등록페이지</h1>

							<div class="card my-4 ">
								<div class="card-header">
									<i class="fas fa-table me-1"></i> 
									<strong class="me-3">새로운상품</strong>
									<button type="button" class="btn btn-primary" id="register-btn" onclick="showPopup();">상품등록하기</button>
									<div class="form-div">
										<form id="register-form" class="row g-3" method="post" action="">
											<input type="hidden" name="page" /> <input type="hidden" name="search" value="" />
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
												<th>상품분류</th>
												<th>상품명</th>
												<th>제조가</th>
												<th>정가</th>
												<th>판매가</th>
												<th>입고량</th>
												<th>추천상품</th>
											</tr>
										</thead>
										<tbody>
											<%-- <tr>
												<td><%=user.getNo() %></td>
												<td><%=user.getId() %></td>
												<td><%=user.getName() %></td>
												<td><%=user.getEmail() %></td>
												<td><%=user.getTel() %></td>
												<td><%=user.getAddress() %></td>
												<td><%=user.getPoint() %></td>
											</tr>
											<tr>
												<td><%=user.getNo() %></td>
												<td><%=user.getId() %></td>
												<td><%=user.getName() %></td>
												<td><%=user.getEmail() %></td>
												<td><%=user.getTel() %></td>
												<td><%=user.getAddress() %></td>
												<td><%=user.getPoint() %></td>
											</tr> --%>
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
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
	
<script type="text/javascript">

	function showPopup() {
		const width = 600;
		const height = 600;
		let left = (document.body.offsetWidth / 2) - (width / 2);
		let tops = (document.body.offsetHeight / 2) - (height / 2);
		
		left += window.screenLeft;
		
		window.open("pdPopup.html", "상품등록창", `height=${height}, width=${width}, left=${left}, top=${top}`);
	}


</script>
</body>
</html>