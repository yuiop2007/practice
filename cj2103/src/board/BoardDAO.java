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
			/* sql = "select * from board order by idx desc limit ?, ?"; */
			sql = "select *, (select count(*) from replyBoard where boardIdx = board.idx) as replyCount  from board order by idx desc limit ?, ?";
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
				
				// 댓글수 처리
				vo.setReplyCount(rs.getInt("replyCount"));
				
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
			if(rs.next()) res = 1;  // 기존 게시글이 존재할때(즉, 비밀번호가 맞을경우 res는 1을 돌려준다.)
		} catch (SQLException e) {
			System.out.println("SQL Error : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return res;
	}

	// 게시글 업데이트 처리
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

	// 게시글 삭제처리
	public void bDelete(int idx) {
		try {
			sql = "delete from replyBoard where boardIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			getConn.pstmtClose();
			
			sql = "delete from board where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL Error : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}

	// 댓글 입력처리
	public void bReplyInput(ReplyBoardVO rVo) {
		try {
			sql = "insert into replyBoard values (default,?,?,?,default,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rVo.getBoardIdx());
			pstmt.setString(2, rVo.getMid());
			pstmt.setString(3, rVo.getNickName());
			pstmt.setString(4, rVo.getHostIp());
			pstmt.setString(5, rVo.getContent());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL Error : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}

	// 댓글 가져오기
	public List<ReplyBoardVO> getReply(int idx) {
		List<ReplyBoardVO> rVos = new ArrayList<ReplyBoardVO>();
		try {
			sql = "select * from replyBoard where boardIdx = ? order by idx desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReplyBoardVO rVo = new ReplyBoardVO();
				
				rVo.setIdx(rs.getInt("idx"));
				rVo.setMid(rs.getString("mid"));
				rVo.setNickName(rs.getString("nickName"));
				
  			// 1일전은 시간으로 1일 이후는 날짜로 화면에 표시하기위함
				rVo.setwDate(rs.getString("wDate"));
				TimeDiff timeDiff = new TimeDiff();
				int wNdate = timeDiff.timeDiff(rs.getString("wDate"));
				rVo.setwNdate(wNdate);
				
				rVo.setHostIp(rs.getString("hostIp"));
				rVo.setContent(rs.getString("content"));
				
				rVos.add(rVo);
			}
		} catch (SQLException e) {
			System.out.println("SQL Error : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return rVos;
	}

	// 댓글 삭제처리
	public void bReplyDelete(int replyIdx) {
		try {
			sql = "delete from replyBoard where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, replyIdx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL Error : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		
	}

	// 검색기 처리루틴(글제목, 글쓴이, 글내용)
	public List<BoardVO> getBSearch(String search, String searchString, int startIndexNo, int pageSize) {
		List<BoardVO> vos = new ArrayList<BoardVO>();
		try {
			//sql = "select * from board where " + search + " like ? order by idx desc limit ?, ?";
			sql = "select * from board where " + search + " like ? order by idx desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+searchString+"%");
//			pstmt.setInt(2, startIndexNo);
//			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
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

	// '이전글/다음글'에 대한 검색 처리
	public BoardVO preNextSearch(String str, int idx) {
		vo = new BoardVO();
		try {
			if(str.equals("pre")) {
				sql = "select * from board where idx < ? order by idx desc limit 1";  // 이전글
			}
			else {
				sql = "select * from board where idx > ? limit 1";		// 다음글
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(str.equals("pre") && rs.next()) {
				vo.setPreIdx(rs.getInt("idx"));
				vo.setPreTitle(rs.getString("title"));
			}
			else if(str.equals("next") && rs.next()) {
				vo.setNextIdx(rs.getInt("idx"));
				vo.setNextTitle(rs.getString("title"));
			}
			else {
				vo.setPreIdx(0);
				vo.setNextIdx(0);
			}
		} catch (SQLException e) {
			System.out.println("SQL Error : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	// 사용자가 올린 게시글 목록 가져오기
	public List<BoardVO> getMyBoard(String snickName) {
		List<BoardVO> vos = new ArrayList<BoardVO>();
		try {
			sql = "select * from board where name = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, snickName);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
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

}
