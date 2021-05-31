<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>mUpdate.jsp(회원정보수정)</title>
  <%@ include file="/include/bs.jsp" %>
  <script>
  	var nickCheckOn = 0;
  
    // 닉네임 체크
    function nickCheck() {
    	var nickName = myform.nickName.value;
    	var url = "<%=request.getContextPath()%>/nickCheck.mem?nickName="+nickName;
    	
    	if(nickName=="") {
    		alert("닉네임을 입력하세요!");
    		myform.nickName.focus();
    	}
    	else {
    		nickCheckOn = 1;
    		window.open(url,"nWin","width=500px,height=250px");
    	}
    }
    
    // form 체크
    function fCheck() {
    	var pwd = myform.pwd.value;
    	var nickName = myform.nickName.value;
    	var name = myform.name.value;
    	var email1 = myform.email1.value;
    	
    	if(pwd == "") {
    		alert("비밀번호를 입력하세요");
    		myform.pwd.focus();
    	}
    	else if(nickName == "") {
    		alert("닉네임을 입력하세요");
    		myform.nickName.focus();
    	}
    	else if(name == "") {
    		alert("성명을 입력하세요");
    		myform.name.focus();
    	}
    	else if(email1 == "") {
    		alert("이메일을 입력하세요");
    		myform.email1.focus();
    	}
    	// 기타 추가 체크해야 할 항목들을 모두 체크한다.
    	else {
    		if(nickCheckOn == 1) {
    			myform.submit();
    		}
    		else {
  				alert("닉네임 체크버튼을 눌러주세요!");
    		}
    	}
    }
    
    // 닉네임 중복버튼 초기화
    function nickReset() {
    	nickCheckOn = 0;
    }
  </script>
