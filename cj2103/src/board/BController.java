package board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberMainCommand;

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
		else if(com.equals("/bGood")) {
			int idx = Integer.parseInt(request.getParameter("idx"));
			BoardDAO dao = new BoardDAO();
			dao.bGood(idx);
			return;
		}
		else if(com.equals("/bUpdate")) {
			command = new BUpdateCommand();
			command.execute(request, response);
			String msg = request.getAttribute("msg")==null ? "" : (String) request.getAttribute("msg");
			if(!msg.equals("")) {
				viewPage = "/WEB-INF/message/message.jsp";
			}
			else {
				viewPage = "/WEB-INF/board/bUpdate.jsp";
			}
		}
		else if(com.equals("/bUpdateOk")) {
			command = new BUpdateOkCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/message/message.jsp";
		}
		else if(com.equals("/bDelete")) {
			command = new BDeleteCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/message/message.jsp";
		}
		else if(com.equals("/bReplyInput")) {
			command = new BReplyInputCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/message/message.jsp";
		}
		else if(com.equals("/bSearch")) {
			command = new BSearchCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/board/bSearch.jsp";
		}
		else if(com.equals("/bMyList")) {
			command = new BMyListCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/board/bMyList.jsp";
		}
		else if(com.equals("/bMyContent")) {
			command = new BMyContentCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/board/bMyContent.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
