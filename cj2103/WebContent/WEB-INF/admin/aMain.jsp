<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>aMain.jsp</title>
  <%@ include file="/include/bs.jsp" %>
  <frameset cols="120px, *">
  	<frame src="${ctp}/aMenu.ad" frameborder=0/>
  	<frame src="${ctp}/aContent.ad" name="content" frameborder=0/>
  </frameset>
</head>
<body>
</body>
</html>