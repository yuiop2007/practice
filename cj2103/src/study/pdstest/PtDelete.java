package study.pdstest;

import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ptDelete")
public class PtDelete extends HttpServlet {
  @Override
  protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  	String fileName = request.getParameter("file");
		
		String RealPath = request.getServletContext().getRealPath("/data/pdstest/");
		
		File file = new File(RealPath+fileName);
		
		if(file.exists()) {
			file.delete();
			request.setAttribute("msg", "ptDeleteOk");
		}
		else {
			request.setAttribute("msg", "ptDeleteNo");
		}
		request.setAttribute("url", request.getContextPath()+"/downLoad1.pt");
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/message/message.jsp");
		dispatcher.forward(request, response);
		
  }
}
