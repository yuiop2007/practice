package study.urlmapping;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UrlMappingListCommand_bak implements UrlMappingCommand {
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UrlMappingDAO dao = new UrlMappingDAO();
		
		List<UrlMappingVO> vos = dao.getUrlMappingList();
		
		request.setAttribute("vos", vos);
	}
}
