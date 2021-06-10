package pds;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import aria.ARIAUtil;

public class PPassCheckOkCommand implements PInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag")==null ? 0 : Integer.parseInt(request.getParameter("pag"));
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
	
		PdsDAO dao = new PdsDAO();
		
		try {
			pwd = ARIAUtil.ariaEncrypt(pwd);
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String res = dao.pPassCheck(idx, pwd);
		
		if(res.equals("")) {
			request.setAttribute("msg", "pPassCheckNo");
			request.setAttribute("url", request.getContextPath()+"/pList.pds?idx="+idx+"&pag="+pag);
		}
		else {
			String[] rfNames = res.split("/");
			
			ServletContext application = request.getServletContext();
			String realPath = application.getRealPath("/data/pds/");
			
			// 서버 시스템에 존재하는 개별 파일 삭제
			for(String rfName : rfNames) {
//				File file = new File(realPath + rfName);
//				file.delete();
				new File(realPath + rfName).delete();
			}
			
			// 삭제된 파일의 정보를 DB에서 제거한다.
			dao.pDelete(idx);
			
			request.setAttribute("msg", "pPassCheckOk");
			request.setAttribute("url", request.getContextPath()+"/pList.pds");
		}
	}

}
