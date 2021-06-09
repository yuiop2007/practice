package pds;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/pDownCount")
public class PDownCount extends HttpServlet{
  @Override
  protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  	int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
  	
//  	response.getWriter().write(pDownCount(idx));
//  }
//
//	private String pDownCount(int idx) {
		PdsDAO dao = new PdsDAO();
		dao.pDownCount(idx);
//		return "";
	}
}
