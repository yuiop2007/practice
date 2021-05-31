<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>aMInfor.jsp</title>
  <%@ include file="/include/bs.jsp" %>
  <script>
  </script>
</head>
<body>
<div class="container">
  <p><br/></p>
  <form class="was-validated">
    <h2>회 원 정 보</h2>
    <div class="form-group">
      <label for="mid">아이디 : &nbsp; &nbsp;</label>${vo.mid}
    </div>
    <div class="form-group">
      <label for="nickname">닉네임 : &nbsp; &nbsp;</label>${vo.nickName}
    </div>
    <div class="form-group">
      <label for="name">성명 :</label>${vo.name}
    </div>
    <div class="form-group">
      <label for="email">Email address:</label>${vo.email}
	  </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">성별 :</span> &nbsp; &nbsp;${vo.gender}
			</div>
    </div>
    <div class="form-group">
      <label for="birthday">생일 :</label>${vo.birthday}
    </div>
    <div class="form-group">
      <div class="input-group mb-3">
	      <div class="input-group-prepend">
	        <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;${vo.tel}
	      </div>
	    </div> 
    </div>
    <div class="form-group">
      <label for="address">주소 :</label>${vo.address}
    </div>
    <div class="form-group">
	    <label for="homepage">Homepage address:</label>${vo.homePage}
	  </div>
    <div class="form-group">
      <label for="name">직업 :</label> ${vo.job}
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">취미 :</span> &nbsp; &nbsp;${vo.hobby}
			</div>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">정보공개 :</span>  &nbsp; &nbsp;${vo.userInfor} 
			</div>
    </div>
    <button type="button" class="btn btn-secondary" onclick="history.back()">돌아가기</button>
  </form>
  <p><br/></p>
</div>
</body>
</html>