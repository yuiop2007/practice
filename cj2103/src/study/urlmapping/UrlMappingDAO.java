package study.urlmapping;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UrlMappingDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	private UrlMappingVO vo = null;
	
	private String driver = "com.mysql.jdbc.Driver";
	private String url = "jdbc:mysql://localhost:3306/works";
	private String user = "root";
	private String password = "1234";
	
	public UrlMappingDAO() {
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 검색 실패!!");
		} catch (Exception e) {
			System.out.println("DB 연동 실패!!");
		}
	}
	
	public void pstmtClose() {
		try {
			if(pstmt != null) pstmt.close();
		} catch (Exception e) {}
	}
	
	public void rsClose() {
		try {
			if(rs != null) {
				rs.close();
			  pstmtClose();
			}
		} catch (Exception e) {}
	}

	// 전체자료 조회
	public List<UrlMappingVO> getUrlMappingList() {
		List<UrlMappingVO> vos = new ArrayList<UrlMappingVO>();
		try {
			sql = "select * from user order by idx desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new UrlMappingVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setName(rs.getString("name"));
				vo.setAge(rs.getInt("age"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}
	
	// 정보 등록
	public int setUInputOk(UrlMappingVO vo) {
		int res = 0;
		try {
			sql = "insert into user values (default, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setInt(2, vo.getAge());
			pstmt.executeUpdate();
			res = 1;
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		
		return res;
	}

	// 정보 삭제
	public int setUDelete(int idx) {
		int res = 0;
		try {
			sql = "delete from user where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res = 1;
		} catch (Exception e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	//정보 수정
	public int setUUpdateOk(UrlMappingVO vo) {
		int res = 0;
		try {
			sql = "update user set name=?, age=? where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setInt(2, vo.getAge());
			pstmt.setInt(3, vo.getIdx());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 오류");
		} finally {
			pstmtClose();
		}
		return res;
	}

}
