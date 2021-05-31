package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class NickCheckCommand implements MInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nickName = request.getParameter("nickName")==null ? "" : request.getParameter("nickName");
		
		MemberDAO dao = new MemberDAO();
		
		String name = dao.nickCheck(nickName);

		if(name.equals("")) {  // 사용 가능한 닉네임
			request.setAttribute("res", 1);
		}
		else {
			request.setAttribute("res", 0);   // 이미 사용중인 닉네임이 있음.
		}
		request.setAttribute("nickName", nickName);
	}

}
