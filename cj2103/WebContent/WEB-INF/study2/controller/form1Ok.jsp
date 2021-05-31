<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>form1Ok.jsp</title>
</head>
<body>
<div class="container">
  <p><br/></p>
  <h2>이곳은 form1Ok.jsp 입니다.</h2>
  ${mid}<br/>
  ${pwd}<br/>
  <a href="<%=request.getContextPath()%>/study/f1">돌아가기</a><br/>
  <p><br/></p>
</div>
</body>
</html>