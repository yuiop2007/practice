package admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;
import member.MemberVO;

public class AMListCommand implements AInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String strLevel = request.getParameter("level")==null ? "" : request.getParameter("level");
		
		MemberDAO dao = new MemberDAO();
		
		// 페이징 처리를 위한 준비
	  int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
	  int pageSize = 5;  														// 1. 한페이지의 분량을 2건으로 정한다.
	  int totRecCnt = dao.totRecCnt(strLevel); 			// 2. 총 레코드 건수를 구한다.
	  int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (int)(totRecCnt / pageSize) +1;  // 3. 총페이지수 구하기
	  int startIndexNo = (pag - 1) * pageSize;			// 4. 현재페이지의 시작 Index번호구하기
	  int curScrStartNo = totRecCnt - startIndexNo;	

		List<MemberVO> vos = dao.aMList(startIndexNo, pageSize, strLevel);
		
		request.setAttribute("vos", vos);
		request.setAttribute("pag", pag);
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("totPage", totPage);
		request.setAttribute("stringLevel", strLevel);
	}

}
