package pds;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PListCommand implements PInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String part = request.getParameter("part")==null ? "전체" : request.getParameter("part");
		
		PdsDAO dao = new PdsDAO();
		
		// 페이징 처리를 위한 준비
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize")==null ? 5 : Integer.parseInt(request.getParameter("pageSize"));
		int totRecCnt = dao.totRecCnt(part);
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (int)(totRecCnt / pageSize) +1;
		int startIndexNo = (pag - 1) * pageSize;
	  int curScrStartNo = totRecCnt - startIndexNo;
	  int blockSize = 3;
	  
	  List<PdsVO> vos = dao.pList(startIndexNo, pageSize, part);

	  request.setAttribute("vos", vos);
		
		// 페이징처리를 위한 저장소 저장하기
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("blockSize", blockSize);
		
		request.setAttribute("part", part);
	}

}
