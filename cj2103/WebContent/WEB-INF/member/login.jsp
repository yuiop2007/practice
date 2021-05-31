<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>login.jsp</title>
  <%@ include file="/include/bs.jsp" %>
</head>
<body>
<%@ include file="/include/nav.jsp" %>
<div class="container">
  <p><br/></p>
  <div class="modal-dialog">
	  <div class="modal-content">
	  
	  <div class="container" style="padding:30px">
	    <h2>회원 로그인</h2>
	    <p>회원 아이디와 비밀번호를 입력해 주세요</p>
	    <form method="post" class="was-validated" action="<%=request.getContextPath()%>/loginOk.mem">
	      <div class="form-group">
	        <label for="mid">회원 아이디 :</label>
	        <input type="text" class="form-control" name="mid" id="mid" placeholder="회원 아이디를 입력하세요" required autofocus/>
	        <div class="valid-feedback">정확한 아이디를 입력하세요.</div>
	        <div class="invalid-feedback">회원 아이디는 필수 입력사항입니다.</div>
	      </div>
	      <div class="form-group">
	        <label for="pwd">비밀번호 :</label>
	        <input type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요" maxlength="9" required/>
	        <div class="valid-feedback">정확한 비밀번호를 입력하세요.</div>
	        <div class="invalid-feedback">비밀번호는 필수 입력사항입니다.</div>
	      </div>
	      
	      <button type="submit" class="btn btn-secondary">인증하기</button>&nbsp;
	      <button type="reset" class="btn btn-secondary">취소</button>&nbsp;
	      <button type="button" class="btn btn-secondary" onclick="location.href='<%=request.getContextPath()%>/';">돌아가기</button>&nbsp;
	      <button type="button" class="btn btn-secondary" onclick="location.href='<%=request.getContextPath()%>/join.mem';">회원가입</button>
	    </form>
	  </div>
	  
	  </div>
	</div>
  <p><br/></p>
</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>