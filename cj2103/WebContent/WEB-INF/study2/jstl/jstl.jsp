<%@page import="study.urlmapping.UrlMappingVO"%>
<%@page import="java.util.List"%>
<%@page import="study.urlmapping.UrlMappingDAO"%>
<%@page import="member.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>jstl.jsp</title>
  <%@ include file="/include/bs.jsp" %>
</head>
<body>
<%@ include file="/include/nav.jsp" %>
<div class="container">
  <p><br/></p>
  <h2>JSTL 연습</h2>
  <br/>
  <h3>Core라이브러리 : 변수와 제어문에 관련된사항</h3>
  <div>
    <b>변수 선언하기</b><br/>
    c:set => 변수 설정<br/>
    c:out => 값(변수) 출력<br/>
    c:remove => 설정한 변수를 제거<br/>
    c:catch => 예외처리<br/>
    <c:set var="su1" value="100"/>
    <c:set var="su2" value="200"/>
    변수의 값? <c:out value="500"/><br/>
    su1변수의 값? <c:out value="${su1}"/><br/>
    su2변수의 값? <c:out value="${su2}"/><br/>
    su1 + su2변수의 값? <c:out value="${su1 + su2}"/><br/>
    su1 + su2변수의 값? ${su1 + su2}<br/>
  </div>
  <div>
  <%
    MemberVO vo = new MemberVO();
    vo.setName("홍길동");
    vo.setAddress("서울");
    vo.setLevel(99);
    request.setAttribute("vo", vo);
  %>
	  VO의 객체의 name : ${vo.name}<br/>
	  VO의 객체의 address : ${vo.address}<br/>
	  VO의 객체의 level : ${vo.level}<br/>
  	MemberVO객체안의 name필드의 값을 jstl변수로 받아오고자 한다. ==>
  	<%-- <%=vo.getName() %> --%>
  	<c:set var="name" value="${vo.name}"/>
  	<c:out value="${name}"/> == ${name}<br/>
  	c:set으로 선언한 name변수의 값을 vo객체의 name변수에 저장? =>
  	<c:set var="name" value="강감찬"/>
  	<c:set target="${vo}" property="name" value="${name}"/><br/>
  	vo객체의 name : <%=vo.getName() %><br/>
  </div>
  <hr/>
  <h3>제어문</h3>
  <div>
    <h4>c:if 태그 => 조건식</h4>
    <c:if test="${su1 > 200}">su1이 200보다 큽니다.</c:if><br/>
    <c:if test="${su1 < 200}">su1이 200보다 작습니다.</c:if><br/>
    <c:if test="${su1 == 200}">su1이 200과 같습니다.</c:if><br/>
    <b>jstl의 다중조건식 :  choose -> when(조건식) ~ otherwise</b><br/>
    <c:choose>
      <c:when test="${su > 200}">su1이 200보다 큽니다.</c:when>
      <c:when test="${su < 200}">su1이 200보다 작습니다.</c:when>
      <c:otherwise>su1이 200과 같습니다.</c:otherwise>
    </c:choose><br/>
    <p>점수를 c:set 변수 jumsu에 값(점수)를 기억시키고, 학점을 grade변수에 담아 출력하세요(A/B/C/D/F)</p>
    <c:set var="jumsu" value="85"/>
    <c:choose>
      <c:when test="${jumsu >= 90}">
        <c:set var="grade" value="A학점"/>
      </c:when>
      <c:when test="${jumsu >= 80}">
        <c:set var="grade" value="B학점"/>
      </c:when>
      <c:when test="${jumsu >= 70}">
        <c:set var="grade" value="C학점"/>
      </c:when>
      <c:when test="${jumsu >= 60}">
        <c:set var="grade" value="D학점"/>
      </c:when>
      <c:otherwise>
        <c:set var="grade" value="F학점"/>
      </c:otherwise>
    </c:choose>
    - 입력된 점수 : ${jumsu}점, 학점 : ${grade} 입니다.<br/>
    (문제) 국어점수 : 90, 영어점수 : 30점 의 성적을 판별하시오?
    (평균이 60점 이상이고, 과락은 40점이다.)<br/>
    비고 :
    <c:set var="kor" value="90"/>
    <c:set var="eng" value="30"/>
    <c:set var="tot" value="${kor + eng}"/>
    <c:set var="avg" value="${tot / 2}"/>
    총점: ${tot} / 평균 ${avg} / 판별 : 
    <c:if test="${avg >=60 && kor >= 40 && eng >= 40}">합격</c:if> 
    <c:if test="${avg <60 || kor < 40 || eng < 40}">불합격</c:if> 
    <br/>
    <c:choose>
      <c:when test="${avg >=60 && kor >= 40 && eng >= 40}">합격</c:when>
      <c:otherwise>불합격</c:otherwise>
    </c:choose>
  </div>
  <h4>EL연산자</h4>
  + , - , * , / , %(나머지) , &&(and) , ||(or) , !(not) , ==(같다) , !=(같지않다) , > , < , >= , <=<br/>
  <hr/>
  <div>
    <h3>반복문(forEach)</h3>
    <c:forEach var="no" begin="1" end="10" step="1">
      안녕!!<br/>
    </c:forEach><br/>
    
    <c:forEach var="no" begin="1" end="10" step="1">
      ${no}. 안녕!!<br/>
    </c:forEach><br/>
    
    <c:forEach var="no" begin="1" end="10" step="1" varStatus="st">
      ${no}. 안녕!!<br/>
    </c:forEach><br/>
    
    <c:forEach begin="1" end="10" step="1" varStatus="st">
      ${st.count}. 안녕!!<br/>
    </c:forEach><br/>
    
    <p>객체 출력</p>
