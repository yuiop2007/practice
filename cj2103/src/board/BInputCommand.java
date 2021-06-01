package board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.MemberDAO;
import member.MemberVO;

public class BInputCommand implements BInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("smid");
		
		MemberDAO dao = new MemberDAO();
		
		List<MemberVO> vos = dao.mSearch(mid);
		MemberVO vo = vos.get(0);
		
		request.setAttribute("vo", vo);
	}

}
