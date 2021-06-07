package study.pdstest;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class UpLoadOk2Command implements PtInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/data/pdstest");
		int maxSize = 1024 * 1024 * 10;  // 업로드파일의 최대용량은 10MByte로 제한
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());  // 파일 업로드 완료...
		
		Enumeration fileNames = multipartRequest.getFileNames();
		String file = null;
		String originalFileName = "";
		String filesystemName = "";
		
		while(fileNames.hasMoreElements()) {
			file = (String) fileNames.nextElement();
			originalFileName = multipartRequest.getOriginalFileName(file);
			filesystemName = multipartRequest.getFilesystemName(file);
			
			System.out.println("업로드시 파일명 : " + originalFileName);
			System.out.println("서버에 저장된 파일명 : " + filesystemName);
		}
		
		if(filesystemName != null) {
			request.setAttribute("msg", "upLoadOk1Ok");
		}
		else {
			request.setAttribute("msg", "upLoadOk1No");
		}
		request.setAttribute("url", request.getContextPath()+"/upLoad2.pt");
	}

}
