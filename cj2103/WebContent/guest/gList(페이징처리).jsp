<%@page import="guest.GuestVO"%>
<%@page import="java.util.List"%>
<%@page import="guest.GuestDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String mid = session.getAttribute("sadmin")==null ? "" : (String) session.getAttribute("sadmin");

  GuestDAO dao = new GuestDAO();
  GuestVO vo = new GuestVO();
  
  /* 페이징처리를 위한 순서
    1. 한 페이지 분량을 정한다. : pageSize = 5건(사용작 정한다.)
    2. 총 레코드 건수를 구한다. : totRecCnt => SQL명령중에서 count(*)함수를 이용한다.
    3. 총 페이지 수를 구한다. :  총레코드수 % 한페이지크기 => 나머지가 0이면   'int(총레코드수/한페이지크기)'
                                                 => 나머지가 0이아니면'int(총레코드수/한페이지크기) + 1'
    4. 현재페이지의 시작 index번호(startIndexNo)를 구한다. => (현재페이지번호 - 1) * 페이지사이즈
    5. 현재 화면에 보이는 방문자 시작번호(curScrStartNo) => (총레코드수 - 현재페이지의 시작index번호)
  */
  /* 페이징 처리 변수 지정 시작 */
  int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
  
  int pageSize = 5;  											// 1. 한페이지의 분량을 5건으로 정한다.
  int totRecCnt = dao.totRecCnt(); 				// 2. 총 레코드 건수를 구한다.
  int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (int)(totRecCnt / pageSize) +1;  // 3. 총페이지수 구하기
  int startIndexNo = (pag - 1) * pageSize;			// 4. 현재페이지의 시작 Index번호구하기
  int curScrStartNo = totRecCnt - startIndexNo;			// 5. 현재 화면에 보이는 방문자 시작번호
  /* 페이징 처리 변수 지정 끝 */
  
  List<GuestVO> vos = dao.gList(startIndexNo, pageSize);  // 지정된 페이지 분량 건수(5건) 만큼 가져오기
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>gList.jsp(방명록 리스트)-페이징처리</title>
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
        <a href="<%=request.getContextPath()%>/guest/gInput.jsp" class="btn btn-outline-secondary btn-sm">글쓰기</a>
<%
        if(!mid.equals("admin")) {
          out.println("<a href='adminLogin.jsp' class='btn btn-outline-secondary btn-sm'>관리자</a>");
        } else {
          out.println("<a href='"+request.getContextPath()+"/AdminLogout' class='btn btn-outline-secondary btn-sm'>관리자 로그아웃</a>");
        }
%>
      </td>
      <td style="text-align:right;">
      	<!-- 페이징처리 시작 -->
				<div style="text-align:right">
				<% if(pag != 1) { %>
				     [<a href="gList.jsp?pag=1">1Page</a>]....
				<% } %>
				<% if(pag > 1) { %>
							<a href="gList.jsp?pag=<%=pag-1%>">◀</a>
				<% } %>
					<%=pag %>Page / <%=totPage %>Pages
				<% if(pag < totPage) { %>
							<a href="gList.jsp?pag=<%=pag+1%>">▶</a>
				<% } %>
				<% if(pag != totPage) { %>
				     ....[<a href="gList.jsp?pag=<%=totPage%>">Last</a>]
				<% } %>
				</div>
				<!-- 페이징처리 끝 -->
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
        방문번호 : <%=curScrStartNo %> &nbsp;
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
		curScrStartNo--;
  }
%>
</div>
<!-- 페이징처리 시작 -->
<div style="text-align:center">
<% if(pag != 1) { %>
     [<a href="gList.jsp?pag=1">1페이지</a>]....
<% } %>
<% if(pag > 1) { %>
			[<a href="gList.jsp?pag=<%=pag-1%>">이전페이지</a>]
<% } %>
	<%=pag %>Page / <%=totPage %>Pages
<% if(pag < totPage) { %>
			[<a href="gList.jsp?pag=<%=pag+1%>">다음페이지</a>]
<% } %>
<% if(pag != totPage) { %>
     ....[<a href="gList.jsp?pag=<%=totPage%>">마지막페이지</a>]
<% } %>
</div>
<!-- 페이징처리 끝 -->
<p><br/></p>
<%@ include file="../../include/footer.jsp" %>
</body>
</html>