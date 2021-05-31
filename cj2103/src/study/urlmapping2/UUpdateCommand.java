package study.urlmapping2;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study.urlmapping.UrlMappingDAO;
import study.urlmapping.UrlMappingVO;

public class UUpdateCommand implements UCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		int age = request.getParameter("age") == null ? 0 : Integer.parseInt(request.getParameter("age"));
		
		UrlMappingVO vo = new UrlMappingVO();
		vo.setIdx(idx);
		vo.setName(name);
		vo.setAge(age);
		
		UrlMappingDAO dao = new UrlMappingDAO();
		
		int res = dao.setUUpdateOk(vo);
		
		if(res == 1) {
			request.setAttribute("msg", "uUpdateOk");
			request.setAttribute("url", request.getContextPath()+"/uList.um");
		}
		else {
			request.setAttribute("msg", "uUpdateNo");
			request.setAttribute("url", request.getContextPath()+"/uList.um");
		}
	}

}
