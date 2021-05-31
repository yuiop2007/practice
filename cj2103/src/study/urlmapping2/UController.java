package study.urlmapping2;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.um")
public class UController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UCommand command = null;
		String viewPage = "";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"), uri.length()-3);
		
		if(com.equals("/urlMapping")) {
			viewPage = "/WEB-INF/study2/urlmapping/urlMapping.jsp";
		}
		else if(com.equals("/uList")) {
			command = new UListCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/study2/urlmapping/urlMappingList.jsp";
		}
		else if(com.equals("/uInput")) {
			viewPage = "/WEB-INF/study2/urlmapping/uInput.jsp";
		}
		else if(com.equals("/uInputOk")) {
			command = new UInputOkCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/study2/urlmapping/message.jsp";
//			return;
		}
		else if(com.equals("/uDelete")) {
			command = new UDeleteCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/study2/urlmapping/message.jsp";
		}
		else if(com.equals("/uUpdate")) {
			command = new UUpdateCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/study2/urlmapping/message.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		
	}
}
