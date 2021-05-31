<%@page import="guest.GuestVO"%>
<%@page import="java.util.List"%>
<%@page import="guest.GuestDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String mid = session.getAttribute("sadmin")==null ? "" : (String) session.getAttribute("sadmin");

  GuestDAO dao = new GuestDAO();
  List<GuestVO> vos = dao.gList(0,5);
  GuestVO vo = new GuestVO();
  
  int curScrNo = vos.size();
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>gList.jsp(방명록 리스트)-일반</title>
  <%@ include file="../../include/bs.jsp" %>
  <style>
    th {
      background-color: #ccc;
      text-align: center;
    }
  </style>
  <script>
    // 게시글 삭제함수 : 해당 게시글의 고유번호(idx)를 받아서 삭제서블릿(gDelete_comment)호출
    function delCheck(idx) {
    	var ans = confirm("게시글을 삭제 하시겠습니까?");
    	if(ans) location.href="<%=request.getContextPath()%>/gDelete_comment?idx="+idx;
    }
  </script>
</head>
<body>
<%@ include file="../../include/nav.jsp" %>
<div class="container">
  <p><br/></p>
  <table class="table table-borderless">
    <tr>
      <th colspan="2" style="text-align:center; background-color:#fff"><h2>방 명 록 리 스 트</h2></th>
    </tr>
    <tr>
      <td>
<%
        if(!mid.equals("admin")) {
          out.println("<a href='adminLogin.jsp' class='btn btn-outline-secondary btn-sm'>관리자</a>");
        } else {
          out.println("<a href='"+request.getContextPath()+"/AdminLogout' class='btn btn-outline-secondary btn-sm'>관리자 로그아웃</a>");
        }
%>
      </td>
      <td style="text-align:right;">
        <a href="<%=request.getContextPath()%>/guest/gInput.jsp" class="btn btn-outline-secondary btn-sm">글쓰기</a>
      </td>
    </tr>
  </table>
<%
	for(int i=0; i<vos.size(); i++) {
		vo = vos.get(i);
		
		String email = vo.getEmail();
		if(email.equals("") || email == null) email = "-없음-";
		
		String homepage = vo.getHomepage();
		//if(homepage.length() <= 8) homepage = "-없음-";
		
		String vdate = vo.getVdate().substring(0, vo.getVdate().length()-2);
		
		String content = vo.getContent().replace("\n", "<br/>");
		// content = content.replace("<", "&lt;");
		// content = content.replace(">", "&gt;");
%>
  <table class="table table-borderless">
    <tr>
      <td>
        방문번호 : <%=curScrNo %> &nbsp;
<%
				if(mid.equals("admin")) {
					/* out.println("<a href='"+request.getContextPath()+"/gDelete' class='btn btn-outline-secondary btn-sm'>삭제</a>"); */	
					out.println("<a href='javascript:delCheck("+vo.getIdx()+")' class='btn btn-outline-secondary btn-sm'>삭제</a>");	
				}
%>
      </td>
      <td style="text-align:right;">방문IP : <%=vo.getHostip() %></td>
    </tr>
  </table>
  <table class="table table-bordered">
  	<tr>
  	  <th style="width:10%;">성명</th>
  	  <td style="width:35%;"><%=vo.getName() %></td>
  	  <th style="width:10%;">전자우편</th>
  	  <td style="width:45%;"><%=email %></td>
  	</tr>
  	<tr>
  	  <th>방문일자</th>
  	  <td><%=vdate %></td>
  	  <th>홈페이지</th>
  	  <td>
<%
        if(homepage.length() <= 8) {
          out.println("-없음-");
				}
				else {
  	      out.println("<a href="+homepage+" target='_blank'>"+homepage+"</a>");
        }
%>
			</td>
  	</tr>
  	<tr>
  	  <th>방문소감</th>
  	  <td colspan="3"><%=content %></td>
  	</tr>
  </table>
  <br/>
<%
		curScrNo--;
  }
%>
</div>
<%@ include file="../../include/footer.jsp" %>
</body>
</html>