<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>pList.jsp</title>
  <jsp:include page="/include/bs.jsp"/>
  <script>
    function newWin(idx) {
    	var url = "${ctp}/pContent.pds?idx="+idx;
    	var winX = 500;
    	var winY = 400;
    	var x = (window.screen.width)/2 - winX/2;
    	var y = (window.screen.height)/2 - winY/2;
    	window.open(url,"pdsWin","width="+winX+", height="+winY+", left="+x+", top="+y)
    }
    
    function downCheck(idx) {
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/pDownCount",
    		data : {idx : idx},
    		success:function(data) {
    			location.reload();
    		}
    	});
    }
    
    // 삭제처리(비밀번호 입력시는 화면이 변경되기에 처리의 의미가 없음.)
    /* 
    function pFDelete(idx) {
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/pFDelete",
    		data : {idx : idx},
    		success:function(data) {
    			if(data == "1") {
    				alert("자료파일이 삭제되었습니다.");
    			}
    			else {
    				alert("삭제 실패~~");
    			}
    			location.reload();
    		}
    	});
    }
     */
    
    function pFDelete(idx) {
    	var ans = confirm("현재 자료파일을 삭제하시겠습니가?");
    	if(ans) {
    		location.href = "${ctp}/pPassCheck.pds?idx="+idx+"&pag=${pag}";
    	}
    }
     
    // 부분파일(선택파일) 검색처리
    function partCheck() {
    	var part = partForm.part.value;
    	location.href = "${ctp}/pList.pds?part="+part;
    }
  </script>
</head>
<body>
<jsp:include page="/include/nav.jsp"/>
<div class="container">
  <p><br/></p>
  <table class="table table-borderless">
    <tr>
      <td colspan="2" style="text-align:center;"><h2><font color="blue">${part}</font> 자 료 실 리 스 트</h2></td>
    </tr>
    <tr>
      <td style="text-align:left;">
        <form name="partForm">
	        <select name="part" onchange="partCheck()" class="form-control" style="text-align:left;width:30%;">
	          <option value="전체" ${part=='전체' ? 'selected' : ''}>전체</option>
	          <option value="학습" ${part=='학습' ? 'selected' : ''}>학습</option>
	          <option value="여행" ${part=='여행' ? 'selected' : ''}>여행</option>
	          <option value="음식" ${part=='음식' ? 'selected' : ''}>음식</option>
	          <option value="기타" ${part=='기타' ? 'selected' : ''}>기타</option>
	        </select>
        </form>
      </td>
      <td style="text-align:right;width:30%;">
        <button type="button" onclick="location.href='${ctp}/pInput.pds';" class="form-control btn btn-secondary">자료올리기</button>
      </td>
    </tr>
  </table>
  <table class="table table-hover">
    <tr class="table-dark text-dark">
      <th>번호</th>
      <th>자료제목</th>
      <th>올린이</th>
      <th>올린날짜</th>
      <th>파일명(크기)</th>
      <th>분류</th>
      <th>다운수</th>
      <th>비고</th>
    </tr>
    <c:forEach var="vo" items="${vos}">
      <c:if test="${vo.openSw == '공개' || smid == vo.mid || slevel == 0}">
	    <tr>
	      <td>${curScrStartNo}</td>
	      <td>
        	<a href="javascript:newWin('${vo.idx}')">${vo.title}</a>
	      </td>
	      <td>${vo.nickName}</td>
	      <td>${vo.fDate}</td>
	      <td>
	        <c:set var="fNames" value="${fn:split(vo.fName,'/')}"/>
	        <c:set var="fSNames" value="${fn:split(vo.fSName,'/')}"/>
	        <c:forEach var="fName" items="${fNames}" varStatus="st">
	          <a href="${ctp}/data/pds/${fSNames[st.index]}" download='${fName}' onclick="downCheck('${vo.idx}')">${fName}</a><br/>
	        </c:forEach>
	      </td>
	      <td>${vo.part}</td>
	      <td>${vo.downNum}</td>
	      <td>
	      	<c:if test="${smid == vo.mid || slevel == 0}">
	        	<a href="javascript:pFDelete('${vo.idx}')" class="btn btn-outline-secondary btn-sm">삭제</a>
	        </c:if>
	      </td>
	    </tr>
	    </c:if>
	    <c:if test="${vo.openSw != '공개' && smid != vo.mid && slevel != 0}">
	      <tr>
	        <td>${curScrStartNo}</td>
	        <td colspan="7" style="text-align:center;">${vo.nickName}(비공개)</td>
	      </tr>
	    </c:if>
      <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
    </c:forEach>
  </table>
  <p></p>
</div>
<!-- 블록페이징처리 시작 -->
<div class="container" style="text-align:center;">
  <ul class="pagination justify-content-center">
	  <c:set var="startPageNum" value="${pag - (pag-1)%blockSize}"/>  <!-- 해당블록의 시작페이지 구하기 -->
	  <c:if test="${pag != 1}">
	    <li class="page-item"><a href="pList.pds?pag=1&part=${part}" class="page-link" style="color:#666">◁◁</a></li>
	    <li class="page-item"><a href="pList.pds?pag=${pag-1}&part=${part}" class="page-link" style="color:#666">◀</a></li>
	  </c:if>
	  <c:forEach var="i" begin="0" end="${blockSize-1}"> <!-- 블록의 크기만큼 돌려준다. -->
	    <c:if test="${(startPageNum+i) <= totPage}">
		  	<c:if test="${pag == (startPageNum+i)}">
		  	  <li class="page-item active"><a href="pList.pds?pag=${startPageNum+i}&part=${part}" class="page-link btn btn-secondary active" style="color:#666"><font color="#fff">${startPageNum+i}</font></a></li>
		  	</c:if>
		  	<c:if test="${pag != (startPageNum+i)}">
		  	  <li class="page-item"><a href="pList.pds?pag=${startPageNum+i}&part=${part}" class="page-link" style="color:#666">${startPageNum+i}</a></li>
		  	</c:if>
	  	</c:if>
	  </c:forEach>
	  <c:if test="${pag != totPage}">
	    <li class="page-item"><a href="pList.pds?pag=${pag+1}&part=${part}" class="page-link" style="color:#666">▶</a></li>
	    <li class="page-item"><a href="pList.pds?pag=${totPage}&part=${part}" class="page-link" style="color:#666">▷▷</a></li>
	  </c:if>
  </ul>
</div>
<!-- 블록페이징처리 끝 -->
<p><br/></p>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>