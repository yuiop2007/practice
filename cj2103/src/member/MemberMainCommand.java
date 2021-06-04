package member;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.BoardDAO;
import board.BoardVO;

public class MemberMainCommand implements MInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String snickName = (String) session.getAttribute("snickname");
		
		
		BoardDAO dao = new BoardDAO();
		
		List<BoardVO> vos = dao.getMyBoard(snickName);
		
		/* request.setAttribute("vos", vos); */
		request.setAttribute("bMyCount", vos.size());
		
		

	}

}
