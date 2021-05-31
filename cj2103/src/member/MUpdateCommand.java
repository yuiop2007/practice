package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MUpdateCommand implements MInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("smid");
		
		MemberDAO dao = new MemberDAO();
		
		MemberVO vo = dao.mSearch(mid);
		
		long pwdValue = dao.hashTableSearch(vo.getPwdKey());
		long decPwd = Long.parseLong(vo.getPwd()) ^ pwdValue;  // 복호화된 비밀번호
		String strPwd = String.valueOf(decPwd);
		
		char ch;
		String result = "";
		for(int i=0; i<strPwd.length(); i+=2) {
			ch = (char) Integer.parseInt(strPwd.substring(i, i+2));
			result += ch;
		}
		vo.setPwd(String.valueOf(result));
		
		System.out.println("vo : " + vo);
		
		request.setAttribute("vo", vo);
	}

}
