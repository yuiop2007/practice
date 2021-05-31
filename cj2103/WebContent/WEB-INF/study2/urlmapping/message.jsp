<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String msg = (String) request.getAttribute("msg");
	String url = (String) request.getAttribute("url");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	var msg = "<%=msg%>";
	var url = "<%=url%>";
	
	if(msg == "uInputOk"){
		msg = "정보가 등록되었습니다.";
	}
	else if(msg == "uInputNo"){
		msg = "정보가 등록되지 않았습니다.";
	}
	else if(msg == "uDeleteOk"){
		msg = "정보가 삭제되었습니다.";
	}
	else if(msg == "uDeleteNo"){
		msg = "정보가 삭제되지 않았습니다.";
	}
	else if(msg == "uUpdateOk"){
		msg = "정보가 수정되었습니다.";
	}
	else if(msg == "uUpdateNo"){
		msg = "정보가 수정되지 않았습니다.";
	}
		
	alert(msg);
	if(url != "") location.href=url;
</script>
</head>
<body>

</body>
</html>