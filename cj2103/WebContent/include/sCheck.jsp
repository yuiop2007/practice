<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String csmid = (String) session.getAttribute("smid");
	if(csmid == null) {
		out.println("<script>");
		out.println("alert('로그인후 사용하세요.');");
		out.println("location.href='"+request.getContextPath()+"/0518_database/login.jsp';");
		out.println("</script>");
	}
%>