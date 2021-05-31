package admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("*.ad")
public class AController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AInterface command = null;
		String viewPage = "";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"), uri.length()-3);
		
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("smid");
		int level = (int) session.getAttribute("slevel");
		if(mid == null || level != 0) {
			viewPage = "/WEB-INF/member/login.jsp";
		}
		
		if(com.equals("/aMain")) {
			viewPage = "/WEB-INF/admin/aMain.jsp";
		}
		else if(com.equals("/aMenu")) {
			viewPage = "/WEB-INF/admin/aMenu.jsp";
		}
		else if(com.equals("/aContent")) {
			command = new AContentCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/admin/aContent.jsp";
		}
		else if(com.equals("/aOut")) {
			command = new AOutCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/message/message.jsp";
		}
		else if(com.equals("/aMList")) {
			command = new AMListCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/admin/member/aMList.jsp";
		}
		else if(com.equals("/aMInfor")) {
			command = new AMInforCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/admin/member/aMInfor.jsp";
		}
		else if(com.equals("/aMLevel")) {
			command = new AMLevelCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/message/message.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
