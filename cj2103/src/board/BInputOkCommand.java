package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.SecurityUtil;

public class BInputOkCommand implements BInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name")==null ? "" : request.getParameter("name");
		String title = request.getParameter("title")==null ? "" : request.getParameter("title");
		String email = request.getParameter("email")==null ? "" : request.getParameter("email");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		String hostIp = request.getParameter("hostIp")==null ? "" : request.getParameter("hostIp");

		// 비밀번호를 SHA-256
		SecurityUtil securityUtil = new SecurityUtil();
		pwd = securityUtil.encryptSHA256(pwd);
		
		BoardVO vo = new BoardVO();
		vo.setName(name);
		vo.setTitle(title);
		vo.setEmail(email);
		vo.setContent(content);
		vo.setPwd(pwd);
		vo.setHostIp(hostIp);
		
		BoardDAO dao = new BoardDAO();
		
		int res = dao.bInputOk(vo);
		
		if(res == 1) {
			request.setAttribute("msg", "bInputOk");
			request.setAttribute("url", request.getContextPath()+"/bList.bo");
		}
		else {
			request.setAttribute("msg", "bInputNo");
			request.setAttribute("url", request.getContextPath()+"/bInput.bo");
		}
	}

}
