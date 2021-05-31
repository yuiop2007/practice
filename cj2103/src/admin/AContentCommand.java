package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;

public class AContentCommand implements AInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberDAO dao = new MemberDAO();
		
		int delMemberCount = dao.delMemberCount();	// 삭제신청회원 인원수 가져오기
		int newMemberCount = dao.newMemberCount();  // 준회원 인원수 가져오기
		
		request.setAttribute("delMemberCount", delMemberCount);
		request.setAttribute("newMemberCount", newMemberCount);
	}

}
