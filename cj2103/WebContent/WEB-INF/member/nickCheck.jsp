<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String nickName = (String) request.getAttribute("nickName");
  int res = (int) request.getAttribute("res");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>nickCheck.jsp(닉네임체크폼)</title>
  <%@ include file="/include/bs.jsp" %>
  <script>
    function sendCheck() {
    	opener.window.document.myform.nickName.value = "<%=nickName%>";
    	opener.window.document.myform.name.focus();
    	window.close();
    }
    
    function nickCheck() {
    	var nickName = childForm.nickName.value;
    	if(nickName=="") {
    		alert("닉네임을 입력하세요!");
    		childForm.nickName.focus();
    	}
    	else {
    		childForm.submit();
    	}
    }
  </script>
</head>
<body>
<div class="container">
  <p><br/></p>
  <h3>닉네임 체크폼</h3>
<%if(res != 0) { %>
    <h4><font color="red"><%=nickName%></font> 닉네임은 사용 가능합니다.</h4>
    <p><input type="button" value="창닫기" onclick="sendCheck()"/></p>
<%} else { %>
    <h4><font color="red"><%=nickName%></font>는 이미 사용중인 닉네임 입니다.</h4>
    <form name="childForm" method="post" action="<%=request.getContextPath()%>/nickCheck.mem">
      <input type="text" name="nickName"/>
      <input type="button" value="닉네임검색" onclick="nickCheck()"/>
    </form>
<%} %>
  <p><br/></p>
</div>
</body>
</html>