<%
    UrlMappingDAO dao = new UrlMappingDAO();
    List<UrlMappingVO> vos = dao.getUrlMappingList();
    request.setAttribute("vos", vos);
%>
    <c:forEach var="vo" items="${vos}">
      - 번호 : ${vo.idx} /
      - 성명 : ${vo.name} /
      - 나이 : ${vo.age}<br/> 
    </c:forEach><br/><hr/>
    
    <c:forEach var="vo" items="${vos}" varStatus="st">
      - ${st.index}. 번호 : ${vo.idx} /
      - ${st.count}. 성명 : ${vo.name} /
      - 나이 : ${vo.age}<br/> 
    </c:forEach><br/><hr/>
    
    <c:forEach var="vo" items="${vos}" varStatus="st">
      - 시작값 : ${st.first}<br/>
      - 마지막값 : ${st.last}<br/>
    </c:forEach><br/><hr/>
    
    <c:forEach var="aRow" begin="1" end="5" step="1">
    	<c:forEach var="aColumn" begin="1" end="10" step="1">
         ${aColumn} /
    	</c:forEach>
    	<br/>
    </c:forEach><hr/>
    
<%
    String mnt = "백두산/한라산/태백산/소백산/천태산/북한산/도봉산";
    request.setAttribute("mnt", mnt);
%>
    <h4>forTokens : 특정 기호를 기준으로 값을 분리</h4>
    <c:forTokens var="m" items="${mnt}" delims="/">
      ${m} ,
    </c:forTokens><hr/>
    
    <c:forTokens var="m" items="${mnt}" delims="/">
      <c:if test="${m == '한라산'}"><font color="red">${m}</font></c:if>
      <c:if test="${m == '소백산'}"><font color="blue">${m}</font></c:if>
      <c:if test="${m != '한라산' && m != '소백산' }"><font color="pink">${m}</font></c:if>
    </c:forTokens><hr/>
    
    <h2>사용예</h2>
    <p><a href="<%=request.getContextPath()%>/ulist.st">User리스트</a></p>
  </div>
  <br/><hr/>
  <div>
    <h3>Function 라이브러리</h3>
