package guest;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/gDelete_comment")
public class GDelete_comment extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		GuestDAO dao = new GuestDAO();
		
		boolean res = dao.gDelete_comment(idx);
		
		PrintWriter out = response.getWriter();
		
		if(res) {
			out.println("<script>");
			out.println("alert('방문소감 삭제완료!!');");
			out.println("location.href='"+request.getContextPath()+"/guest/gList.jsp';");
			out.println("</script>");
		}
		else {
			out.println("<script>");
			out.println("alert('방문소감 삭제실패~~~');");
			out.println("location.href='"+request.getContextPath()+"/guest/gList.jsp';");
			out.println("</script>");
		}
	}
}
