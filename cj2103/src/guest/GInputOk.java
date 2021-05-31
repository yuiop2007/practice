package guest;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/gInputOk")
public class GInputOk extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name")==null ? "" : request.getParameter("name");
		String email = request.getParameter("email")==null ? "" : request.getParameter("email");
		String homepage = request.getParameter("homepage")==null ? "" : request.getParameter("homepage");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		
		GuestVO vo = new GuestVO();
		
		vo.setName(name);
		vo.setEmail(email);
		vo.setHomepage(homepage);
		vo.setContent(content);
		vo.setHostip(request.getParameter("hostip"));
		
		GuestDAO dao = new GuestDAO();
		
		boolean res = dao.setGInput(vo);
		
		PrintWriter out = response.getWriter();
		
		if(res) {
			out.println("<script>");
			out.println("alert('방문소감 등록완료!!');");
			out.println("location.href='"+request.getContextPath()+"/guest/gList.jsp';");
			out.println("</script>");
		}
		else {
			out.println("<script>");
			out.println("alert('방문소감 등록실패~~~');");
			out.println("location.href='"+request.getContextPath()+"/guest/gInput.jsp';");
			out.println("</script>");
		}
	}
}
