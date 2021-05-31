<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>aMList.jsp</title>
  <%@ include file="/include/bs.jsp" %>
  <script>
    function levelCheck() {
    	alert("회원정보를 변경하시려면, '정보변경'버튼을 클릭하세요...");
    }
    
    function levelSearch() {
    	var level = adminForm.level.value;
    	location.href = "${ctp}/aMList.ad?level="+level;
    }
  </script>
</head>
<body>
<%-- <% if(mlevel != 0) { %><%@ include file="/include/nav.jsp" %><% } %> --%>
<c:if test="${slevel != 0}"><jsp:include page="/include/nav.jsp"/></c:if>

<div class="container">
  <p><br/></p>
  <h2>회 원 리 스 트</h2>
  <div style="text-align:right;padding:15px 0px;">
    <form name="adminForm">
      회원등급
      <select name="level" onchange="levelSearch()">
      	<option value="" <c:if test="${empty stringLevel}">selected</c:if>>전체회원</option>
      	<option value="1" <c:if test="${stringLevel=='1'}">selected</c:if>>준회원</option>
      	<option value="2" <c:if test="${stringLevel=='2'}">selected</c:if>>정회원</option>
      	<option value="3" <c:if test="${stringLevel=='3'}">selected</c:if>>우수회원</option>
      </select>
    </form>
  </div>
  <table class="table table-hover">
    <tr class="table-dark text-dark">
      <th>번호</th>
      <th>아이디</th>
      <th>별명</th>
      <th>성명</th>
      <th>성별</th>
      <th>방문횟수</th>
      <th>최종접속일</th>
			<c:if test="${slevel == 0}">
	      <th>정보공개</th>
	      <th>등급</th>
	      <th>탈퇴유무</th>
			</c:if>
    </tr>
    <c:forEach var="vo" items="${vos}">
      <c:choose>
        <c:when test="${vo.level == 0}"><c:set var="strLevel" value="관리자"/></c:when>
        <c:when test="${vo.level == 1}"><c:set var="strLevel" value="준회원"/></c:when>
        <c:when test="${vo.level == 2}"><c:set var="strLevel" value="정회원"/></c:when>
        <c:when test="${vo.level == 3}"><c:set var="strLevel" value="우수회원"/></c:when>
      </c:choose>
	    <tr>
	      <td>${curScrStartNo}</td>
	      <td>${vo.mid}</td>
	      <td>
	        <c:if test="${slevel == 0}"><a href="${ctp}/aMInfor.ad?mid=${vo.mid}">${vo.nickName}</a></c:if>
	        <c:if test="${slevel != 0}">${vo.nickName}</c:if>
	      </td>
	      <td>${vo.name}</td>
	      <td>${vo.gender}</td>
	      <td>${vo.visitCnt}</td>
	      <td>${vo.lastDate}</td>
        <c:if test="${slevel == 0}">
		      <td>${vo.userInfor}</td>
		      <td>
		        <form name="myform" method="post" action="${ctp}/aMLevel.ad">
		        	<select name="level" onchange="levelCheck()">
		        	  <option value="1" <c:if test="${vo.level==1}">selected</c:if>>준회원</option>
		        	  <option value="2" <c:if test="${vo.level==2}">selected</c:if>>정회원</option>
		        	  <option value="3" <c:if test="${vo.level==3}">selected</c:if>>우수회원</option>
		        	  <option value="0" <c:if test="${vo.level==0}">selected</c:if>>관리자</option>
		        	</select>
		        	<input type="submit" value="정보변경"/>
		        	<input type="hidden" name="idx" value="${vo.idx}"/>
		        	<input type="hidden" name="pag" value="${pag}"/>
		        </form>
		      </td>
		      <td>${vo.userDel}</td>
				</c:if>
	    </tr>
	    <c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
    </c:forEach>
  </table>
  <!-- 페이징처리 시작 -->
	<div style="text-align:center">
	 <c:if test="${pag != 1}">[<a href="${ctp}/aMList.ad?pag=1&level=${stringLevel}">1페이지</a>]....</c:if>
	 <c:if test="${pag > 1}">[<a href="${ctp}/aMList.ad?pag=${pag-1}&level=${stringLevel}">이전페이지</a>]</c:if>
	 ${pag}Page / ${totPage}Pages
	 <c:if test="${pag < totPage}">[<a href="${ctp}/aMList.ad?pag=${pag+1}&level=${stringLevel}">다음페이지</a>]</c:if>
	 <c:if test="${pag != totPage}">....[<a href="${ctp}/aMList.ad?pag=${totPage}&level=${stringLevel}">마지막페이지</a>]</c:if>
	</div>
	<!-- 페이징처리 끝 -->
</div>
<p><br/></p>
<c:if test="${slevel != 0}"><jsp:include page="/include/footer.jsp"/></c:if>
</body>
</html>