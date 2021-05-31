<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>title</title>
  <%@ include file="/include/bs.jsp" %>
</head>
<body>
<%@ include file="/include/nav.jsp" %>
<div class="container">
  <p><br/></p>
  <h2>User List</h2>
  <table class="table table-hover">
    <tr>
      <th>번호</th>
      <th>성명</th>
      <th>나이</th>
    </tr>
    <c:forEach var="vo" items="${vos}">
	    <tr>
	      <td>${vo.idx}</td>
	      <td>${vo.name}</td>
	      <td>${vo.age}</td>
	    </tr>
    </c:forEach>
  </table>
  <p><br/></p>
</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>