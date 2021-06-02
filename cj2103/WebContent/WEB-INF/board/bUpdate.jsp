<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>bUpdate.jsp</title>
  <jsp:include page="/include/bs.jsp"/>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
  </style>
  <script>
    function fCheck() {
    	var name = myform.name.value;
    	var title = myform.title.value;
    	var content = myform.content.value;
    	var pwd = myform.pwd.value;
    	
    	if(name=="") {
    		alert("글올린이 닉네임을 입력하세요");
    		myform.name.focus();
    	}
    	else if(title=="") {
    		alert("글제목을 입력하세요");
    		myform.title.focus();
    	}
    	else if(content=="") {
    		alert("글내용을 입력하세요");
    		myform.content.focus();
    	}
    	else {
    		myform.submit();
    	}
    }
    
    // 비밀번호 체크버튼을 활성화 하였을때 처리(jQuery처리)
    $(document).ready(function(){
    	$("#pwdModify").click(function(){
    		if($("#pwdModify").is(":checked")==true) {
    			$("#pwd").attr("readonly", false);
    			$("#pwd").focus();
    		}
    		else {
    			$("#pwd").val("");
    			$("#pwd").attr("readonly", true);
    		}
    	});
    });
  </script>
</head>
<body>
<jsp:include page="/include/nav.jsp"/>
<div class="container">
  <p><br/></p>
  <form name="myform" method="post" action="${ctp}/bUpdateOk.bo">
    <table class="table table-borderless">
      <tr>
        <td><h2>게시판 글수정하기</h2></td>
      </tr>
    </table>
    <table class="table">
      <tr>
        <th>글쓴이</th>
        <td><input type="text" name="name" value="${snickname}" readonly/></td>
      </tr>
      <tr>
        <th>글제목</th>
        <td><input type="text" name="title" value="${vo.title}" size="60" autofocus required/></td>
      </tr>
      <tr>
        <th>이메일</th>
        <td><input type="text" name="email" value="${vo.email}" size="60"/></td>
      </tr>
      <tr>
        <th>글내용</th>
        <td><textarea rows="6" cols="62" name="content" required>${vo.content}</textarea></td>
      </tr>
      <tr>
        <th>비밀번호</th>
        <td>
          <input type="checkbox" name="pwdModify" id="pwdModify"/>비밀글 수정 &nbsp;
          <input type="password" name="pwd" id="pwd" size="20" readonly/>
          (비밀번호 수정시는 체크버튼을 활성화 하세요)
        </td>
      </tr>
      <tr>
        <td colspan="2" style="text-align:center">
          <input type="button" value="글수정하기" onclick="fCheck()" class="btn btn-secondary"/> &nbsp;
          <input type="reset" value="다시쓰기" class="btn btn-secondary"/> &nbsp;
          <input type="button" value="돌아가기" onclick="location.href='${ctp}/bList.bo';" class="btn btn-secondary"/>
        </td>
      </tr>
    </table>
    <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
    <input type="hidden" name="idx" value="${vo.idx}"/>
  </form>
  <p><br/></p>
</div>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>