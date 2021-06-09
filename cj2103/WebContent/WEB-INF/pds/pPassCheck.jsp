<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>pPassCheck.jsp</title>
  <jsp:include page="/include/bs.jsp"/>
</head>
<body>
<jsp:include page="/include/nav.jsp"/>
<div class="container">
  <p><br/></p>
  <form name="myform" method="post" action="${ctp}/pPassCheckOk.pds">
	  <h2>비밀번호 확인</h2>
	  <table class="table">
	    <tr>
	      <th>비밀번호</th>
	      <td>
	        <input type="password" name="pwd" autofocus/>
	      </td>
	    </tr>
	    <tr>
	      <td colspan="2" style="text-align:center;">
	        <input type="submit" value="비밀번호확인" class="btn btn-secondary"/> &nbsp;
	        <input type="reset" value="다시입력" class="btn btn-secondary"/> &nbsp;
	        <input type="button" value="돌아가기" onclick="javascript:history.back();" class="btn btn-secondary"/>
	      </td>
	    </tr>
	  </table>
	  <input type="hidden" name="idx" value="${idx}"/>
	  <input type="hidden" name="pag" value="${pag}"/>
  </form>
  <p><br/></p>
</div>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>