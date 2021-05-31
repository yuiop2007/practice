package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;

public class AMLevelCommand implements AInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = Integer.parseInt(request.getParameter("idx"));
		int level = Integer.parseInt(request.getParameter("level"));
		int pag = Integer.parseInt(request.getParameter("pag"));
		
		MemberDAO dao = new MemberDAO();
		dao.aMLevel(idx, level);
		
		request.setAttribute("msg", "levelCheckOk");
		request.setAttribute("url", request.getContextPath()+"/aMList.ad?pag="+pag);
		//request.setAttribute("pag", pag);
	}

}
