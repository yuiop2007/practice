package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conn.GetConn;

public class MemberDAO {
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	MemberVO vo = null;
	
	// 아이디 중복체크
	public String idCheck(String mid) {
		String name = "";
		try {
			sql = "select * from member where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) name = rs.getString("name");
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return name;
	}
	
	// 닉네임 중복체크
	public String nickCheck(String nickName) {
		String name = "";
		try {
			sql = "select * from member where nickName = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nickName);
			rs = pstmt.executeQuery();
			if(rs.next()) name = rs.getString("name");
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return name;
	}

	// 해시테이블에서 pwdValue값 가져오기
	public long hashTableSearch(int pwdKey) {
		long pwdValue = 0;
		try {
			sql = "select * from hashTable where pwdKey = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pwdKey);
			rs = pstmt.executeQuery();
			rs.next();
			pwdValue = rs.getLong("pwdValue");
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return pwdValue;
	}

	// 회원 가입 처리
	public int joinOk(MemberVO vo) {
		int res = 0;
		try {
			sql = "insert into member values (default,?,?,?,?,?,?,?,?,?,?,?,?,?,?,default,default,default,default,default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getPwd());
			pstmt.setInt(3, vo.getPwdKey());
			pstmt.setString(4, vo.getNickName());
			pstmt.setString(5, vo.getName());
			pstmt.setString(6, vo.getGender());
			pstmt.setString(7, vo.getBirthday());
			pstmt.setString(8, vo.getTel());
			pstmt.setString(9, vo.getAddress());
			pstmt.setString(10, vo.getEmail());
			pstmt.setString(11, vo.getHomePage());
			pstmt.setString(12, vo.getJob());
			pstmt.setString(13, vo.getHobby());
			pstmt.setString(14, vo.getUserInfor());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 아이디 검색하여 정보 가져오기
	public MemberVO loginOk(String mid) {
		try {
			sql = "select * from member where mid = ? and userDel = 'NO'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo = new MemberVO();
				vo.setMid(mid);
				vo.setPwd(rs.getString("pwd"));
				vo.setPwdKey(rs.getInt("pwdKey"));
				vo.setNickName(rs.getString("nickName"));
				vo.setLevel(rs.getInt("level"));
			}
			else {
				vo = null;
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	// 최종 방문일, 방문횟수 업데이트 처리
	public void lastdateUpdate(String mid) {
		try {
			sql = "update member set lastDate = now(), visitCnt = visitCnt + 1 where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}

	// 전체 리스트 검색
	public List<MemberVO> aMList(int startIndexNo, int pageSize) {
		List<MemberVO> vos = new ArrayList<MemberVO>();
		try {
			sql = "select * from member order by idx desc limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new MemberVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setPwd(rs.getString("pwd"));
				vo.setPwdKey(rs.getInt("pwdKey"));
				vo.setNickName(rs.getString("nickName"));
				vo.setName(rs.getString("name"));
				vo.setGender(rs.getString("gender"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setTel(rs.getString("tel"));
				vo.setAddress(rs.getString("address"));
				vo.setEmail(rs.getString("email"));
				vo.setHomePage(rs.getString("homePage"));
				vo.setJob(rs.getString("job"));
				vo.setHobby(rs.getString("hobby"));
				vo.setUserInfor(rs.getString("userInfor"));
				vo.setUserDel(rs.getString("userDel"));
				vo.setLevel(rs.getInt("level"));
				vo.setVisitCnt(rs.getInt("visitCnt"));
				vo.setStartDate(rs.getString("startDate"));
				vo.setLastDate(rs.getString("lastDate"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 + " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 총 레코드 건수
	public int totRecCnt() {
		int res = 0;
		try {
			sql = "select count(*) from member";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) res = rs.getInt(1); 
		} catch (SQLException e) {
			System.out.println("SQL 에러 + " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return res;
	}

	// 개별 자료 검색
	public MemberVO aMInfor(String mid) {
		vo = new MemberVO();
		try {
			sql = "select * from member where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			rs.next();
			
			vo.setIdx(rs.getInt("idx"));
			vo.setMid(rs.getString("mid"));
			vo.setPwd(rs.getString("pwd"));
			vo.setPwdKey(rs.getInt("pwdKey"));
			vo.setNickName(rs.getString("nickName"));
			vo.setName(rs.getString("name"));
			vo.setGender(rs.getString("gender"));
			vo.setBirthday(rs.getString("birthday"));
			vo.setTel(rs.getString("tel"));
			vo.setAddress(rs.getString("address"));
			vo.setEmail(rs.getString("email"));
			vo.setHomePage(rs.getString("homePage"));
			vo.setJob(rs.getString("job"));
			vo.setHobby(rs.getString("hobby"));
			vo.setUserInfor(rs.getString("userInfor"));
			vo.setUserDel(rs.getString("userDel"));
			vo.setLevel(rs.getInt("level"));
			vo.setVisitCnt(rs.getInt("visitCnt"));
			vo.setStartDate(rs.getString("startDate"));
			vo.setLastDate(rs.getString("lastDate"));
		} catch (SQLException e) {
			System.out.println("SQL 에러 + " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	// 회원 등급 업데이트 처리
	public void aMLevel(int idx, int level) {
		try {
			sql = "update member set level = ? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, level);
			pstmt.setInt(2, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 에러 + " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}

	// 개별자료 검색
	public MemberVO mSearch(String mid) {
		vo = new MemberVO();
		try {
			sql = "select * from member where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			rs.next();
			
			vo.setIdx(rs.getInt("idx"));
			vo.setMid(rs.getString("mid"));
			vo.setPwd(rs.getString("pwd"));
			vo.setPwdKey(rs.getInt("pwdKey"));
			vo.setNickName(rs.getString("nickName"));
			vo.setName(rs.getString("name"));
			vo.setGender(rs.getString("gender"));
			vo.setBirthday(rs.getString("birthday"));
			vo.setTel(rs.getString("tel"));
			vo.setAddress(rs.getString("address"));
			vo.setEmail(rs.getString("email"));
			vo.setHomePage(rs.getString("homePage"));
			vo.setJob(rs.getString("job"));
			vo.setHobby(rs.getString("hobby"));
			vo.setUserInfor(rs.getString("userInfor"));
			vo.setUserDel(rs.getString("userDel"));
			vo.setLevel(rs.getInt("level"));
			vo.setVisitCnt(rs.getInt("visitCnt"));
			vo.setStartDate(rs.getString("startDate"));
			vo.setLastDate(rs.getString("lastDate"));
		} catch (SQLException e) {
			System.out.println("SQL 에러 + " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}
}
