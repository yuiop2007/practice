package study.pdstest;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ptDownLoad")
public class PtDownLoad extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fileName = request.getParameter("file");
		
		String RealPath = request.getServletContext().getRealPath("/data/pdstest/");
		
		File file = new File(RealPath+fileName);
		
		String mimeType = getServletContext().getMimeType(file.toString());
		if(mimeType == null) {
			response.setContentType("application/octet-stream"); // 2진 바이너리파일로 전송하겠다는것
		}
		
		String downLoadName = null;
		if(request.getHeader("user-agent").indexOf("MSIE") == -1) { // 사용자 브라우저가 익스플로러가 아니라면?
			downLoadName = new String(fileName.getBytes("UTF-8"), "8859_1");
		}
		else {
			downLoadName = new String(fileName.getBytes("EUC-KR"), "8859_1");
		}
		
		// 다운로드할 파일명과 형식을 헤더파일에 담아서 전송시킨다.
		response.setHeader("Content-Disposition", "attachment;filename=" + downLoadName);
		
		// Java에 의해서 실제로 업(다운)로드를 하기위한 객체(FileInputStream/FileOutputStream)를 생성한다.
		FileInputStream fileInputStream = new FileInputStream(file);
		ServletOutputStream servletOutputStream = response.getOutputStream();
		
		// 생성된 객체에 실제로 파일을 전송처리한다.
		byte[] b = new byte[2048];  // 실제로 한번에 전송할 파일의 크기를 2048byte로 한다는것.
		int data = 0;
		
		while((data = fileInputStream.read(b, 0, b.length)) != -1) {
			servletOutputStream.write(b, 0, data);
		}
		servletOutputStream.flush();
		
		servletOutputStream.close();
		fileInputStream.close();
	}
}
