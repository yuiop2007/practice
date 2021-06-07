package board;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BMyContentCommand implements BInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx").trim());
		
		BoardDAO dao = new BoardDAO();
		
		// 중복 조회수 증가 방지처리
		// 세션배열 '세션아이디'+'board'+'고유번호'
		HttpSession session = request.getSession();
		ArrayList<String> contentIdx = (ArrayList) session.getAttribute("contentIdx");
		if(contentIdx == null) {
			contentIdx = new ArrayList<String>();
			session.setAttribute("contentIdx", contentIdx);
		}
		String imsiContentIdx = session.getId()+"board"+idx;
		if(!contentIdx.contains(imsiContentIdx)) {
			contentIdx.add(imsiContentIdx);
			dao.readNumUpdate(idx);
		}
		
		// 게시글내용 읽어오기
		BoardVO vo = dao.bContent(idx);
		
		// 댓글 읽어오기
		List<ReplyBoardVO> rVos = dao.getReply(idx);
		
		request.setAttribute("vo", vo);
		request.setAttribute("rVos", rVos);
	}

}
