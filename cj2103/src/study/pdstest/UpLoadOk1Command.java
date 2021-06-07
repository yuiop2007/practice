package study.pdstest;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class UpLoadOk1Command implements PtInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// MultipartRequest(저장소이름,"서버에 저장될 파일의 경로","최대용량","코드변환방식",옵션....(클래스))
		// 서버에 저장될 파일의 실제경로? getRealPath()
		
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/data/pdstest");  // 서버에 저장될 실제경로(이클립스에서 미리 만들어두고 작업한다.)
		int maxSize = 1024 * 1024 * 10;  // 업로드파일의 최대용량은 10MByte로 제한
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());  // 파일 업로드 완료...
		
		String originalFileName = multipartRequest.getOriginalFileName("fname");   // 원본 파일명
		String filesystemName = multipartRequest.getFilesystemName("fname"); // 실제 서버에 저장된 파일명
		
		System.out.println("서버에 실제로 저장되는 경로 : " + application.getRealPath("/"));
		System.out.println("원본 파일명 : " + originalFileName);
		System.out.println("서버에 저장된 파일명 : " + filesystemName);
		
		if(filesystemName != null) {
			request.setAttribute("msg", "upLoadOk1Ok");
		}
		else {
			request.setAttribute("msg", "upLoadOk1No");
		}
		request.setAttribute("url", request.getContextPath()+"/upLoad1.pt");
	}

}
