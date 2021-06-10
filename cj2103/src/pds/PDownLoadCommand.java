package pds;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PDownLoadCommand implements PInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));

		PdsDAO dao = new PdsDAO();
		dao.pDownCount(idx);  // 다운로드 횟수 증가
		PdsVO vo = dao.pContent(idx);  // 한건의 자료 정보 가져오기
		
		String[] fNames = vo.getfName().split("/");
		String[] fSNames = vo.getfSName().split("/");
		
		FileInputStream fileInputStream = null;
		ServletOutputStream servletOutputStream = null;
		
		// 실제파일이 저장되어 있는 경로 설정
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/data/pds/");
		
		// 압축하기위한 준비작업
		String zipPath = realPath + "temp/";
		String zipName = vo.getTitle() + ".zip";
		
		byte[] buffer = new byte[2048];  // 실제로 한번에 전송할 파일의 크기를 2048byte로 한다는것.
		
		ZipOutputStream zipOutputStream = new ZipOutputStream(new FileOutputStream(zipPath+zipName));
		
		// 작업자료중에서 중복된이름이 존재할경우 이름을 변경(숫자를 덧붙임)하여 압축할 준비를 한다.
		// '10.jpg/10.jpg/10.jpg' => '10.jpg/10(1).jpg/10(2).jpg'
		for(int i=0; i<fNames.length; i++) {
			for(int j=0; j<i ; j++) {
				if(fNames[i].equals(fNames[j])) {
					fNames[i] = fNames[i].substring(0,fNames[i].lastIndexOf("."))
							+ "("+i+")" + fNames[i].substring(fNames[i].lastIndexOf("."));
					System.out.println("fNames[i] : " + fNames[i]);
					//break;
				}
			}
		}
		
		for(int i=0; i<fSNames.length; i++) {
			File file = new File(realPath+fSNames[i]);
			File moveRename = new File(zipPath + fNames[i]);
			file.renameTo(moveRename);
			
			System.out.println("moveRename : " + moveRename);
			
			fileInputStream = new FileInputStream(moveRename);
			zipOutputStream.putNextEntry(new ZipEntry(fNames[i]));
			
			int data = 0;
			while((data = fileInputStream.read(buffer, 0, buffer.length)) != -1) {
				zipOutputStream.write(buffer, 0, data);
			}
			zipOutputStream.flush();
			zipOutputStream.closeEntry();
			fileInputStream.close();
			
			moveRename.renameTo(file);
		}
		zipOutputStream.close();
		
		// 앞에서 압축(합치기)작업이 끝난후 서버에 저장된 zip파일을 다운로드처리한다.
		String mimeType = application.getMimeType(zipName.toString());
		if(mimeType == null) {
			response.setContentType("application/octet-stream"); // 2진 바이너리파일로 전송하겠다는것
		}
		
		String downLoadName = null;
		if(request.getHeader("user-agent").indexOf("MSIE") == -1) { // 사용자 브라우저가 익스플로러가 아니라면?
			downLoadName = new String(zipName.getBytes("UTF-8"), "8859_1");
		}
		else {
			downLoadName = new String(zipName.getBytes("EUC-KR"), "8859_1");
		}
		
		// 다운로드할 파일명과 형식을 헤더파일에 담아서 전송시킨다.
		response.setHeader("Content-Disposition", "attachment;filename=" + downLoadName);
		
		// Java에 의해서 실제로 업(다운)로드를 하기위한 객체(FileInputStream/FileOutputStream)를 생성한다.
		fileInputStream = new FileInputStream(zipPath + zipName);
		servletOutputStream = response.getOutputStream();
		
		// 생성된 객체에 실제로 파일을 전송처리한다.
		//byte[] b = new byte[2048];  // 실제로 한번에 전송할 파일의 크기를 2048byte로 한다는것.
		int data = 0;
		
		while((data = fileInputStream.read(buffer, 0, buffer.length)) != -1) {
			servletOutputStream.write(buffer, 0, data);
		}
		servletOutputStream.flush();
		
		servletOutputStream.close();
		fileInputStream.close();
		
		//new File(zipPath + zipName).delete();
	}

}
