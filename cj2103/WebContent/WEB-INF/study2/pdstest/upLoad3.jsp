<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>upLoad3.jsp(멀티파일 업로드)</title>
  <jsp:include page="/include/bs.jsp"/>
  <script>
    function fCheck() {
    	var fname = myform.fname1.value;
    	var ext = fname.substring(fname.lastIndexOf(".")+1);  // 확장자 발
      var uExt = ext.toUpperCase();
      var maxSize = 1024 * 1024 * 10; // 최대 10MByte허용
      
      if(fname == "") {
    	  alert("업로드할 파일을 선택하세요?");
    	  return false;
      }
      var fLength = document.getElementById("fname1").files.length;
      var fileSize = 0;
      for(var i=0; i<fLength; i++) {
    	  var fname = document.getElementById("fname1").files[i].name;
    	  var ext = fname.substring(fname.lastIndexOf(".")+1);  // 확장자 발
        var uExt = ext.toUpperCase();
      	fileSize += document.getElementById("fname1").files[i].size;
      
	      if(uExt != "ZIP" && uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "HWP" && uExt != "PPT" && uExt != "PPTX") {
	    	  alert("업로드 가능한 파일은 'ZIP/JPG/GIF/PNG/HWP'입니다.");
	    	  return false;
	      }
	      else if(fname.indexOf(" ") != -1) {
	    	  alert("업로드하는 파일에는 공백이 포함될 수 없습니다.");
	    	  return false;
	      }
      }
	    if(fileSize > maxSize) {
    	  alert("업로드하는 파일의 최대용량은 10MByte 입니다.");
    	  return false;
      }
      else {
	      myform.submit();
      }
    }
  </script>
</head>
<body>
<jsp:include page="/include/nav.jsp"/>
<div class="container">
  <p><br/></p>
  <form name="myform" method="post" action="${ctp}/upLoadOk2.pt" enctype="Multipart/form-data">
  	<h2>파일 업로드 테스트(멀티파일처리)</h2>
  	<p>cos라이브러리를 이용한 파일 업로드</p>
  	<hr/>
  	<br/>
  	<div class="form-group">파일명
  		<input type="file" name="fname1" id="fname1" multiple class="form-control-file border" style="height:40px;"/>
  		<input type="button" value="파일전송" class="btn btn-secondary form-control" onclick="fCheck()"/>
  	</div> 
  </form>
  <hr/><br/>
  <p><a href="${ctp}/downLoad1.pt" class="btn btn-secondary form-control">다운로드 폼으로 이동하기</a></p>
  <p><br/></p>
</div>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>