<%@page import="dao.ProductDao"%>
<%@page import="vo.Product"%>
<%@page import="util.StringUtil"%>
<%@page import="util.MultipartRequest"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%
	/* User admin = (User)session.getAttribute("ADMIN");
	if(admin == null) {
		throw new RuntimeException("신규상품등록은 관리자 로그인 후에 사용가능합니다.");
	} errorPage="../error/500.jsp" */
	
	// multipart/form-data요청을 처리하는 MultipartRequest객체 생성하기
	MultipartRequest mr = new MultipartRequest(request, "C:\\eclipse\\workspace-web\\productImages");
	
	// 요청파라미터값을 조회
	int categoryNo = StringUtil.stringToInt(mr.getParameter("categoryNo"));
	String name = mr.getParameter("name");
	String company = mr.getParameter("company");
	
	int price = StringUtil.stringToInt(mr.getParameter("price"));
	int salePrice = StringUtil.stringToInt(mr.getParameter("salePrice"));
	int quantity = StringUtil.stringToInt(mr.getParameter("quantity"));
	String recommended = mr.getParameter("recommended");		// on & null?
	String fileName = mr.getParameter("upfile");
	
	Product newProduct = new Product();
	newProduct.setCategoryNo(categoryNo);
	newProduct.setName(name);
	newProduct.setCompany(company);
	newProduct.setPrice(price);
	newProduct.setSalePrice(salePrice);
	newProduct.setStock(quantity); 		// DB에 상품STOCK 디폴트값이 30이므로, 신규상품등록은 PD_STOCK에 입고수량을 넣는다.
	
	if (recommended == null) {
		newProduct.setRecommended("N");
	} else {
		newProduct.setRecommended("Y");
	}
	
	if(fileName != null) {
		newProduct.setFileName(fileName);
	} else {
		newProduct.setFileName("이미지 없음");
	}
	
	ProductDao productDao = ProductDao.getInstance();
	productDao.insertNewProduct(newProduct);
	
	response.sendRedirect("registerPdForm.jsp");
	



%>