package study.urlmapping2;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study.urlmapping.UrlMappingDAO;
import study.urlmapping.UrlMappingVO;

public class UListCommand implements UCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UrlMappingDAO dao = new UrlMappingDAO();
		
		List<UrlMappingVO> vos = dao.getUrlMappingList();
		
		request.setAttribute("vos", vos);
	}

}
