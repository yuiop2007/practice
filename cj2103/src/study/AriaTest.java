package study;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import aria.ARIAUtil;

@WebServlet("/ariaTest")
public class AriaTest extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pwd = "홍길동hkd1234! @#$";
		System.out.println("원본 pwd : " + pwd);
		
		try {
			String encPwd = ARIAUtil.ariaEncrypt(pwd);
			System.out.println("암호화 pwd : " + encPwd);
			System.out.println("=====================");
			
			String decPwd = ARIAUtil.ariaDecrypt(encPwd);
			System.out.println("복호화 pwd : " + decPwd);
			System.out.println("=====================");
			
			if(pwd.equals(decPwd)) { 
				System.out.println("원본과 같습니다.");
			}
			else {
				System.out.println("원본과 다름니다.");
			}
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
}
