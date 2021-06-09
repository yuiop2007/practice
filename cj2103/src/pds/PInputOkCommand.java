package pds;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import aria.ARIAUtil;

public class PInputOkCommand implements PInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/data/pds");
		int maxSize = 1024 * 1024 * 10;  // 최대 10MByte
		String encoding = "UTF-8";
		
		// 실제 파일이 서버 파일시스템에 업로드 처리됨
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
		// 업로드시킨 파일의 정보를 DB에 저장시키기 위한 작업
		Enumeration fileNames = multipartRequest.getFileNames();
		String originalFileName = "";
		String filesystemName = "";
		
		while(fileNames.hasMoreElements()) {
			String file = (String) fileNames.nextElement();
			
			if(multipartRequest.getOriginalFileName(file) != null) {
				originalFileName += multipartRequest.getOriginalFileName(file) + "/";
				filesystemName += multipartRequest.getFilesystemName(file) + "/";
			}
		}
		
		// 비밀번호 암호화
		String pwd = multipartRequest.getParameter("pwd");
		try {
			pwd = ARIAUtil.ariaEncrypt(pwd);
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		PdsDAO dao = new PdsDAO();
		PdsVO vo = new PdsVO();
		
		vo.setMid(multipartRequest.getParameter("mid"));
		vo.setNickName(multipartRequest.getParameter("nickName"));
		vo.setfName(originalFileName);
		vo.setfSName(filesystemName);
		vo.setfSize(Integer.parseInt(multipartRequest.getParameter("fSize")));
		vo.setTitle(multipartRequest.getParameter("title"));
		vo.setPart(multipartRequest.getParameter("part"));
		vo.setPwd(pwd);
		vo.setOpenSw(multipartRequest.getParameter("openSw"));
		vo.setContent(multipartRequest.getParameter("content"));
		
		int res = dao.pInput(vo);
		
		if(res == 1) {
			request.setAttribute("msg", "pInputOk");
			request.setAttribute("url", request.getContextPath()+"/pList.pds");
		}
		else {
			request.setAttribute("msg", "pInputNo");
			request.setAttribute("url", request.getContextPath()+"/pInput.pds");
		}
	}
}
