package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.SecurityUtil;

public class BUpdateOkCommand implements BInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name")==null ? "" : request.getParameter("name");
		String title = request.getParameter("title")==null ? "" : request.getParameter("title");
		String email = request.getParameter("email")==null ? "" : request.getParameter("email");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		String hostIp = request.getParameter("hostIp")==null ? "" : request.getParameter("hostIp");
		String pag = request.getParameter("pag")==null ? "" : request.getParameter("pag");
		String pageSize = request.getParameter("pageSize")==null ? "" : request.getParameter("pageSize");

		int idx = Integer.parseInt(request.getParameter("idx"));
		
		// title태그는 HTML태그 사용 금지
		title = title.replace("<", "&lt;");
		title = title.replace(">", "&gt;");
		
		// 비밀번호를 SHA-256
		if(!pwd.equals("")) {
			SecurityUtil securityUtil = new SecurityUtil();
			pwd = securityUtil.encryptSHA256(pwd);
		}
		
		BoardVO vo = new BoardVO();
		vo.setName(name);
		vo.setTitle(title);
		vo.setEmail(email);
		vo.setContent(content);
		vo.setPwd(pwd);
		vo.setHostIp(hostIp);
		
		BoardDAO dao = new BoardDAO();
		
		int res = dao.bUpdateOk(vo, idx);
		
		if(res == 1) {
			request.setAttribute("msg", "bUpdateOk");
			request.setAttribute("url", request.getContextPath()+"/bContent.bo?idx="+idx+"&pag="+pag+"&pageSize="+pageSize);
		}
		else {
			request.setAttribute("msg", "bUpdateNo");
			request.setAttribute("url", request.getContextPath()+"/bUpdate.bo?idx="+idx+"&pag="+pag+"&pageSize="+pageSize);
		}

	}

}
