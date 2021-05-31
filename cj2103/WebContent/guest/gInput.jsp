<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>gInput.jsp</title>
  <%@ include file="../../include/bs.jsp" %>
</head>
<body>
<%@ include file="../../include/nav.jsp" %>
<div class="container">
  <p><br/></p>
  <form name="myform" method="post" action="<%=request.getContextPath()%>/gInputOk" class="was-validated">
    <h2>방명록 글쓰기</h2>
  	<div class="form-group">
      <label for="name">성명 : </label>
      <input type="text" class="form-control" name="name" id="name" placeholder="Enter username" required autofocus/>
      <div class="invalid-feedback">성명을 입력하세요.</div>
    </div>
  	<div class="form-group">
      <label for="email">Email Address : </label>
      <input type="text" class="form-control" name="email" id="email" placeholder="Enter Email"/>
    </div>
  	<div class="form-group">
      <label for="homepage">Homepage address : </label>
      <input type="text" class="form-control" name="homepage" id="homepage" value="http://"/>
    </div>
  	<div class="form-group">
      <label for="content">방문소감 : </label>
      <textarea class="form-control" name="content" id="content" rows="5" required></textarea>
      <div class="invalid-feedback">방문소감을 입력하세요.</div>
    </div>
    
    <button type="submit" class="btn btn-secondary">방명록 등록</button>
    <button type="reset" class="btn btn-secondary">방명록 등록</button>
    <button type="button" class="btn btn-secondary" onclick="location.href='gList.jsp';">돌아가기</button>
    <input type="hidden" name="hostip" value="<%=request.getRemoteAddr()%>"/>
  </form>
  <p><br/></p>
</div>
<%@ include file="../../include/footer.jsp" %>
</body>
</html>