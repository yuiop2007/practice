package pds;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("*.pds")
public class PController extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}
	
	private void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int level = session.getAttribute("slevel")==null ? 99 : (int) session.getAttribute("slevel");
		if(level == 1 || level >= 4) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/member/login.jsp");
			dispatcher.forward(request, response);
			return;
		}
		
		PInterface command = null;
		String viewPage = "";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"),uri.length()-4);
		
		if(com.equals("/pList")) {
			command = new PListCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/pds/pList.jsp";
		}
		else if(com.equals("/pInput")) {
			viewPage = "/WEB-INF/pds/pInput.jsp";
		}
		else if(com.equals("/pInputOk")) {
			command = new PInputOkCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/message/message.jsp";
		}
		else if(com.equals("/pContent")) {
			command = new PContentCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/pds/pContent.jsp";
		}
		else if(com.equals("/pPassCheck")) {
			request.setAttribute("idx", request.getParameter("idx"));
			request.setAttribute("pag", request.getParameter("pag"));
			viewPage = "/WEB-INF/pds/pPassCheck.jsp";
		}
		else if(com.equals("/pPassCheckOk")) {
			command = new PPassCheckOkCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/message/message.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
