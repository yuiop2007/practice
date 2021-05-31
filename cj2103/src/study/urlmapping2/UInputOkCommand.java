package study.urlmapping2;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study.urlmapping.UrlMappingDAO;
import study.urlmapping.UrlMappingVO;

public class UInputOkCommand implements UCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		int age = request.getParameter("age") == null ? 20 : Integer.parseInt(request.getParameter("age"));
		
		UrlMappingVO vo = new UrlMappingVO();
		vo.setName(name);
		vo.setAge(age);

		UrlMappingDAO dao = new UrlMappingDAO();
		
		int res = dao.setUInputOk(vo);
//		
//		PrintWriter out = response.getWriter();
//		
//		if(res==1) {
//			out.println("<script>");
//			out.println("alert('자료가 입력되었습니다.')");
//			out.println("location.href='"+request.getContextPath()+"/uList.um';");
//			out.println("</script>");
//		}
//		else {
//			out.println("<script>");
//			out.println("alert('자료가 입력 되지 않았습니다.')");
//			out.println("location.href='"+request.getContextPath()+"/uInput.um';");
//			out.println("</script>");
//			
//		}
		
		if(res == 1) {
			request.setAttribute("msg", "uInputOk");
			request.setAttribute("url", request.getContextPath()+"/uList.um");
		}
		else {
			request.setAttribute("msg", "uInputNo");
			request.setAttribute("url", request.getContextPath()+"/uInput.um");
		}
	}

}
