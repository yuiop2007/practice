<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>login.jsp</title>
  <%@ include file="/include/bs.jsp" %>
</head>
<body>
<%@ include file="/include/nav.jsp" %>
<div class="container">
  <p><br/></p>
  <h2>비밀번호 암호화 연습</h2>
  <h3>비밀번호를 10자 이내로 입력</h3>
  <form name="myform" method="get" action="<%=request.getContextPath()%>/passwordOk2">
    <p>아이디 : <input type="text" name="mid"/></p>
    <p>비밀번호 : <input type="password" name="pwd" maxlength="9"/></p>
    <p><input type="submit" value="확인"/></p>
  </form>
  <p><br/></p>
</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>