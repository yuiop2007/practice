<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>bList.jsp</title>
  <jsp:include page="/include/bs.jsp"/>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
  <script>
    function sChange() {
    	searchForm.searchString.focus();
    }
    
    function sCheck() {
    	var searchString = searchForm.searchString.value;
    	if(searchString == "") {
    		alert("검색어를 입력하세요");
    		searchForm.searchString.focus();
    	}
    	else {
    		searchForm.submit();
    	}
    }
    
    // 페이지사이즈 처리
    function pageCheck() {
    	var pageSize = pageForm.pageSize.value;
    	location.href = "${ctp}/bList.bo?pag=${pag}&pageSize="+pageSize;
    }
  </script>
  <style>
    th, td {text-align: center};
  </style>
</head>
<body>
<jsp:include page="/include/nav.jsp"/>
<div class="container">
  <p><br/></p>
  <form name="pageForm">
	  <table class="table table-borderless">
	    <tr>
	      <td colspan="3"><h2>게 시 판 리 스 트</h2></td>
	    </tr>
	    <tr>
	      <td style="text-align:left;padding:10px 0px">
	        <input type="button" value="글올리기" onclick="location.href='${ctp}/bInput.bo';" class="btn btn-secondary"/>
	      </td>
	      <td>
	        <select name="pageSize" onchange="pageCheck()" style="text-align:left;padding:5px 0px;">
	          <option value="5"  ${pageSize==5  ? 'selected' : ''}>5건</option>
	          <option value="10" ${pageSize==10 ? 'selected' : ''}>10건</option>
	          <option value="15" ${pageSize==15 ? 'selected' : ''}>15건</option>
	          <option value="20" ${pageSize==20 ? 'selected' : ''}>20건</option>
	        </select>
	      </td>
	      <td style="text-align:right;margin:0px;padding:0px;width:80%;">
	        <!-- 페이징처리 -->
	        <c:if test="${pag != 1}"><a href="bList.bo?pag=1&pageSize=${pageSize}" title="첫페이지로">◀</a></c:if>
	        <c:if test="${pag != 1}"><a href="bList.bo?pag=${pag-1}&pageSize=${pageSize}">◁</a></c:if>
	        ${pag}Page / ${totPage}Pages
	        <c:if test="${pag != totPage}"><a href="bList.bo?pag=${pag+1}&pageSize=${pageSize}">▷</a></c:if>
	        <c:if test="${pag != totPage}"><a href="bList.bo?pag=${totPage}&pageSize=${pageSize}" title="마지막페이지로">▶</a></c:if>
	        <!-- 페이징처리 -->
	      </td>
	    </tr>
	  </table>
	  <table class="table table-hover">
	    <tr class="table-dark text-dark">
	      <th>글번호</th>
	      <th>글제목</th>
	      <th>글쓴이</th>
	      <th>글쓴날자</th>
	      <th>조회수</th>
	      <th>좋아요</th>
	    </tr>
	    <c:forEach var="vo" items="${vos}">
		    <tr>
		      <td>${curScrStartNo}</td>
		      <td style="text-align:left;">
		        <a href="${ctp}/bContent.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}">${vo.title}</a>
		        <c:if test="${vo.wNdate <= 24}"><img src="${ctp}/images/new.gif"/></c:if>
		        <c:if test="${vo.replyCount != 0}">(${vo.replyCount})</c:if>
		      </td>
		      <td>${vo.name}</td>
		      <td>
		        <c:if test="${vo.wNdate <= 24}">${fn:substring(vo.wDate,11,19)}</c:if>
		        <c:if test="${vo.wNdate > 24}">${fn:substring(vo.wDate,0,10)}</c:if>
		      </td>
		      <td>${vo.readNum}</td>
		      <td>${vo.good}</td>
		    </tr>
		    <c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
	    </c:forEach>
	  </table>
  </form>
  <br/>
  <!-- 블록페이징처리 시작 -->
  <%-- 
  <c:set var="startPageNum" value="${pag - (pag-1)%blockSize}"/>  <!-- 해당블록의 시작페이지 구하기 -->
  <c:if test="${pag != 1}">
    <a href="bList.bo?pag=1">◁◁</a>
    <a href="bList.bo?pag=${pag-1}">◀</a>
  </c:if>
  <c:forEach var="i" begin="0" end="${blockSize-1}"> <!-- 블록의 크기만큼 돌려준다. -->
    <c:if test="${(startPageNum+i) <= totPage}">
	  	<c:if test="${pag == (startPageNum+i)}">
	  	  [<font color="red"><b>${startPageNum+i}</b></font>]
	  	</c:if>
	  	<c:if test="${pag != (startPageNum+i)}">
	  	  [<a href="bList.bo?pag=${startPageNum+i}">${startPageNum+i}</a>]
	  	</c:if>
  	</c:if>
  </c:forEach>
  <c:if test="${pag != totPage}">
    <a href="bList.bo?pag=${pag+1}">▶</a>
    <a href="bList.bo?pag=${totPage}">▷▷</a>
  </c:if>
   --%>
  <!-- 블록페이징처리 끝 -->
