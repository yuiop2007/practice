package study.password;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/passwordOk1")
public class PasswordOk1 extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 입력한 아이디와 비밀번호 받기
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		int pwd = request.getParameter("pwd")==null ? 0 : Integer.parseInt(request.getParameter("pwd"));
		
		System.out.println("입력한 아이디 : " + mid);
		System.out.println("입력한 비밀번호 : " + pwd);
		System.out.println("-------------------------");
		 
		int key = 123456;
		int encPwd, decPwd;
		
		encPwd = pwd ^ key;
		System.out.println("인코딩된 비밀번호 : " + encPwd);
		
		decPwd = encPwd ^ key;
		System.out.println("디코딩된 비밀번호 : " + decPwd);
		
		PrintWriter out = response.getWriter();
		
		if(pwd == decPwd) {
			out.println("<script>");
			out.println("alert('비밀번호가 일치합니다.');");
			out.println("location.href='"+request.getContextPath()+"/password';");
			out.println("</script>");
		}
		else {
			out.println("<script>");
			out.println("alert('비밀번호가 다름니다.');");
			out.println("location.href='"+request.getContextPath()+"/password';");
			out.println("</script>");
		}
	}
}
