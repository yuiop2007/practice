<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>bMyList.jsp(개별자료 전체 리스트)</title>
  <jsp:include page="/include/bs.jsp"/>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
  <script>
    // 페이지사이즈 처리
    function pageCheck() {
    	var pageSize = pageForm.pageSize.value;
    	location.href = "${ctp}/bMyList.bo?pag=${pag}&pageSize="+pageSize;
    }
    
    // 게시글 내용 새창으로 보기
    function nWin(idx) {
    	url = "${ctp}/bMyContent.bo?idx="+idx;
    	window.open(url,"myWin","width=770px, height=800px");
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
	      <td colspan="2"><h2><font color="blue">${snickname}</font>님이 게시한 글</h2></td>
	    </tr>
	    <tr>
	      <td style="margin:0px; padding:0px;">총 <font color="blue">${totRecCnt}</font>건</td>
	      <td style="text-align:right;margin:0px;padding:0px;width:90%;">
	        <!-- 페이징처리 -->
	        <c:if test="${pag != 1}"><a href="bMyList.bo?pag=1" title="첫페이지로">◀</a></c:if>
	        <c:if test="${pag != 1}"><a href="bMyList.bo?pag=${pag-1}">◁</a></c:if>
	        ${pag}Page / ${totPage}Pages
	        <c:if test="${pag != totPage}"><a href="bMyList.bo?pag=${pag+1}">▷</a></c:if>
	        <c:if test="${pag != totPage}"><a href="bMyList.bo?pag=${totPage}" title="마지막페이지로">▶</a></c:if>
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
		        <a href="javascript:nWin(${vo.idx})">${vo.title}</a>
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
</div>
  
<!-- 블록페이징처리 시작 -->
<div class="container" style="text-align:center;">
  <ul class="pagination justify-content-center">
	  <c:set var="startPageNum" value="${pag - (pag-1)%blockSize}"/>  <!-- 해당블록의 시작페이지 구하기 -->
	  <c:if test="${pag != 1}">
	    <li class="page-item"><a href="bMyList.bo?pag=1" class="page-link" style="color:#666">◁◁</a></li>
	    <li class="page-item"><a href="bMyList.bo?pag=${pag-1}" class="page-link" style="color:#666">◀</a></li>
	  </c:if>
	  <c:forEach var="i" begin="0" end="${blockSize-1}"> <!-- 블록의 크기만큼 돌려준다. -->
	    <c:if test="${(startPageNum+i) <= totPage}">
		  	<c:if test="${pag == (startPageNum+i)}">
		  	  <li class="page-item active"><a href="bMyList.bo?pag=${startPageNum+i}" class="page-link btn btn-secondary active" style="color:#666"><font color="#fff">${startPageNum+i}</font></a></li>
		  	</c:if>
		  	<c:if test="${pag != (startPageNum+i)}">
		  	  <li class="page-item"><a href="bMyList.bo?pag=${startPageNum+i}" class="page-link" style="color:#666">${startPageNum+i}</a></li>
		  	</c:if>
	  	</c:if>
	  </c:forEach>
	  <c:if test="${pag != totPage}">
	    <li class="page-item"><a href="bMyList.bo?pag=${pag+1}" class="page-link" style="color:#666">▶</a></li>
	    <li class="page-item"><a href="bMyList.bo?pag=${totPage}" class="page-link" style="color:#666">▷▷</a></li>
	  </c:if>
  </ul>
</div>
<!-- 블록페이징처리 끝 -->

<p><br/></p>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>