package study.password;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/passwordOk2")
public class PasswordOk2 extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 입력한 아이디와 비밀번호 받기
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd").toUpperCase();
		
		System.out.println("입력한 아이디 : " + mid);
		System.out.println("입력한 비밀번호 : " + pwd);
		System.out.println("-------------------------");
		
		long intPwd;
		String strPwd = "";
		for(int i=0; i<pwd.length(); i++) {
			intPwd = (long) pwd.charAt(i);
			strPwd += intPwd;
		}
		System.out.println("strPwd : " + strPwd);
		
		intPwd = Long.parseLong(strPwd);
		
		long key = 0x1234ABCD;
		long encPwd, decPwd;
		
		encPwd = intPwd ^ key;
		System.out.println("DB저장 비밀번호 : " + encPwd);
		
		decPwd = encPwd ^ key;
		System.out.println("복원된 비밀번호 : " + decPwd);
		
		// 복원된 비밀번호는 숫자로된 비밀번호이기에 문자로 변경후 2개씩 분리후 다시 문자로 변환시켜준다.
		strPwd = String.valueOf(decPwd);
		
		String result = "";
		char ch;
		
		for(int i=0; i<strPwd.length(); i+=2) {
			ch = (char) Integer.parseInt(strPwd.substring(i, i+2));
			result += ch;
		}
		
		System.out.println("최종 변환된 비밀번호 : " + result);
		
		PrintWriter out = response.getWriter();
		
		if(pwd.equals(result)) {
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
