package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/bGood4")
public class BGood4 extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		// 중복 조회수 증가 방지처리
		// 세션배열 '세션아이디'+'good'+'고유번호'
		HttpSession session = request.getSession();
		ArrayList<String> goodIdx = (ArrayList) session.getAttribute("goodIdx");
		if(goodIdx == null) {
			goodIdx = new ArrayList<String>();
			session.setAttribute("goodIdx", goodIdx);
		}
		String imsiGoodIdx = session.getId()+"good"+idx;
		if(!goodIdx.contains(imsiGoodIdx)) {
			goodIdx.add(imsiGoodIdx);
			
			BoardDAO dao = new BoardDAO();
			dao.bGood(idx);
		}
		
	}
}
