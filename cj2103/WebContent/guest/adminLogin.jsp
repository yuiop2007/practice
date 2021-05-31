<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adminLogin.jsp(관리자 인증창)</title>
  <%@ include file="../../include/bs.jsp" %>
  <script>
    function fCheck() {
    	// 인증폼 체크하기.....
    	
    	myform.submit();
    }
  </script>
  <style>
    table {
      width: 400px;
      margin: 0px auto;
    }
    table, th, td {
      border: 1px solid gray;
      padding: 15px;
    }
    th {
      background-color: #ccc;
      text-align: center;
    }
  </style>
</head>
<body>
<%@ include file="../../include/nav.jsp" %>
<div class="container">
  <p><br/></p>
  <form name="myform" method="post" action="adminLoginOk.jsp">
  	<table>
  	  <tr>
  	    <th>관리자 아이디</th>
  	    <td><input type="text" name="mid" autofocus/></td>
  	  </tr>
  	  <tr>
  	    <th>관리자 비밀번호</th>
  	    <td><input type="password" name="pwd"/></td>
  	  </tr>
  	  <tr>
  	    <td colspan="2" style="text-align:center">
  	      <input type="button" value="관리자 로그인" onclick="fCheck()"/>
  	      <input type="reset" value="다시입력"/>
  	      <input type="button" value="돌아가기" onclick="location.href='<%=request.getContextPath()%>/';"/>
  	    </td>
  	  </tr>
  	</table>
  </form>
  <p><br/></p>
</div>
<%@ include file="../../include/footer.jsp" %>
</body>
</html>