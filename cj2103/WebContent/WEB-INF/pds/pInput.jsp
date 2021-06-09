<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>pInput.jsp</title>
  <jsp:include page="/include/bs.jsp"/>
  
  <script>
    var cnt = 1;
    
    function fileAdd() {
    	cnt++;
    	var fileIn = "";
    	fileIn += "<div id='fBox"+cnt+"'>";
    	fileIn += "<input type='file' name='fname"+cnt+"' id='fname"+cnt+"' class='form-control-file border' style='float:left; width:85%;' accept='.jpg,.gif,.png,.zip,.ppt,.pptx,.hwp'/>";
    	fileIn += "<input type='button' value='삭제' onclick='deleteBox("+cnt+")' class='btn btn-outline-secondary' style='width:10%;margin-left:10px;padding:3px 0px;'/>";
    	fileIn += "</div>";
    	$("#fileInsert").append(fileIn);
    }
    
    function deleteBox(cnt) {
    	$("#fBox"+cnt).remove();
    }
    
    // 파일 업로드 체크
    function fCheck() {
    	var fname = myform.fname1.value;
      var maxSize = 1024 * 1024 * 10; // 최대 10MByte허용
      var title = myform.title.value;
      var pwd = myform.pwd.value;
      
      if(fname == "") {
    	  alert("업로드할 파일을 선택하세요?");
    	  return false;
      }
      else if(title == "") {
    	  alert("파일 제목을 입력하세요?");
    	  myform.title.focus();
    	  return false;
      }
      else if(pwd == "") {
    	  alert("비밀번호를 입력하세요?");
    	  myform.pwd.focus();
    	  return false;
      }
      
  	  var fileSize = 0;
  	  for(var i=1; i<=cnt; i++) {
  		  fname = "fname" + i;
	  	  tempFname = fname;
  	  	if(document.getElementById(fname).value != "" && document.getElementById(fname).value != null) {
  	  	  fname = document.getElementById(fname).value
  	  		var ext = fname.substring(fname.lastIndexOf(".")+1);  // 확장자 발
	        var uExt = ext.toUpperCase();
	        
	        if(uExt != "ZIP" && uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "HWP" && uExt != "PPT" && uExt != "PPTX") {
	      	  alert("업로드 가능한 파일은 'ZIP/JPG/GIF/PNG/HWP'입니다.");
	      	  return false;
	        }
	        else if(fname.indexOf(" ") != -1) {
	      	  alert("업로드하는 파일에는 공백이 포함될 수 없습니다.");
	      	  return false;
	        }
	        else {
  	  			fileSize += document.getElementById(tempFname).files[0].size;
	        }
  	  	}
  	  }
  	  if(fileSize > maxSize) {
    	  alert("업로드하는 파일의 최대용량은 10MByte 입니다.");
    	  return false;
  	  }
  	  else {
  		  myform.fSize.value = fileSize;
  		  myform.submit();
  	  }
      
    }
  </script>
</head>
<body>
<jsp:include page="/include/nav.jsp"/>
<div class="container">
  <p><br/></p>
  <form name="myform" method="post" action="${ctp}/pInputOk.pds" enctype="multipart/form-data">
    <h2>자료 올리기</h2>
    <div class="form-group">
      <input type="button" value="파일추가" onclick="fileAdd()"/>
      <input type="file" name="fname1" id="fname1" class="form-control-file border" accept=".jpg,.gif,.png,.zip,.ppt,.pptx,.hwp"/>
    </div>
    <div class="form-group" id="fileInsert"></div>
    <div class="form-group">
      올린이 : ${snickname}
    </div>
    <div class="form-group">
      <label for="title">자료제목 : </label>
      <input type="text" name="title" id="title" placeholder="자료 제목을 입력하세요" class="form-control" required/>
    </div>
    <div class="form-group">
      <label for="content">자료내용 : </label>
      <textarea rows="4" name="content" id="content" class="form-control" required></textarea>
    </div>
    <div class="form-group">
      <label for="part">자료분류 : </label>
      <select name="part" class="form-control">
        <option value="학습" selected>학습</option>
        <option value="여행">여행</option>
        <option value="음식">음식</option>
        <option value="기타">기타</option>
      </select>
    </div>
    <div class="form-group">
      <label>공개여부 : </label> &nbsp; &nbsp; &nbsp;
      <input type="radio" name="openSw" id="openSw" value="공개" checked/>공개 &nbsp; &nbsp;
      <input type="radio" name="openSw" id="openSw" value="비공개"/>비공개 &nbsp;
    </div>
    <div class="form-group">
      <label for="pwd">비밀번호 : </label>
      <input type="password" name="pwd" id="pwd" class="form-control" required/>
    </div>
    <div class="form-group">
      <input type="button" value="자료올리기" class="btn btn-secondary" onclick="fCheck()"/>
      <input type="reset" value="다시쓰기" class="btn btn-secondary"/>
      <input type="button" value="돌아가기" class="btn btn-secondary" onclick="location.href='${ctp}/pList.pds';"/>
    </div>
    <input type="hidden" name="fSize"/>
    <input type="hidden" name="mid" value="${smid}"/>
    <input type="hidden" name="nickName" value="${snickname}"/>
  </form>
  <p><br/></p>
</div>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>