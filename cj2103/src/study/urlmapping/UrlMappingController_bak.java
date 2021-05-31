package study.urlmapping;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// url주소창에 기재된 확장자가 '*.um'은 모두 이곳으로 온다. 
//@WebServlet("*.um")
public class UrlMappingController_bak extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  	actionDo(request, response);
  }

	@Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  	actionDo(request, response);
  }
  
	private void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 한글처리, 세션 체크부분을 기술해준다.
		
		UrlMappingCommand command = null;
		String viewPage = "";
		
		StringBuffer url = request.getRequestURL();
		System.out.println("url : " + url);
		
		String uri = request.getRequestURI();
		System.out.println("uri : " + uri);
		
		String com = uri.substring(uri.lastIndexOf("/"), uri.length()-3);
		System.out.println("com : " + com);
		
		if(com.equals("/urlMappingList")) {
			command = new UrlMappingListCommand_bak();
			command.execute(request, response);
			viewPage = "/WEB-INF/study2/urlmapping/urlMappingList.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
  
}
