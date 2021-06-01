package board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BListCommand implements BInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardDAO dao = new BoardDAO();
		
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = 5;
		int totRecCnt = dao.totRecCnt();
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (int)(totRecCnt / pageSize) +1;
		int startIndexNo = (pag - 1) * pageSize;
	  int curScrStartNo = totRecCnt - startIndexNo;
	  int blockSize = 3;
		
		List<BoardVO> vos = dao.bList(startIndexNo, pageSize);
		
		request.setAttribute("vos", vos);
		request.setAttribute("pag", pag);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("blockSize", blockSize);
	}

}
