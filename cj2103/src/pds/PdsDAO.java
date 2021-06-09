package pds;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conn.GetConn;

public class PdsDAO {
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
			
	private String sql = "";
	
	PdsVO vo = null;

	// 총 레코드 건수
	public int totRecCnt(String part) {
		int totRecCnt = 0;
		try {
			if(part.equals("전체")) {
				sql = "select count(*) from pds";
				pstmt = conn.prepareStatement(sql);
			}
			else {
				sql = "select count(*) from pds where part = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, part);
			}
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

	// 전체(조건별 part) 목록 조회
	public List<PdsVO> pList(int startIndexNo, int pageSize, String part) {
		List<PdsVO> vos = new ArrayList<PdsVO>();
		try {
			if(part.equals("전체")) {
				sql = "select * from pds order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
			}
			else {
				sql = "select * from pds where part = ? order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, part);
				pstmt.setInt(2, startIndexNo);
				pstmt.setInt(3, pageSize);
			}
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new PdsVO();
				
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setfName(rs.getString("fName"));
				vo.setfSName(rs.getString("fSName"));
				vo.setfSize(rs.getInt("fSize"));
				vo.setTitle(rs.getString("title"));
				vo.setPart(rs.getString("part"));
				vo.setPwd(rs.getString("pwd"));
				vo.setfDate(rs.getString("fDate"));
				vo.setDownNum(rs.getInt("downNum"));
				vo.setOpenSw(rs.getString("openSw"));
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

	// 자료실 자료파일 저장하기
	public int pInput(PdsVO vo) {
		int res = 0;
		try {
			sql = "insert into pds values (default,?,?,?,?,?,?,?,?,default,default,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getNickName());
			pstmt.setString(3, vo.getfName());
			pstmt.setString(4, vo.getfSName());
			pstmt.setInt(5, vo.getfSize());
			pstmt.setString(6, vo.getTitle());
			pstmt.setString(7, vo.getPart());
			pstmt.setString(8, vo.getPwd());
			pstmt.setString(9, vo.getOpenSw());
			pstmt.setString(10, vo.getContent());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL Error : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 개별 자료 검색
	public PdsVO pContent(int idx) {
		vo = new PdsVO();
		try {
			sql = "select * from pds where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			rs.next();
			
			vo.setIdx(rs.getInt("idx"));
			vo.setMid(rs.getString("mid"));
			vo.setNickName(rs.getString("nickName"));
			vo.setfName(rs.getString("fName"));
			vo.setfSName(rs.getString("fSName"));
			vo.setfSize(rs.getInt("fSize"));
			vo.setTitle(rs.getString("title"));
			vo.setPart(rs.getString("part"));
			vo.setPwd(rs.getString("pwd"));
			vo.setfDate(rs.getString("fDate"));
			vo.setDownNum(rs.getInt("downNum"));
			vo.setOpenSw(rs.getString("openSw"));
			vo.setContent(rs.getString("content"));
		} catch (SQLException e) {
			System.out.println("SQL Error : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	// 다운로드수 증가
	public void pDownCount(int idx) {
		try {
			sql = "update pds set downNum = downNum + 1 where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL Error : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}

	// 비밀번호 체크
	public String pPassCheck(int idx, String pwd) {
		String res = "";
		try {
			sql = "select fSName from pds where idx = ? and pwd = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			if(rs.next()) res = rs.getString(1);
		} catch (SQLException e) {
			System.out.println("SQL Error : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return res;
	}

	// 삭제된 자료파일을 DB에서 기록 삭제하기
	public void pDelete(int idx) {
		try {
			sql = "delete from pds where idx = ?";
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
