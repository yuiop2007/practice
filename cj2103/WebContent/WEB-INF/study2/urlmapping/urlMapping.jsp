<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>urlMapping.jsp</title>
  <%@ include file="/include/bs.jsp" %>
</head>
<body>
<%@ include file="/include/nav.jsp" %>
<div class="container">
  <p><br/></p>
  <h2>URL Mapping 연습</h2>
  <br/>
  <p>
    <a href="<%=request.getContextPath()%>/urlMappingList" class="btn btn-secondary btn-sm">Directory Mapping으로 List이동</a>&nbsp;
    <a href="<%=request.getContextPath()%>/uList.um" class="btn btn-secondary btn-sm">Extension Mapping으로 List이동</a>&nbsp;
    <a href="#" class="btn btn-secondary btn-sm">확장자 매핑으로 등록창이동</a>
  </p>
  <p><br/></p>
</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>