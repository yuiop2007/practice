<%@page import="study.urlmapping.UrlMappingVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  List<UrlMappingVO> vos = (List<UrlMappingVO>) request.getAttribute("vos");
	int idx = request.getParameter("idx")== null ? 0 : Integer.parseInt(request.getParameter("idx"));
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>urlMappingList.jsp</title>
  <%@ include file="/include/bs.jsp" %>
  <style>
    th {background-color: #ccc;}
  </style>
  <script>
  	function delCheck(idx) {
		var ans = confirm("삭제하시겠습니까?");
		if(ans){
			location.href = "<%=request.getContextPath() %>/uDelete.um?idx="+idx;
		}
	}
  </script>
</head>
<body>
<%@ include file="/include/nav.jsp" %>
<div class="container">
  <p><br/></p>
  <h2>정 보 리 스 트</h2>
  <br/>
  <div>
  	<button type="button" onclick="location.href='<%=request.getContextPath()%>/urlMapping.um';" class="btn btn-secondary brn-sm">돌아가기</button>
  	<button type="button" onclick="location.href='<%=request.getContextPath() %>/uInput.um';" class="btn btn-secondary brn-sm">등록하기</button>
  </div>
  <table class="table table-hover">
    <tr>
      <th>번호</th>
      <th>성명</th>
      <th>나이</th>
      <th>비고</th>
    </tr>
<%	
    for(UrlMappingVO vo : vos) {
    	if(vo.getIdx()==idx){
%>		
		<form name="myform" method="post" action="<%=request.getContextPath()%>/uUpdate.um">
	    <tr>
	      <td><input type="number" name="idx" value="<%=vo.getIdx()%>" readonly /></td>
	      <td><input type="text" name="name" value="<%=vo.getName()%>" autofocus/></td>
	      <td><input type="number" name="age" value="<%=vo.getAge()%>"/></td>
	      <td>
	      	<a href="javascript:delCheck(<%=vo.getIdx()%>)" class="btn btn-outline-secondary btn-sm">삭제</a>&nbsp;
	     	<a href="<%=request.getContextPath() %>/uList.um?idx=<%=vo.getIdx()%>" class="btn btn-outline-secondary btn-sm">수정</a>
	     	<input type="submit" value="완료" class="btn btn-outline-secondary btn-sm"/>
	     	<a href="<%=request.getContextPath() %>/uList.um?" class="btn btn-outline-secondary btn-sm">취소</a>
	      </td>
	    </tr>
	    </form>
<%
    	}
    	else {
%>
	    <tr>
	      <td><%=vo.getIdx()%></td>
	      <td><%=vo.getName()%></td>
	      <td><%=vo.getAge()%></td>
	      <td>
	      	<a href="javascript:delCheck(<%=vo.getIdx()%>)" class="btn btn-outline-secondary btn-sm">삭제</a>&nbsp;
	     	<a href="<%=request.getContextPath() %>/uList.um?idx=<%=vo.getIdx()%>" class="btn btn-outline-secondary btn-sm">수정</a>
	      </td>
	    </tr>
<%
    	}
    }
%>
  </table>
  <p><br/></p>
</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>