package study.urlmapping;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/urlMappingList")
public class UrlMappingList extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UrlMappingDAO dao = new UrlMappingDAO();
		
		List<UrlMappingVO> vos = dao.getUrlMappingList();
		
		request.setAttribute("vos", vos);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/study2/urlmapping/urlMappingList.jsp");
		dispatcher.forward(request, response);
	}
}
