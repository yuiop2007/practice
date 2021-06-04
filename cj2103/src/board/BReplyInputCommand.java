package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BReplyInputCommand implements BInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardIdx = request.getParameter("boardIdx")==null ? 0 : Integer.parseInt(request.getParameter("boardIdx"));
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String nickName = request.getParameter("nickName")==null ? "" : request.getParameter("nickName");
		String hostIp = request.getParameter("hostIp")==null ? "" : request.getParameter("hostIp");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		String pag = request.getParameter("pag")==null ? "" : request.getParameter("pag");
		String pageSize = request.getParameter("pageSize")==null ? "" : request.getParameter("pageSize");
		
		ReplyBoardVO rVo = new ReplyBoardVO();

		rVo.setBoardIdx(boardIdx);
		rVo.setMid(mid);
		rVo.setNickName(nickName);
		rVo.setHostIp(hostIp);
		rVo.setContent(content);
		
		BoardDAO dao = new BoardDAO();
		dao.bReplyInput(rVo);
		
		request.setAttribute("msg", "bReplyBoardOk");
		request.setAttribute("url", request.getContextPath()+"/bContent.bo?idx="+boardIdx+"&pag="+pag+"&pageSize="+pageSize);
	}

}
