package study;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study.urlmapping.UrlMappingDAO;
import study.urlmapping.UrlMappingVO;

public class UlistCommand implements SInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UrlMappingDAO dao = new UrlMappingDAO();
    List<UrlMappingVO> vos = dao.getUrlMappingList();
    System.out.println("vos : " + vos);
    request.setAttribute("vos", vos);
	}

}
