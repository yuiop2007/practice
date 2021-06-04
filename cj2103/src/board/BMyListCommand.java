package board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BMyListCommand implements BInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String snickName = (String) session.getAttribute("snickname");
		
		BoardDAO dao = new BoardDAO();
		
	  // 페이징 처리를 위한 준비
//		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
//		int pageSize = request.getParameter("pageSize")==null ? 5 : Integer.parseInt(request.getParameter("pageSize"));
//		int totRecCnt = dao.totRecCnt();
//		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (int)(totRecCnt / pageSize) +1;
//		int startIndexNo = (pag - 1) * pageSize;
//	  int curScrStartNo = totRecCnt - startIndexNo;
//	  int blockSize = 3;
		
		List<BoardVO> vos = dao.getMyBoard(snickName);
		
		request.setAttribute("vos", vos);
		
	  // 페이징처리를 위한 저장소 저장하기
//		request.setAttribute("pag", pag);
//		request.setAttribute("pageSize", pageSize);
//		request.setAttribute("totPage", totPage);
//		request.setAttribute("curScrStartNo", curScrStartNo);
//		request.setAttribute("blockSize", blockSize);
	}

}
