<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>bContent.jsp</title>
  <jsp:include page="/include/bs.jsp"/>
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
  </style>
</head>
<body>
<jsp:include page="/include/nav.jsp"/>
<div class="container">
  <p><br/></p>
  <h2>글 내 용 보 기</h2>
  <br/>
  <table class="table table-bordered">
    <tr>
      <th>글쓴이</th>
      <td>${vo.name}</td>
      <th>글쓴날짜</th>
      <td>${vo.wDate}</td>
    </tr>
    <tr>
      <th>Email</th>
      <td>${vo.email}</td>
      <th>접속IP</th>
      <td>${vo.hostIp}</td>
    </tr>
    <tr>
      <th>조회수</th>
      <td>${vo.readNum}</td>
      <th>좋아요</th>
      <td>${vo.good}</td>
    </tr>
    <tr>
      <th>글제목</th>
      <td colspan="3">${vo.title}</td>
    </tr>
    <tr>
      <th>글내용</th>
      <td colspan="3" style="height:200px">${vo.content}</td>
    </tr>
    <tr>
      <th>비밀번호</th>
      <td colspan="3"><input type="password" name="pwd"/></td>
    </tr>
    <tr>
      <td colspan="4" style="text-align:center;">
        <input type="button" value="수정" onclick="" class="btn btn-secondary"/> &nbsp;
        <input type="button" value="삭제" onclick="" class="btn btn-secondary"/> &nbsp;
        <input type="button" value="돌아가기" onclick="location.href='${ctp}/bList.bo';" class="btn btn-secondary"/>
      </td>
    </tr>
  </table>
  <p><br/></p>
</div>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>