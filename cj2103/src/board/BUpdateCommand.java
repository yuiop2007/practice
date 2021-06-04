package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.SecurityUtil;

public class BUpdateCommand implements BInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		String pag = request.getParameter("pag")==null ? "" : request.getParameter("pag");
		String pageSize = request.getParameter("pageSize")==null ? "" : request.getParameter("pageSize");

		SecurityUtil securityUtil = new SecurityUtil();
		pwd = securityUtil.encryptSHA256(pwd);
		
		BoardDAO dao = new BoardDAO();
		
		int res = dao.getPwdCheck(idx, pwd);
		if(res == 1) {
			BoardVO vo = dao.bContent(idx);
			request.setAttribute("vo", vo);
			request.setAttribute("pag", pag);
			request.setAttribute("pageSize", pageSize);
		}
		else {
			request.setAttribute("msg", "passCheckNo");
			request.setAttribute("url", request.getContextPath()+"/bContent.bo?idx="+idx+"&pag="+pag+"&pageSize="+pageSize);
		}
	}

}
