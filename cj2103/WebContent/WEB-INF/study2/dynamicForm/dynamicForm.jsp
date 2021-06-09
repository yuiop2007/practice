<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>dynamicForm.jsp</title>
  <jsp:include page="/include/bs.jsp"/>
  <script>
    var addTbl;
    function insRow() {
    	addTbl = document.getElementById("addTable");
    	var addRow = addTbl.insertRow(); // addTbl을 행의 개념으로 한개 추가한다.
    	addRow.onmouseover = function() {
    		addTbl.clickRowIndex = this.rowIndex;
    	}
    	var addCell = addRow.insertCell(); // 앞에서 클릭한 row의 위치를 얻어서, 테이블의 해당행에 셀을 삽입한다.
    	
    	var formTag = "";
    	formTag += "<input type=text name=addText style='width:400px;'/> ";
    	formTag += "<input type='button' value='삭제' onclick='removeRow()' style='cursor:hand'/>";
    	addCell.innerHTML = formTag;
    }
    
    // 삽입된 행(테이블) 삭제..
    function removeRow() {
    	addTbl.deleteRow(addTbl.clickRowIndex);
    }
    
    function fCheck() {
    	if(myform.title.value == "") {
    		alert("설문 주제를 입력하세요?");
    		myform.title.focus();
    		return false;
    	}
    	for(var i=0; i<myform.elements.length; i++) {
    		if(myform.elements[i].name == "addText") {
    			if(myform.elements[i].value == "") {
    				alert("텍스트박스에 값을 입력하세요!");
    				myform.elements[i].focus();
    				return false;
    			}
    		}
    	}
    	
    	var result = "";
    	for(var i=0; i<myform.elements.length; i++) {
    		if(myform.elements[i].name == "addText") {
    			result += myform.elements[i].value + "/";
    		}
    	}
    	result = result.substring(0, result.length-1);
    	alert("설문주제 : " + myform.title.value + "\n" + result);
    }
  </script>
</head>
<body>
<jsp:include page="/include/nav.jsp"/>
<div class="container">
  <p><br/></p>
  <form name="myform" method="post" action="${ctp}/dynamicFormOk.jsp">
    <table class="table table-borderless">
      <tr>
        <td><h2>설문 주제 등록(동적폼 연습)</h2></td>
      </tr>
      <tr>
        <td>설문 주제 : &nbsp;
          <input type="text" name="title" style="width:500px;"/>
        </td>
      </tr>
  	</table>
  	<hr/>
  	<table>
  	  <tr>
  	    <td>
  	      <input type="button" value="설문항목추가" onclick="insRow()" style="cursor:hand"/>
  	    </td>
  	  </tr>
  	  <tr>
  	    <td>
  	      <table id="addTable">
  	        <tr>
  	          <td><input type="text" name="addText" style="width:400px;"/>
  	        </tr>
  	      </table>
  	    </td>
  	  </tr>
  	</table>
  	<br/>
  	<table>
  	  <tr>
  	    <td style="text-align:center;">
  	      <input type="button" value="확인" onclick="fCheck()"/>
  	      <input type="reset" value="다시입력"/>
  	      <input type="button" value="초기화" onclick="location.reload()"/>
  	    </td>
  	  </tr>
  	</table>
  </form>
  <p><br/></p>
</div>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>