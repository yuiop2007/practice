<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String msg = (String) request.getAttribute("msg");
  String url = (String) request.getAttribute("url");
  String val = (String) request.getAttribute("val");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>message.jsp</title>
  <script>
    var msg = "<%=msg%>";
    var url = "<%=url%>";
    var val = "<%=val%>";
    
    if(msg == "idCheckNo")
    	msg = "아이디를 확인하세요.";
    else if(msg == "nickCheckNo")
    	msg = "닉네임을 확인하세요.";
    else if(msg == "joinOk")
    	msg = "회원 가입완료!!!";
    else if(msg == "joinNo")
    	msg = "회원 가입 실패~~~";
    else if(msg == "loginOk")
    	msg = val + " 회원님 반갑습니다.!!!";
    else if(msg == "loginIdNo")
    	msg = "로그인 실패(아이디를 확인하세요)~~~";
    else if(msg == "loginPwdNo")
    	msg = "로그인 실패(비밀번호를 확인하세요)~~~";
    else if(msg == "logoutOk")
    	msg = val + " 님 로그아웃 되셨습니다.";
    else if(msg == "levelCheckOk")
    	msg = "등급이 변경되었습니다.";
    
    
    
    
    alert(msg);
    if(url != "") location.href = url;
  </script>
</head>
<body>

</body>
</html>