<%@page import="vo.Order"%>
<%@page import="java.util.List"%>
<%@page import="dao.OrderDao"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.User"%>
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
<style>
	tr { text-align : center; }
	td { 
			text-align : center; 
			padding: 5px;
		}
	
	.my-order-link {
			 text-decoration-line: none;
			 color : #333333;
		}

</style>
<body>
<div class="container">
	<% 
		User user = (User) session.getAttribute("LOGINED_USER"); 
	%>


	
							
							<td class="text-start" colspan="2">
								<button type="button" id="btn-order-choice-del" class="btn btn-outline-secondary btn-sm" "
										data-bs-toggle="modal" data-bs-target="#product-question-write">주문 취소
								</button>
								
								
	<!-- Button trigger modal -->

	<!-- Modal -->
							<div class="modal fade" id="product-question-write" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">     
											<div class="row">
												<div class="text-center" >
													<p><strong class="fs-3">정말 주문을 취소하시겠습니까?</strong></p>
													<p class="fs-7 mb-5">주문 취소가 확정된 후에는 취소 철회가 불가합니다.</p>
											        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">돌아가기</button>
											        <button type="button" class="btn btn-secondary" onclick="cancelOrder();">주문 취소</button>
												</div>
											</div>
										</div>
									</div>		
								</div>
							</div>																
						</td>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script>
// 상품 문의시 
function questionUserCheck(productNo) {
	let xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4 && xhr.status === 200) {
			let jsonText = xhr.responseText;
			let result = JSON.parse(jsonText);
			if (!result.exist) {
				// 비로그인시
				alert("쇼핑몰 회원님만 글작성 가능합니다.")
				location.replace("../loginform.jsp?fail=deny");
				return;
			}
		}
	}
	xhr.open("GET",'questionUserCheck.jsp')
	xhr.send();
}
</script>
</body>
</html>