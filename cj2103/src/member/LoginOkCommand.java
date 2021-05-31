package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginOkCommand implements MInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.loginOk(mid);
		HttpSession session = request.getSession();
		
		if(vo != null) {  // 아이디 검색 성공
			// 입력한 비밀번호 인코딩처리
			long intPwd;
			String strPwd = "";
			for(int i=0; i<pwd.length(); i++) {
				intPwd = (long) pwd.charAt(i);
				strPwd += intPwd;
			}
			intPwd = Long.parseLong(strPwd);
			
			long pwdValue = dao.hashTableSearch(vo.getPwdKey());
			long encPwd;
			encPwd = intPwd ^ pwdValue;
			strPwd = String.valueOf(encPwd);
			
			// 입력된 인코딩 비밀번호와 DB에 미리 인코딩되어 저장어 있는 비밀번호를 비교처리
			if(strPwd.equals(vo.getPwd())) {  // 비밀번호 인증 OK - 회원 인증처리 성공...
				session.setAttribute("smid", mid);
				session.setAttribute("snickname", vo.getNickName());
				session.setAttribute("slevel", vo.getLevel());
				
				dao.lastdateUpdate(mid);
				
				request.setAttribute("msg", "loginOk");
				request.setAttribute("url", request.getContextPath()+"/memberMain.mem");
				request.setAttribute("val", vo.getNickName());
			}
			else {  // 회원 인증처리 실패....
				request.setAttribute("msg", "loginPwdNo");
				request.setAttribute("url", request.getContextPath()+"/login.mem");
			}
		}
		else {
			request.setAttribute("msg", "loginIdNo");
			request.setAttribute("url", request.getContextPath()+"/login.mem");
		}
	}

}
