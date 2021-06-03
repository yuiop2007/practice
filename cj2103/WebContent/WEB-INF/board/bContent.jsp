<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>bContent.jsp</title>
  <jsp:include page="/include/bs.jsp"/>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
  </style>
  <script>
    // 좋아요 횟수 증가 처리
    function goodCheck() {
    	var query = {
    			idx : ${vo.idx}
    	};
    	
    	$.ajax({
    		type : "get",
    		url  : "${ctp}/bGood.bo",
    		data : query,
    		success:function(data) {
    			//alert("별점출력....");
    			location.reload();
    		}
    	});
    }
    
    // 좋아요 횟수 증가 처리2
    function goodCheck2() {
    	var query = {
    			idx : ${vo.idx}
    	};
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/bGood2",
    		data : query,
    		success:function(data) {
    			alert("별점출력2....");
    			location.reload();
    		}
    	});
    }
    
    // 좋아요 횟수 증가 처리3
    function goodCheck3() {
    	var query = {
    			idx : ${vo.idx}
    	};
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/bGood3",
    		data : query,
    		success:function(data) {
    			alert("별점출력3...."+data);
    			location.reload();
    		}
    	});
    }
    
    // 좋아요 횟수 증가 처리4
    function goodCheck4() {
    	var query = {
    			idx : ${vo.idx}
    	};
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/bGood4",
    		data : query,
    		success:function(data) {
    			if(data == "1") {
    				alert("이미 좋아요를 클릭하셨습니다.");
    			}
    			location.reload();
    		}
    	});
    }
    
    // 게시글 수정처리를 위한 비밀번호 체크
    function updCheck() {
    	var pwd = myform.pwd.value;
    	if(pwd == "") {
    		alert("비밀번호를 입력하세요")
    		myform.pwd.focus();
    	}
    	else {
    		location.href="${ctp}/bUpdate.bo?idx=${vo.idx}&pwd="+pwd;
    	}
    }
    
    // 게시글 삭제처리
    function delCheck() {
    	var ans = confirm("게시글을 삭제하시겠습니까?");
    	var pwd = myform.pwd.value;
    	
    	if(ans) {
    		if(pwd == "") {
        		alert("비밀번호를 입력하세요")
        		myform.pwd.focus();
        		return false;
        }
    		else {
    			location.href = "${ctp}/bDelete.bo?idx=${vo.idx}&pwd="+pwd;
    		}
    	}
    }
    
    // 댓글 입력처리
    function replyCheck() {
    	var content = replyForm.content.value;
    	if(content == "") {
    		alert("댓글을 입력하세요?");
    		replyForm.content.focus();
    	}
    	else {
    		replyForm.submit();
    	}
    }
    
    // 댓글 삭제(aJax 처리)
    function replyDelCheck(replyIdx) {
    	var query = {replyIdx : replyIdx};
    	var ans = confirm("선택하신 댓글을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		type : "get",
    		url  : "${ctp}/bReplyDelete",
    		data : query,
    		success: function(data) {
    			alert("삭제처리 되었습니다.");
    			location.reload();
    		}
    	});
    }
  </script>
</head>
<body>
<jsp:include page="/include/nav.jsp"/>
<div class="container">
  <p><br/></p>
  <h2>글 내 용 보 기</h2>
  <br/>
  <form name="myform">
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
	      <td><!-- 이모지호출(윈도우키+'.')  -->
	        <%-- 1.<input type="button" value="❤" onclick="goodCheck()"/> ${vo.good} &nbsp; &nbsp; &nbsp; --%>
	        1.<a href="javascript:goodCheck()">❤</a> &nbsp; &nbsp; &nbsp;
	        2.<input type="button" value="👍" onclick="goodCheck2()"/> ${vo.good} &nbsp; &nbsp; &nbsp;
	        3.<input type="button" value="🧡" onclick="goodCheck3()"/> ${vo.good} &nbsp; &nbsp; &nbsp;
	        4.<input type="button" value="❤" onclick="goodCheck4()"/> ${vo.good}
	      </td>
	    </tr>
	    <tr>
	      <th>글제목</th>
	      <td colspan="3">${vo.title}</td>
	    </tr>
	    <tr>
	      <th>글내용</th>
	      <td colspan="3" style="height:200px">${fn:replace(vo.content,newLine,"<br/>")}</td>
	    </tr>
	    <tr>
	      <th>비밀번호</th>
	      <td colspan="3"><input type="password" name="pwd"/></td>
	    </tr>
	    <tr>
	      <td colspan="4" style="text-align:center;">
	        <input type="button" value="수정" onclick="updCheck()" class="btn btn-secondary"/> &nbsp;
	        <input type="button" value="삭제" onclick="delCheck()" class="btn btn-secondary"/> &nbsp;
	        <input type="button" value="돌아가기" onclick="location.href='${ctp}/bList.bo';" class="btn btn-secondary"/>
	      </td>
	    </tr>
	  </table>
  </form>
  <p><br/></p>
</div>
<!-- 아래로 댓글 처리(출력/입력) -->
<div class="container">
  <!-- 댓글 출력처리 -->
  <table class="table table-borderless table-striped table-hover">
    <tr class="table-dark text-dark">
      <th>작성자</th>
      <th>댓글내용</th>
      <th>작성일자</th>
      <th>접속IP</th>
    </tr>
    <c:forEach var="rVo" items="${rVos}">
	    <tr>
	      <td>${rVo.nickName}
	        <c:if test="${rVo.mid == smid}">
	          (<a href="javascript:replyDelCheck(${rVo.idx});">삭제</a>)
	        </c:if>
	      </td>
	      <td>${fn:replace(rVo.content,newLine,"<br/>")}</td>
	      <td>${rVo.wDate}</td>
	      <td>${rVo.hostIp}</td>
	    </tr>
    </c:forEach>
  </table>
  
  <!-- 댓글 입력처리 -->
  <form name="replyForm" method="post" action="${ctp}/bReplyInput.bo">
    <table class="table">
      <tr>
        <td style="text-align:left; width:90%">
          <label for="content">글내용 : </label>
          <textarea rows="5" name="content" id="content" class="form-control"></textarea>
        </td>
        <td style="">
        	<br/><br/>
        	<p><input type="text" name="nickName" size="6" value="${snickname}" readonly/></p>
        	<p><input type="button" value="댓글달기" onclick="replyCheck()"/></p>
        	<%-- <p><input type="button" value="돌아가기" onclick="location.href='${ctp}/bList.bo';"/> --%>
        </td>
      </tr>
    </table>
    <input type="hidden" name="boardIdx" value="${vo.idx}"/>
    <input type="hidden" name="mid" value="${smid}"/>
    <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
  </form>
</div>
<!-- 이곳까지 댓글처리 -->
<p><br/></p>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>