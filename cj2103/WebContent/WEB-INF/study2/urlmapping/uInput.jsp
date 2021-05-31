<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>uInput.jsp</title>
  <%@ include file="/include/bs.jsp" %>
</head>
<body>
<%@ include file="/include/nav.jsp" %>
<div class="container">
  <p><br/></p>
  <h2>정보 등록창</h2>
  <br/>
  <form name="myform" method="post" action="<%=request.getContextPath()%>/uInputOk.um">
    <p>성명 : <input type="text" name="name" autofocus/></p>
    <p>나이 : <input type="number" name="age" value="20"/></p>
    <p><input type="submit" value="등록"/></p>
  </form>
  <p><br/></p>
</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>