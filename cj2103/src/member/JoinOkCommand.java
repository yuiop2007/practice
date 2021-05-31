package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class JoinOkCommand implements MInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		String nickName = request.getParameter("nickName")==null ? "" : request.getParameter("nickName");
		String name = request.getParameter("name")==null ? "" : request.getParameter("name");
		String name_ = name;
		String gender = request.getParameter("gender");
		String birthday = request.getParameter("birthday");
		String address = request.getParameter("address")==null ? "" : request.getParameter("address");
		String homePage = request.getParameter("homePage")==null ? "" : request.getParameter("homePage");
		String job = request.getParameter("job");
		String userInfor = request.getParameter("userInfor");
		
		String tel1 = request.getParameter("tel1");
		String tel2 = request.getParameter("tel2")==null ? "" : request.getParameter("tel2");
		String tel3 = request.getParameter("tel3")==null ? "" : request.getParameter("tel3");
		String tel = tel1 + "-" + tel2 + "-" + tel3;
		
		String email1 = request.getParameter("email1")==null ? "" : request.getParameter("email1");
		String email2 = request.getParameter("email2");
		String email = email1 + "@" + email2;
		
		String[] hobbys = request.getParameterValues("hobby");
		String hobby = "";
		for(int i=0; i<hobbys.length; i++) {
			hobby += hobbys[i] + "/";
		}
		hobby = hobby.substring(0, hobby.length()-1);
		
		// 아이디와 닉네임 중복체크를 한번더 한다.
		MemberDAO dao = new MemberDAO();
		
		name = dao.idCheck(mid);
		if(!name.equals("")) {  // 이미 사용중인 아이디가 있다면?
			request.setAttribute("msg", "idCheckNo");
			request.setAttribute("url", request.getContextPath()+"/join.mem");
			return;
		}
		
		name = dao.nickCheck(nickName);
		if(!name.equals("")) {  // 이미 사용중인 닉네임이 있다면?
			request.setAttribute("msg", "nickCheckNo");
			request.setAttribute("url", request.getContextPath()+"/join.mem");
			return;
		}
	
		// 정상적인 자료일경우는 입력준비처리...
		
		// 비밀번호 암호화처리
		long intPwd;
		String strPwd = "";
		for(int i=0; i<pwd.length(); i++) {
			intPwd = (long) pwd.charAt(i);
			strPwd += intPwd;
		}
		intPwd = Long.parseLong(strPwd);
		
		int pwdKey = (int)(Math.random()*20);
		long pwdValue = dao.hashTableSearch(pwdKey);
		long encPwd;
		encPwd = intPwd ^ pwdValue;
		strPwd = String.valueOf(encPwd);
		
		// 아이디, 닉네임, 비밀번호 체크를 마치고, 회원가입처리(set)한다.
		MemberVO vo = new MemberVO();
		vo.setMid(mid);
		vo.setPwd(strPwd);
		vo.setPwdKey(pwdKey);
		vo.setNickName(nickName);
		vo.setName(name_);
		vo.setGender(gender);
		vo.setBirthday(birthday);
		vo.setTel(tel);
		vo.setAddress(address);
		vo.setEmail(email);
		vo.setHomePage(homePage);
		vo.setJob(job);
		vo.setHobby(hobby);
		vo.setUserInfor(userInfor);
		
		int res = dao.joinOk(vo);
		
		if(res == 1) {
			request.setAttribute("msg", "joinOk");
			request.setAttribute("url", request.getContextPath()+"/login.mem");
		}
		else {
			request.setAttribute("msg", "joinNo");
			request.setAttribute("url", request.getContextPath()+"/join.mem");
		}
	}

}