</div>
  
<!-- 블록페이징처리 시작 -->
<div class="container" style="text-align:center;">
  <ul class="pagination justify-content-center">
	  <c:set var="startPageNum" value="${pag - (pag-1)%blockSize}"/>  <!-- 해당블록의 시작페이지 구하기 -->
	  <c:if test="${pag != 1}">
	    <li class="page-item"><a href="bList.bo?pag=1&pageSize=${pageSize}" class="page-link" style="color:#666">◁◁</a></li>
	    <li class="page-item"><a href="bList.bo?pag=${pag-1}&pageSize=${pageSize}" class="page-link" style="color:#666">◀</a></li>
	  </c:if>
	  <c:forEach var="i" begin="0" end="${blockSize-1}"> <!-- 블록의 크기만큼 돌려준다. -->
	    <c:if test="${(startPageNum+i) <= totPage}">
		  	<c:if test="${pag == (startPageNum+i)}">
		  	  <li class="page-item active"><a href="bList.bo?pag=${startPageNum+i}&pageSize=${pageSize}" class="page-link btn btn-secondary active" style="color:#666"><font color="#fff">${startPageNum+i}</font></a></li>
		  	</c:if>
		  	<c:if test="${pag != (startPageNum+i)}">
		  	  <li class="page-item"><a href="bList.bo?pag=${startPageNum+i}&pageSize=${pageSize}" class="page-link" style="color:#666">${startPageNum+i}</a></li>
		  	</c:if>
	  	</c:if>
	  </c:forEach>
	  <c:if test="${pag != totPage}">
	    <li class="page-item"><a href="bList.bo?pag=${pag+1}&pageSize=${pageSize}" class="page-link" style="color:#666">▶</a></li>
	    <li class="page-item"><a href="bList.bo?pag=${totPage}&pageSize=${pageSize}" class="page-link" style="color:#666">▷▷</a></li>
	  </c:if>
  </ul>
</div>
<!-- 블록페이징처리 끝 -->
<br/>
<!-- 검색기 처리 시작 -->
<div class="container" style="text-align:center">
  <form name="searchForm" method="post" action="${ctp}/bSearch.bo">
    <b>검색 : </b>
    <select name="search" onchange="sChange()">
    	<option value="title" selected>글제목</option>
    	<option value="name">글쓴이</option>
    	<option value="content">글내용</option>
    </select>
    <input type="text" name="searchString"/>
    <input type="button" value="검 색" onclick="sCheck()"/>
    <input type="hidden" name="pag" value="${pag}"/>
    <input type="hidden" name="pageSize" value="${pageSize}"/>
  </form>
</div>
<!-- 검색기 처리 끝 -->
<p><br/></p>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>