<%@page import="vo.Product"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="vo.User"%>
<%@page import="dao.ProductDao"%>
<%@page import="util.StringUtil"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="java.util.List"%>
<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/500.jsp"%>
<%
	//세션에서 관리자정보를 조회한다.
	User admin = (User) session.getAttribute("ADMIN");
	if (admin == null) {
		throw new RuntimeException("상품수정 및 관리는 관리자 로그인 후 사용가능한 서비스 입니다.");
	}
	
    Map<String, Object> result = new HashMap<>();
	ProductDao productDao = ProductDao.getInstance();

	String[] pdNoList = request.getParameterValues("pdNos");
	
	// alert창에서 ~~상품 외 7개를 출력하기 위해서
    Product firstProduct = productDao.getProductByNo(StringUtil.stringToInt(pdNoList[0]));
    	result.put("pdNo", firstProduct.getNo());
    	result.put("pdName", firstProduct.getName());
    	//System.out.println(pdNoList.length);
    	result.put("deletedPdCount", pdNoList.length);
    	
    for(String pdNoValue : pdNoList) {
    	int productNo = StringUtil.stringToInt(pdNoValue);
		Product product = productDao.getProductByNo(productNo);
    	productDao.deleteProduct(productNo);
    }
    
    Gson gson = new Gson();
 	String jsonText = gson.toJson(result);
 	out.write(jsonText);
    

%>