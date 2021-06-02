package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conn.GetConn;
import conn.TimeDiff;

public class BoardDAO {
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
			
	private String sql = "";
	
	BoardVO vo = null;

	// 총 레코드 건수
	public int totRecCnt() {
		int totRecCnt = 0;
		try {
			sql = "select count(*) from board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt(1);
		} catch (SQLException e) {
			System.out.println("SQL Error : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return totRecCnt;
	}

	// 전제 게시글 조회
	public List<BoardVO> bList(int startIndexNo, int pageSize) {
		List<BoardVO> vos = new ArrayList<BoardVO>();
		try {
			sql = "select * from board order by idx desc limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				/*
				vo = new BoardVO(
						rs.getInt("idx"),
						rs.getString("name"),
						rs.getString("title"),
						rs.getString("email"),
						rs.getString("pwd"),
						rs.getString("wDate"),
						rs.getInt("readNum"),
						rs.getString("hostIp"),
						rs.getInt("good"),
						rs.getString("content")
				);
				*/
				
				vo = new BoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setName(rs.getString("name"));
				vo.setTitle(rs.getString("title"));
				vo.setEmail(rs.getString("email"));
				vo.setPwd(rs.getString("pwd"));
				
				vo.setwDate(rs.getString("wDate"));   // 날짜필드를 날짜형식 자료
				vo.setwCdate(rs.getString("wDate"));  // 날짜필드를 문자형식의 자료
				TimeDiff timeDiff = new TimeDiff();		// 날짜를 시간형식으로 계산하기 위한 메소드 생성
				int res = timeDiff.timeDiff(vo.getwCdate());  // 시간형식으로계산된 정수값(시간)을 받아온다.
				vo.setwNdate(res);  // 시간차를 숫자형식으로 저장..
				
				vo.setReadNum(rs.getInt("readNum"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setGood(rs.getInt("good"));
				vo.setContent(rs.getString("content"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL Error : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 게시글 등록하기
	public int bInputOk(BoardVO vo) {
		int res = 0;
		try {
			sql = "insert into board values (default,?,?,?,?,default,default,?,default,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getTitle());
			pstmt.setString(3, vo.getEmail());
			pstmt.setString(4, vo.getPwd());
			pstmt.setString(5, vo.getHostIp());
			pstmt.setString(6, vo.getContent());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL Error : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 개별 게시글 조회하기
	public BoardVO bContent(int idx) {
		vo = new BoardVO();
		try {
			sql = "select * from board where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setIdx(idx);
				vo.setName(rs.getString("name"));
				vo.setTitle(rs.getString("title"));
				vo.setEmail(rs.getString("email"));
				vo.setPwd(rs.getString("pwd"));
				vo.setwDate(rs.getString("wDate"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setGood(rs.getInt("good"));
				vo.setContent(rs.getString("content"));
			}
		} catch (SQLException e) {
			System.out.println("SQL Error : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	// 조회수 증가하기
	public void readNumUpdate(int idx) {
		try {
			sql = "update board set readNum = readNum + 1 where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL Error : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		
	}

	// 좋아요 클릭수 증가처리
	public void bGood(int idx) {
		try {
			sql = "update board set good = good + 1 where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL Error : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}

	// 비밀번호 체크...
	public int getPwdCheck(int idx, String pwd) {
		int res = 0;
		try {
			sql = "select idx from board where idx = ? and pwd = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			if(rs.next()) res = 1;
		} catch (SQLException e) {
			System.out.println("SQL Error : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return res;
	}

	public int bUpdateOk(BoardVO vo, int idx) {
	  int res = 0;
	  try {
	  	if(!vo.getPwd().equals("")) {
				sql = "update board set name=?,title=?,email=?,pwd=?,hostIp=?,content=? where idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, vo.getName());
				pstmt.setString(2, vo.getTitle());
				pstmt.setString(3, vo.getEmail());
				pstmt.setString(4, vo.getPwd());
				pstmt.setString(5, vo.getHostIp());
				pstmt.setString(6, vo.getContent());
				pstmt.setInt(7, idx);
	  	}
	  	else {
	  		sql = "update board set name=?,title=?,email=?,hostIp=?,content=? where idx=?";
	  		pstmt = conn.prepareStatement(sql);
	  		pstmt.setString(1, vo.getName());
	  		pstmt.setString(2, vo.getTitle());
	  		pstmt.setString(3, vo.getEmail());
	  		pstmt.setString(4, vo.getHostIp());
	  		pstmt.setString(5, vo.getContent());
	  		pstmt.setInt(6, idx);
	  	}
			pstmt.executeUpdate();
			res = 1;
	  } catch (SQLException e) {
			System.out.println("SQL Error : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

}
