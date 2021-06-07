<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  int level = session.getAttribute("slevel")==null ? 99 : (int) session.getAttribute("slevel");

	//String atom = request.getParameter("atom");
%>
<style>
  .navbar-nav > a {color:#ccc !important;}
  .navbar-nav  a:hover {color:#fff !important; background-color:#aaa;}
</style>
<script>
  function mDelete() {
	  var ans = confirm("탈퇴 하시겠습니까?");
	  if(ans) {
		  var ans2 = confirm("탈퇴후 1개월동안은 같은 아이디로 가입하실 수 없습니다.\n탈퇴를 계속 진행하시겠습니까?");
		  if(ans2) {
			  location.href="<%=request.getContextPath()%>/mDelete.mem";
		  }
	  }
  }
</script>
<div class="jumbotron text-center" style="margin-bottom:0; padding:20px 0;">
  <h1>cj2103 Web Project</h1>
  <p>본 사이트는 반응형으로 제작되었습니다.<%-- (<%//=atom %>:${param.atom}) --%></p> 
</div>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <a class="navbar-brand" href="<%=request.getContextPath()%>/">HOME</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/guest/gList.jsp">Guest</a>
      </li>
<%    if(level != 99) { %>
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/bList.bo">Board</a>
      </li>
<%      if(level != 1) { %>
      <li class="nav-item">
        <a class="nav-link" href="#">Data</a>
<%      } %>
      </li>
      <li class="nav-item dropdown">
	      <a class="nav-link dropdown-toggle btn btn-secondary btn-sm btn-sub" href="#" id="navbardrop" data-toggle="dropdown">My Page</a>
	      <div class="dropdown-menu">
	        <a class="dropdown-item" href="<%=request.getContextPath()%>/memberMain.mem">회원방</a>
	        <a class="dropdown-item" href="<%=request.getContextPath()%>/mUpdate.mem">회원정보변경</a>
<%	        if(level != 1) { %>
	        		<a class="dropdown-item" href="<%=request.getContextPath()%>/aMList.ad">회원리스트</a>
<%          } %>
<%        if(level != 0) { %>
	          <a class="dropdown-item" href="javascript:mDelete()">회원탈퇴</a>
<%        } %>
<%        if(level == 0) { %>
	          <a class="dropdown-item" href="<%=request.getContextPath()%>/aMain.ad">관리자</a>
<%        } %>
	      </div>
	    </li> &nbsp;&nbsp;
<%      if(level != 1) { %>	    
      <li class="nav-item dropdown">
	      <a class="nav-link dropdown-toggle btn btn-secondary btn-sm btn-sub" href="#" id="navbardrop" data-toggle="dropdown">학습실1</a>
	      <div class="dropdown-menu">
	        <a class="dropdown-item" href="<%=request.getContextPath()%>/urlMapping.um">URL 매핑</a>
	        <a class="dropdown-item" href="<%=request.getContextPath()%>/password">비밀번호암호화</a>
	        <a class="dropdown-item" href="<%=request.getContextPath()%>/jstl.st">JSTL</a>
	        <a class="dropdown-item" href="<%=request.getContextPath()%>/upLoad1.pt">PdsTest1</a>
	      </div>
	    </li> 
<%      } %>
<%    } %>
<%    if(level == 99) { %>
	    <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/login.mem">LogIn</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/join.mem">Join</a>
      </li>
<%    } else { %>
				<li class="nav-item">
	        <a class="nav-link" href="<%=request.getContextPath()%>/logout.mem">LogOut</a>
	      </li>
<%    } %>
    </ul>
  </div>  
</nav>