package member;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MUpdateCommand implements MInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String sw = request.getParameter("sw")==null ? "" : request.getParameter("sw");
		String mid = "";
		
		if(sw.equals("")) {
			HttpSession session = request.getSession();
			mid = (String) session.getAttribute("smid");
		}
		else {
			mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		}
		
		MemberDAO dao = new MemberDAO();
		
		// MemberVO vo = dao.mSearch(mid);
		List<MemberVO> vos = dao.mSearch(mid);
		MemberVO vo = vos.get(0);
		
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
		
		if(sw.equals("s")) {
			request.setAttribute("curScrStartNo", 1);
			request.setAttribute("vos", vos);
		}
		else {
			request.setAttribute("vo", vo);
		}
		request.setAttribute("sw", sw);
	}

}