<%
    String atom = "Welcome to My Homepage!";
		request.setAttribute("atom", atom);
%>
    atom의 길이 : <%=atom.length() %><br/>
    저장소 atom의 길이 : ${fn:length(atom)}<br/>
    <c:set var="str" value="Welcome to My Homepage!"/>
    - 문자열의 길이 : ${fn:length(str)}<br/>
    - 대문자 변환 : ${fn:toUpperCase(atom)}<br/>
    - 소문자 변환 : ${fn:toLowerCase(atom)}<br/>
    - substring : ${fn:substring(atom,0,3)}<br/>
    - substring : ${fn:substring(atom,3,6)}<br/>
    <c:set var="varAtom" value="${fn:substring(atom,3,6)}"/>
    - varAtom의 길이 : ${fn:length(varAtom)}<br/>
    - varAtom의 길이 : ${fn:length(fn:substring(atom,3,6))}<br/>
    - indexOf함수 : ${fn:indexOf(atom, 'o')}<br/>
    - indexOf함수 : ${fn:indexOf(atom, 'A')}<br/>
    - atom변수안의 문자중, '2번째' 위치한 'o'문자의 앞위치까지 발췌? ${fn:substringBefore(atom,'o')}<br/>
    - atom변수안의 문자중, '2번째' 위치한 'o'문자의 뒤위치 모두 발췌? ${fn:substringAfter(atom,'o')}<br/>
    - atom변수안의 문자중, 첫번째 'o'문자부터 두번째 만나는 'o' 글자사이의 문자를 발췌? 
      <c:set var="sbs" value="${fn:substring(atom,fn:indexOf(atom,'o')+1,fn:length(atom))}"/>
      ---sbs변수값은? ${sbs}<br/>
      결과1 ==> ${fn:substring(sbs,0,fn:indexOf(sbs,'o'))} /
      결과2 ==> ${fn:substring(fn:substring(atom,fn:indexOf(atom,'o')+1,fn:length(atom)),0,fn:indexOf(sbs,'o'))} /
      결과3 ==> ${fn:substring(fn:substringAfter(atom,'o'),0,fn:indexOf(fn:substringAfter(atom,'o'),'o'))}
  </div>
  <hr/>
  <div>
  <%
    String mbc = "Seoul";
    request.setAttribute("mbc", mbc);
    request.setAttribute("kbs", "    kbs    ");
    request.setAttribute("cjb", "    cjb 방 송 국 ");
  %>
  : 문자열의 결합 : ${mbc}${kbs}${cjb}<br/>
  : 공백무시(trim(변수))한 결합 : ${fn:trim(mbc)}${fn:trim(kbs)}${fn:trim(cjb)}<br/>
  : 문자열치환(replace(변수,원본문자,치환할문자)) : ${fn:replace(mbc,'ou','u')}<br/>
  : 안쪽 공백을 포함한 무시(mbc+kbs+cjb) ? 
    ${fn:replace(mbc,' ','')}${fn:replace(kbs,' ','')}${fn:replace(cjb,' ','')}<br/>
    <c:set var="imsi" value="${mbc}${kbs}${cjb}"/>
    ${imsi}<br/>
    ${fn:replace(imsi,' ','')}<br/>
  </div>
  <hr/>
  <div>
    <h3>특정문자로 시작하는지의 유무를 판단? startsWith(문자열, 시작문자열)</h3>
    - mbc변수의 값이 'm'으로 시작하는지의 판단? ${fn:startsWith(mbc,'m')}<br/>
    - mbc변수의 값이 's'으로 시작하는지의 판단? ${fn:startsWith(mbc,'s')}<br/>
    - mbc변수의 값이 'S'으로 시작하는지의 판단? ${fn:startsWith(mbc,'S')}<br/><br/>
    <h3>특정문자로 끝나는지의 유무를 판단? endsWith(문자열, 시작문자열)</h3>
    - mbc변수의 값이 'm'으로 시작하는지의 판단? ${fn:endsWith(mbc,'m')}<br/>
    - mbc변수의 값이 'l'으로 시작하는지의 판단? ${fn:endsWith(mbc,'l')}<br/>
    - mbc변수의 값이 'L'으로 시작하는지의 판단? ${fn:endsWith(mbc,'L')}<br/><br/>
    <h3>특정문자를 포함하는지의 유무를 판단? contains(변수,문자열)</h3>
    - mbc변수의 값이 'm'으로 시작하는지의 판단? ${fn:contains(mbc,'m')}<br/>
    - mbc변수의 값이 'l'으로 시작하는지의 판단? ${fn:contains(mbc,'l')}<br/>
    - mbc변수의 값이 'L'으로 시작하는지의 판단? ${fn:contains(mbc,'L')}<br/><br/>
    <h3>문자열의 결합(join(문자열변수,결합문자))</h3>
    <%
      String[] tels = {"010","1234","5678"};
      request.setAttribute("tels", tels);
    %>
    - tels배열변수의 문자열을 '/'로 겹합?
    ${fn:join(tels,'/')}<br/><br/>
    <h3>문자열의 분리(split(변수,분리할문자))</h3>
    <c:set var="tt" value="010-1234-5678"/>
    <c:set var="tts" value="${fn:split(tt,'-')}"/>
    <c:forEach var="t" items="${tts}">
      ${t}<br/>
    </c:forEach>
    1번째 배열값? ${tts[0]}<br/>
    tts배열의 크기? ${fn:length(tts)}<br/>
  </div>
  <hr/>
  <div>
    <h3>형식문자열 지정(Formatting라이브러리 사용)</h3>
    <%
      int won = 1234567;
      pageContext.setAttribute("won", won);
    %>
    won = ${won}<br/>
    천단위마다 콤마표시 : <fmt:formatNumber value="${won}"/><br/>
    화폐단위로 콤마표시 : <fmt:formatNumber value="${won}" type="currency"/><br/>
    화폐단위로 콤마표시 : <fmt:formatNumber value="${won}" type="currency" currencyCode="KRW"/><br/>
    화폐단위로 콤마표시 : <fmt:formatNumber value="${won}" type="currency" currencyCode="USD"/><br/>
    화폐단위로 콤마표시 : <fmt:formatNumber value="${won}" type="currency" currencyCode="JPY"/><br/>
    화폐단위로 콤마표시 : <fmt:formatNumber value="${won}" type="currency" currencyCode="EUR"/><br/>
    화폐단위로 콤마표시 : <fmt:formatNumber value="${won}" type="currency" currencyCode="AUD"/><br/>
    백분율 형식표시 : <fmt:formatNumber value="${won/100}" type="percent"/><br/>
    소수이하 두자리 출력 : <fmt:formatNumber value="${won}" pattern=".00"/><br/>
    <c:set var="su0" value="1234.567"/>
    소수이하 2자리까지 출력(반올림) : <fmt:formatNumber value="${su0}" pattern=".00"/><br/>
    정수부만 출력(반올림) : <fmt:formatNumber value="${su0}" pattern="0"/><br/>
    소수이하 버림 : <fmt:parseNumber value="${su0}" integerOnly="true"/><br/>
  </div>
  <div>
    <h3>날짜표시형식</h3>
    <c:set var="today" value="<%=new java.util.Date() %>"/>
    - 오늘 날짜는? ${today}<br/>
    <fmt:formatDate value="${today}"/><br/>
    <fmt:formatDate value="${today}" pattern="yyyy-MM-dd"/><br/>
    <fmt:formatDate value="${today}" pattern="yyyy년 MM월 dd일"/><br/>
    <fmt:formatDate value="${today}" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초"/><br/>
    <fmt:formatDate value="${today}" pattern="yyyy-MM-dd hh:mm:ss"/><br/>
  </div>
  <p><br/></p>
</div>
<%@ include file="/include/footer.jsp" %>
</body>
</html>