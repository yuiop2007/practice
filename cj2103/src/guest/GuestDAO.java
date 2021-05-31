package guest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class GuestDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	GuestVO vo = null;
	
	private String url = "jdbc:mysql://localhost:3306/works";
	private String user = "root";
	private String password = "1234";
	
	public GuestDAO() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 검색실패!");
		} catch (Exception e) {
			System.out.println("데이터베이스 연동 실패!!");
		}
	}
	
	public void pstmtClose() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {}
		}
	}
	
	public void rsClose() {
		if(rs != null) {
			try {
				rs.close();
				pstmtClose();
			} catch (SQLException e) {}
		}
	}
	
	// 조건 자료조회(페이지별조회/초기화면조회)
	public List<GuestVO> gList(int startIndexNo, int pageSize) {
		List<GuestVO> vos = new ArrayList<GuestVO>();
		try {
			sql = "select * from guest order by idx desc limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				GuestVO vo = new GuestVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setName(rs.getString("name"));
				vo.setEmail(rs.getString("email"));
				vo.setHomepage(rs.getString("homepage"));
				vo.setVdate(rs.getString("vdate"));
				vo.setHostip(rs.getString("hostip"));
				vo.setContent(rs.getString("content"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러" + e.getMessage());
		} finally {
			rsClose();
		}
		
		return vos;
	}
	
	// 방문소감 등록처리
	public boolean setGInput(GuestVO vo) {
		boolean res = false;
		
		try {
			sql = "insert into guest values (default,?,?,?,default,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getEmail());
			pstmt.setString(3, vo.getHomepage());
			pstmt.setString(4, vo.getHostip());
			pstmt.setString(5, vo.getContent());
			pstmt.executeUpdate();
			res = true;
		} catch (SQLException e) {
			System.out.println("SQL 에러" + e.getMessage());
		} finally {
			pstmtClose();
		}
		
		return res;
	}

	// 게시글 삭제 처리
	public boolean gDelete_comment(int idx) {
		boolean res = false;
		try {
			sql = "delete from guest where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res = true;
		} catch (SQLException e) {
			System.out.println("SQL 에러" + e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}
	
	// 총 레코드 건수 구하기
	public int totRecCnt() {
		int totRecCnt = 0;
		try {
			sql = "select count(*) from guest";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totRecCnt = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러" + e.getMessage());
		} finally {
			rsClose();
		}
		return totRecCnt;
	}
	
	
}