</head>
<body>
<%@ include file="/include/nav.jsp" %>
<div class="container">
  <p><br/></p>
  <form name="myform" method="post" action="<%=request.getContextPath()%>/joinOk.mem" class="was-validated">
    <h2>회원 정보 수정</h2>
    <div class="form-group">
      <label for="mid">아이디 : &nbsp; &nbsp;</label><b>${vo.mid}</b>
    </div>
    <div class="form-group">
      <label for="pwd">비밀번호 :</label>
      <input type="password" class="form-control" id="pwd" name="pwd" value="${vo.pwd}" maxlength="7" required/>
    </div>
    <div class="form-group">
      <label for="nickname">닉네임 : &nbsp; &nbsp;<input type="button" value="닉네임 중복체크" class="btn btn-secondary" onclick="nickCheck()"/></label>
      <input type="text" class="form-control" id="nickName" name="nickName" value="${vo.nickName}"  onkeyup="nickReset()" required/>
    </div>
    <div class="form-group">
      <label for="name">성명 :</label>
      <input type="text" class="form-control" id="name" name="name" value="${vo.name}" required/>
    </div>
    <c:set var="email" value="${fn:split(vo.email,'@')}"/>
    <div class="form-group">
      <label for="email">Email address:</label>
				<div class="input-group mb-3">
				  <input type="text" class="form-control" id="email1" name="email1" value="${email[0]}"  required/>
				  <div class="input-group-append">
				    <select name="email2" class="custom-select">
					    <option value="naver.com"   <c:if test="${email[1]=='naver.com'}">selected</c:if>>naver.com</option>
					    <option value="hanmail.net" <c:if test="${email[1]=='hanmail.net'}">selected</c:if>>hanmail.net</option>
					    <option value="hotmail.com" <c:if test="${email[1]=='hotmail.com'}">selected</c:if>>hotmail.com</option>
					    <option value="gmail.com"   <c:if test="${email[1]=='gmail.com'}">selected</c:if>>gmail.com</option>
					    <option value="nate.com"    <c:if test="${email[1]=='nate.com'}">selected</c:if>>nate.com</option>
					    <option value="yahoo.com"   <c:if test="${email[1]=='yahoo.com'}">selected</c:if>>yahoo.com</option>
					  </select>
				  </div>
				</div>
	  </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">성별 :</span> &nbsp; &nbsp;
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" value="남자" <c:if test="${vo.gender=='남자'}">checked</c:if>>남자
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" value="여자" <c:if test="${vo.gender=='여자'}">checked</c:if>>여자
			  </label>
			</div>
    </div>
    <div class="form-group">
      <label for="birthday">생일 :</label>
			<input type="date" name="birthday" value="${fn:substring(vo.birthday,0,10)}" class="form-control"/>
    </div>
    <c:set var="tel" value="${fn:split(vo.tel,'-')}"/>
    <div class="form-group">
      <div class="input-group mb-3">
	      <div class="input-group-prepend">
	        <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;
			      <select name="tel1" class="custom-select">
					    <option value="010" <c:if test="${tel[0]=='010'}">selected</c:if>>010</option>
					    <option value="02"  <c:if test="${tel[0]=='02'}">selected</c:if>>서울</option>
					    <option value="031" <c:if test="${tel[0]=='031'}">selected</c:if>>경기</option>
					    <option value="032" <c:if test="${tel[0]=='032'}">selected</c:if>>인천</option>
					    <option value="041" <c:if test="${tel[0]=='041'}">selected</c:if>>충남</option>
					    <option value="042" <c:if test="${tel[0]=='042'}">selected</c:if>>대전</option>
					    <option value="043" <c:if test="${tel[0]=='043'}">selected</c:if>>충북</option>
			        <option value="051" <c:if test="${tel[0]=='051'}">selected</c:if>>부산</option>
			        <option value="052" <c:if test="${tel[0]=='052'}">selected</c:if>>울산</option>
			        <option value="061" <c:if test="${tel[0]=='061'}">selected</c:if>>전북</option>
			        <option value="062" <c:if test="${tel[0]=='062'}">selected</c:if>>광주</option>
					  </select>-
	      </div>
	      <input type="text" name="tel2" value="${tel[1]}" size=4 maxlength=4 class="form-control"/>-
	      <input type="text" name="tel3" value="${tel[2]}" size=4 maxlength=4 class="form-control"/>
	    </div> 
    </div>
    <div class="form-group">
      <label for="address">주소 :</label>
      <input type="text" class="form-control" id="address" name="address" value="${vo.address}"/>
    </div>
    <div class="form-group">
	    <label for="homepage">Homepage address:</label>
	    <input type="text" class="form-control" name="homePage" value="${vo.homePage}" id="homePage"/>
	  </div>
    <div class="form-group">
      <label for="name">직업 :</label>
      <select class="form-control" id="job" name="job">
        <option value="${vo.job}" selected>${vo.job}</option>
        <option>학생</option>
        <option>회사원</option>
        <option>공무원</option>
        <option>군인</option>
        <option>의사</option>
        <option>법조인</option>
        <option>세무인</option>
        <option>자영업</option>
        <option>기타</option>
      </select>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">취미 :</span> &nbsp; &nbsp;
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="등산" name="hobby"/>등산
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="낚시" name="hobby"/>낚시
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="수영" name="hobby"/>수영
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="독서" name="hobby"/>독서
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="영화감상" name="hobby"/>영화감상
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="바둑" name="hobby"/>바둑
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="축구" name="hobby"/>축구
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="기타" name="hobby" checked/>기타
			  </label>
			</div>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">정보공개 :</span>  &nbsp; &nbsp; 
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="userInfor" value="공개" <c:if test="${vo.userInfor=='공개'}">checked</c:if>/>공개
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="userInfor" value="비공개" <c:if test="${vo.userInfor=='비공개'}">checked</c:if>/>비공개
			  </label>
			</div>
    </div>
    <button type="button" class="btn btn-secondary" onclick="fCheck()">정보수정</button>
    <button type="reset" class="btn btn-secondary">다시작성</button>
    <button type="button" class="btn btn-secondary" onclick="location.href='<%=request.getContextPath()%>/memberMain.mem';">돌아가기</button>
    <input type="hidden" name="mid" value="${vo.mid}"/>
  </form>
  <p><br/></p>
</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>