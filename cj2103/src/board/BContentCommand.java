package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BContentCommand implements BInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		BoardDAO dao = new BoardDAO();
		
		// 중복 조회수 증가 방지처리
		// 세션배열 '세션아이디'+'board'+'고유번호'
		HttpSession session = request.getSession();
		ArrayList<String> contextIdx = (ArrayList) session.getAttribute("contextIdx");
		if(contextIdx == null) {
			contextIdx = new ArrayList<String>();
			session.setAttribute("contextIdx", contextIdx);
		}
		String imsiContextIdx = session.getId()+"board"+idx;
		if(!contextIdx.contains(imsiContextIdx)) {
			contextIdx.add(imsiContextIdx);
			dao.readNumUpdate(idx);
		}
		
		
		BoardVO vo = dao.bContent(idx);
		
		request.setAttribute("vo", vo);
	}

}
