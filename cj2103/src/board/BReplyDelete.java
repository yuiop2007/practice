package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/bReplyDelete")
public class BReplyDelete extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int replyIdx = request.getParameter("replyIdx")==null? 0 : Integer.parseInt(request.getParameter("replyIdx"));
		
		BoardDAO dao = new BoardDAO();
		dao.bReplyDelete(replyIdx);
	}
}
