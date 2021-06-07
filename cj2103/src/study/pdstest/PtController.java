package study.pdstest;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberMainCommand;

@WebServlet("*.pt")
public class PtController extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}
	
	private void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PtInterface command = null;
		String viewPage = "";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"),uri.length()-3);
		
		if(com.equals("/upLoad1")) {
			viewPage = "/WEB-INF/study2/pdstest/upLoad1.jsp";
		}
		else if(com.equals("/upLoadOk1")) {
			command = new UpLoadOk1Command();
			command.execute(request, response);
			viewPage = "/WEB-INF/message/message.jsp";
		}
		else if(com.equals("/downLoad1")) {
			command = new DownLoad1Command();
			command.execute(request, response);
			viewPage = "/WEB-INF/study2/pdstest/downLoad1.jsp";
		}
		else if(com.equals("/upLoad2")) {
			viewPage = "/WEB-INF/study2/pdstest/upLoad2.jsp";
		}
		else if(com.equals("/upLoadOk2")) {
			command = new UpLoadOk2Command();
			command.execute(request, response);
			viewPage = "/WEB-INF/message/message.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
