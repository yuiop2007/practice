<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%
  // Calendar.Month 값? 0~11  (1월~12월)
  // Calendar.DAY_OF_WEEK 값? 1~7 (일~토)

  Calendar calToday = Calendar.getInstance();	// 오늘 날짜를 저장
  Calendar cal = Calendar.getInstance();      // (오늘날짜)를 화면에 표시용도로 사용
  
  int yy = request.getParameter("yy")==null ? cal.get(Calendar.YEAR) : Integer.parseInt(request.getParameter("yy"));
  int mm = request.getParameter("mm")==null ? cal.get(Calendar.MONTH) : Integer.parseInt(request.getParameter("mm"));
  
  cal.set(yy, mm, 1);
  int startWeek = cal.get(Calendar.DAY_OF_WEEK);
  
  int prevYear = yy;  			// 전년도
  int prevMonth = (mm) - 1; // 이전월
  int nextYear = yy;  			// 다음년도
  int nextMonth = (mm) + 1; // 다음월
  
  if(prevMonth < 0) {
  	prevYear--;
  	prevMonth = 11;
  }
  
  if(nextMonth > 11) {
  	nextYear++;
  	nextMonth = 0;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>calendar.jsp</title>
  <jsp:include page="/include/bs.jsp"/>
</head>
<body>
<jsp:include page="/include/nav.jsp"/>
<div class="container">
  <p><br/></p>
  <h2>달력연습(
    <a href="${ctp}/calendar.st?yy=<%=prevYear-1%>&mm=<%=mm%>">◀</a>
    <a href="${ctp}/calendar.st?yy=<%=prevYear%>&mm=<%=prevMonth%>">◁</a>
    &nbsp;<%=yy%>년 <%=mm+1 %>월&nbsp;
    <a href="${ctp}/calendar.st?yy=<%=nextYear%>&mm=<%=nextMonth%>">▷</a>
    <a href="${ctp}/calendar.st?yy=<%=nextYear+1%>&mm=<%=mm%>">▶</a>
  )</h2>
  <br/>
  <table class="table">
    <tr>
      <th><font color="red">일</font></th>
      <th>월</th>
      <th>화</th>
      <th>수</th>
      <th>목</th>
      <th>금</th>
      <th><font color="blue">토</font></th>
    </tr>
    <tr>
<%
    for(int i=1; i<startWeek; i++) {
    	out.println("<td>&nbsp;</td>");
    }
    while(cal.get(Calendar.MONTH) == mm) {
    	if(cal.get(Calendar.YEAR)==calToday.get(Calendar.YEAR) && cal.get(Calendar.MONTH)==calToday.get(Calendar.MONTH) && cal.get(Calendar.DATE)==calToday.get(Calendar.DATE)) {
    		out.println("<td style='background-color:skyblue'><b>"+cal.get(Calendar.DATE)+"</b></td>");
    	}
    	else if(cal.get(Calendar.DAY_OF_WEEK) == 1) {
    		out.println("<td style='color:red'>"+cal.get(Calendar.DATE)+"</td>");
    	}
    	else if(cal.get(Calendar.DAY_OF_WEEK) == 7) {
    		out.println("<td style='color:blue'>"+cal.get(Calendar.DATE)+"</td>");
    	}
    	else {
    		out.println("<td>"+cal.get(Calendar.DATE)+"</td>");
    	}
    	
    	if(cal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY) {
    		out.println("</tr><tr>");
    	}
    	
    	cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.get(Calendar.DATE)+1);
    	
    }
  	if(cal.get(Calendar.DAY_OF_WEEK) <= 7) {
  		for(int i=cal.get(Calendar.DAY_OF_WEEK); i<=7; i++) {
  			out.println("<td>&nbsp;</td>");
  		}
  	}
%>
    </tr>
  </table>
  <p><br/></p>
</div>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>