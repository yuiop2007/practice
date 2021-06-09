<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>downLoad1.jsp</title>
  <jsp:include page="/include/bs.jsp"/>
</head>
<body>
<jsp:include page="/include/nav.jsp"/>
<div class="container">
  <p><br/></p>
  <h2>파일 다운로드 테스트</h2>
  <p>(서버에 저장된 파일 리스트)</p>
  <hr/>
  <table class="table table-hover">
    <tr class="table-dark text-dark">
      <th>번호</th>
      <th>파일명</th>
      <th>그림파일/일반파일</th>
      <th>삭제</th>
    </tr>
	  <c:forEach var="file" items="${files}" varStatus="st">
	    <tr>
	      <td>${st.count}</td>
	      <td>
	        <%-- <a href="${ctp}/data/pdstest/${file}" download="${file}">${file}</a> --%>
	        <a href="${ctp}/ptDownLoad?file=${file}" download="${file}">${file}</a>
	      </td>
	      <td>
	        <c:set var="fname" value="${fn:split(file,'.')}"/>
	        <c:set var="extName" value="${fn:toLowerCase(fname[fn:length(fname)-1])}"/> 
	        <c:if test="${extName == 'jpg' || extName == 'gif' || extName == 'png'}">
	          <a href="${ctp}/data/pdstest/${file}" download="${file}">
	            <img src="${ctp}/data/pdstest/${file}" width="100px"/>
	          </a>
	        </c:if>
	        <c:if test="${extName != 'jpg' && extName != 'gif' && extName != 'png'}">
	          <a href="${ctp}/data/pdstest/${file}" download="${file}">
	            ${file}
	          </a>
	        </c:if>
	      </td>
	      <td><a href="${ctp}/ptDelete?file=${file}">삭제</a></td>
	    </tr>
	  </c:forEach>
  </table>
  <hr/>
  <div class="row">
    <div class="col">
	    <a href="${ctp}/upLoad1.pt" class="btn btn-outline-secondary form-control">업로드 폼1(싱글파일)으로 돌아가기</a> &nbsp;
	  </div>
    <div class="col">
	    <a href="${ctp}/upLoad2.pt" class="btn btn-outline-secondary form-control">업로드 폼2(멀티파일)으로 돌아가기</a> &nbsp;
	  </div>
    <div class="col">
	    <a href="${ctp}/upLoad3.pt" class="btn btn-outline-secondary form-control">업로드 폼3(멀티파일)으로 돌아가기</a>
	  </div>
  </div>
  <p><br/></p>
</div>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>