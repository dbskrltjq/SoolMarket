<%@page import="java.util.Collections"%>
<%@page import="java.util.StringJoiner"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 	
	int recent = Integer.parseInt(request.getParameter("recent"));
 	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
 	String sort = request.getParameter("sort");
 	int rows = Integer.parseInt(request.getParameter("rows"));
 	int pdNo = Integer.parseInt(request.getParameter("pdNo"));
 
	StringJoiner joiner = new StringJoiner(":");
 
	Cookie[] ck = request.getCookies();	
	// name=pdNo인 쿠키의value[123:434:100]형식을 String 배열에 담기	
	ArrayList<String> valuesList = new ArrayList<>();
	
	
	//int sizeMinus = valuesList.size() - 1 - recent; 
	
	for (Cookie cookie : ck) {
		String name = cookie.getName();
		if ("pdNo".equals(name)) {
			String value = cookie.getValue();
			String[] values = value.split(":");
			
			for (int i=0; i<values.length; i++) {
				valuesList.add(values[i]);
			}
		}
	}
	
	//Collections.reverse(valuesList);
	valuesList.remove(recent);
	String[] valueArray = valuesList.toArray(new String[valuesList.size()]);
	
	for (int i=0; i<valueArray.length; i++) {
		joiner.add(valueArray[i]);
	}

	Cookie cookie = new Cookie("pdNo", joiner.toString());
	if (valuesList.size() == 0) {
		cookie.setMaxAge(0);
		response.addCookie(cookie);
	} 
	cookie.setMaxAge(60*60*24);
	cookie.setPath("/semi/");
	response.addCookie(cookie);
	
	
	response.sendRedirect("list.jsp?categoryNo=" + categoryNo + "&sort=" + sort + "&rows=" + rows);
%>