package study.pdstest;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DownLoad1Command implements PtInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletContext application = request.getServletContext();
		
		String realPath = application.getRealPath("/data/pdstest");
		
		String[] files = new File(realPath).list();
		
		request.setAttribute("files", files);
	}

}
