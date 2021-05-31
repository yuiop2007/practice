<%@page import="java.util.List"%>
<%@page import="guest.GuestVO"%>
<%@page import="guest.GuestDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>cj2103 프로젝트</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <%@ include file="../include/bs.jsp" %>
  <style>
	  .fakeimg {
	    height: 200px;
	    background: #aaa;
	  }
  </style>
</head>
<body>
<%@ include file="../include/nav.jsp" %>
<div class="container" style="margin-top:30px">
  <div class="row">
    <div class="col-sm-5">
      <h2>About Me</h2>
      <h5>Photo of me:</h5>
      <div class="fakeimg">Fake Image</div>
      <p>Some text about me in culpa qui officia deserunt mollit anim..</p>
      <h3>Some Links</h3>
      <p>Lorem ipsum dolor sit ame.</p>
      <ul class="nav nav-pills flex-column">
        <li class="nav-item">
          <a class="nav-link active" href="#">Active</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Link</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Link</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="#">Disabled</a>
        </li>
      </ul>
      <hr class="d-sm-none">
    </div>
    <div class="col-sm-7">
      <h2>TITLE HEADING</h2>
      <h5>Title description, Dec 7, 2017</h5>
      <div class="fakeimg">Fake Image</div>
      <p>Some text..</p>
      <p>Sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p>
      <br>
      <h2>방명록</h2>
      <div class="fakeimg" style="padding:20px">
<%
			GuestDAO dao = new GuestDAO();
			GuestVO vo = new GuestVO();
			List<GuestVO> vos = dao.gList(0,7);
			
			for(int i=0; i<vos.size(); i++) {
				vo = vos.get(i);
				String content = vo.getContent();
				if(content.length() > 30) content = vo.getContent().substring(0,20);
				content = content.replace("<", "&lt;");
				content = content.replace(">", "&gt;");
				out.println("- "+content+" ...... "+vo.getName()+"<br/>");
			}
%>
      </div>
      <p>Some text..</p>
      <p>Sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p>
    </div>
  </div>
</div>

<%@ include file="../include/footer.jsp" %>

</body>
</html>
