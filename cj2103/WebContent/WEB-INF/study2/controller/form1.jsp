<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>/WEB-INF/study2/controller/form1.jsp</title>
</head>
<body>
<div class="container">
  <p><br/></p>
  <h2>접근 경로 : '/study/f1'</h2>
  <form name="myform" method="post" action="<%=request.getContextPath()%>/study/f1Ok">
    <p>아이디 : <input type="text" name="mid"/></p>
    <p>비밀번호 : <input type="password" name="pwd"/></p>
    <p><input type="submit" value="전송"/></p>
  </form>
  <p><br/></p>
</div>
</body>
</html>