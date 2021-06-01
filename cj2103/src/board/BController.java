package board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.bo")
public class BController extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}
	
	private void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BInterface command = null;
		String viewPage = "";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"),uri.length()-3);
		
		if(com.equals("/bList")) {
			command = new BListCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/board/bList.jsp";
		}
		else if(com.equals("/bInput")) {
			command = new BInputCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/board/bInput.jsp";
		}
		else if(com.equals("/bInputOk")) {
			command = new BInputOkCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/message/message.jsp";
		}
		else if(com.equals("/bContent")) {
			command = new BContentCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/board/bContent.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}