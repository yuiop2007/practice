package study;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.st")
public class SController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SInterface command = null;
		String viewPage = "";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"), uri.length()-3);
		
		if(com.equals("/jstl")) {
			viewPage = "/WEB-INF/study2/jstl/jstl.jsp";
		}
		else if(com.equals("/ulist")) {
			command = new UlistCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/study2/jstl/ulist.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
