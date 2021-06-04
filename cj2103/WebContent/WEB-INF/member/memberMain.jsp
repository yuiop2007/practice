<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%
  String nickName = (String) session.getAttribute("snickname");
  int mlevel = (int) session.getAttribute("slevel");
  String strLevel = "";
  if(mlevel == 0) strLevel = "관리자";
  else if(mlevel == 1) strLevel = "준회원";
  else if(mlevel == 2) strLevel = "정회원";
  else if(mlevel == 3) strLevel = "우수회원";
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberMain.jsp(회원로그인된후 초기화면)</title>
  <%@ include file="/include/bs.jsp" %>
</head>
<body>
<%@ include file="/include/nav.jsp" %>
<div class="container">
  <p><br/></p>
  <h2><font color="blue"><%=nickName %>님 </font>회원방(<font color="red"><%=strLevel %></font>)</h2>
  <hr/>
  <font color="blue">${snickname}</font>님 로그인 중이십니다.
  <hr/>
  게시판에 올린글 : <a href="${ctp}/bMyList.bo"><font color="red">${bMyCount}</font></a>건
  <hr/>
  방명록에 올린글 : 건
  <hr/>
  <p><br/></p>
</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>