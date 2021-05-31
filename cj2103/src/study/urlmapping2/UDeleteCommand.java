package study.urlmapping2;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study.urlmapping.UrlMappingDAO;

public class UDeleteCommand implements UCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		UrlMappingDAO dao = new UrlMappingDAO();
		
		int res = dao.setUDelete(idx);
		
		if(res == 1) {
			request.setAttribute("msg", "uDeleteOk");
		}
		else {
			request.setAttribute("msg", "uDeleteNo");
		}
		request.setAttribute("url", request.getContextPath()+"/uList.um");
	}

}
