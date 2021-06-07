<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>bMyContent.jsp</title>
  <jsp:include page="/include/bs.jsp"/>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <style>
    th, td {text-align: center;}
    th {background-color: #eee;}
  </style>
  <script>
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
    		alert("비밀번호를 입력하세요");
    		myform.pwd.focus();
    	}
    	else {
    		opener.location.href="${ctp}/bUpdate.bo?idx=${vo.idx}&pwd="+pwd+"&pag=1&pageSize=5";
    		self.close();
    	}
    }
    
    // 게시글 삭제처리
    function delCheck() {
    	var ans = confirm("게시글을 삭제하시겠습니까?");
    	var pwd = myform.pwd.value;
    	
    	if(ans) {
    		if(pwd == "") {
        		alert("비밀번호를 입력하세요");
        		myform.pwd.focus();
        		return false;
        }
    		else {
    			opener.location.href = "${ctp}/bDelete.bo?idx=${vo.idx}&pwd="+pwd+"&pag=1&pageSize=5";
    			self.close();
    		}
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
	      <td>${fn:substring(vo.wDate,0,fn:length(vo.wDate)-2)}</td>
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
	      <td>
	        <a href="javascript:goodCheck4()">❤</a> &nbsp;:  &nbsp;<font color="red"><b>${vo.good}</b></font>
	      </td>
	    </tr>
	    <tr>
	      <th>글제목</th>
	      <td colspan="3" style="text-align:left;">${vo.title}</td>
	    </tr>
	    <tr>
	      <th>글내용</th>
	      <td colspan="3" style="height:200px; text-align:left;">${fn:replace(vo.content,newLine,"<br/>")}</td>
	    </tr>
	    <tr>
	      <th>비밀번호</th>
	      <td colspan="3" style="text-align:left;"><input type="password" name="pwd"/></td>
	    </tr>
	    <tr>
	      <td colspan="4" style="text-align:center;">
	        <input type="button" value="수정" onclick="updCheck()" class="btn btn-secondary"/> &nbsp;
	        <input type="button" value="삭제" onclick="delCheck()" class="btn btn-secondary"/> &nbsp;
	        <input type="button" value="창닫기" onclick="window.close()" class="btn btn-secondary"/>
	      </td>
	    </tr>
	  </table>
  </form>
  <p></p>
</div>

<!-- 아래로 댓글 처리(출력) -->
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
	        <c:if test="${rVo.wNdate <= 24}"><img src="${ctp}/images/new.gif"/></c:if>
	      </td>
	      <td style="text-align:left;">${fn:replace(rVo.content,newLine,"<br/>")}</td>
	      <td>
	        <c:if test="${rVo.wNdate > 24}">${fn:substring(rVo.wDate,0,10)}</c:if>
          <c:if test="${rVo.wNdate <= 24}">${fn:substring(rVo.wDate,11,19)}</c:if>
	      </td>
	      <td>${rVo.hostIp}</td>
	    </tr>
    </c:forEach>
  </table>
</div>
<!-- 이곳까지 댓글처리 -->
<p><br/></p>
</body>
</html>