<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="util.MultipartRequest"%>
<%@page import="util.StringUtil"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp"%>
<%
	User admin = (User)session.getAttribute("ADMIN");
	if(admin == null) {
		throw new RuntimeException("신규상품등록은 관리자 로그인 후에 사용가능합니다.");
	}  
	// 파일첨부없는데 왜 multipart?
	MultipartRequest mr = new MultipartRequest(request,"" );
	
	int pdNo = StringUtil.stringToInt(mr.getParameter("pdNo"));
	int categoryNo = StringUtil.stringToInt(mr.getParameter("categoryNo"));
	String name = mr.getParameter("name");
	String company = mr.getParameter("company");
	int price = StringUtil.stringToInt(mr.getParameter("price"));
	int salePrice = StringUtil.stringToInt(mr.getParameter("salePrice"));
	int stock = StringUtil.stringToInt(mr.getParameter("stock"));
	String recommended = mr.getParameter("recommended");
	//System.out.println("상품번호 : " + pdNo + ", 상품명: " + name + ", 회사: " + company + ", 가격: " + price + ", 추천: " + recommended);
	
	ProductDao productDao = ProductDao.getInstance();
	Product product = productDao.getProductByNo(pdNo);
	
	product.setCategoryNo(categoryNo);
	product.setName(name);
	product.setCompany(company);
	product.setPrice(price);
	product.setSalePrice(salePrice);
	product.setStock(stock);
	product.setRecommended(recommended);
	
	productDao.modifyProduct(product);
	
%>