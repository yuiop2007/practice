package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conn.GetConn;

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
				vo.setwDate(rs.getString("wDate"));
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

}
