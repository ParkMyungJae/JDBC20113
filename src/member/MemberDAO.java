package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MemberDAO {
	// 싱글톤 구성
	private static MemberDAO instance = new MemberDAO();

	private MemberDAO() {
	}

	public static MemberDAO getInstance() {
		return instance;
	}

	// DB
	Connection conn = null; // 커넥션 객체 생성
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	// 드라이버 로드 db연결
	// 메서드로 db연결을 위한 구성을 해놓음.
	// 디비 주소와 유저이름, 비번과 연결 객체를 가져와서 드라이버를 로드해 연결시켜준다.
	public Connection getConnection() {
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "hr";
		String password = "1234";
		Connection conn = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, password);
			System.out.println("오라클 접속 성공");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return conn;
	}

	public int getMaxNo() {
		// memno의 최대값을 return
		int memno = 0;

		try {
			conn = instance.getConnection();
			String getMaxNoSql = "SELECT MAX(MEMNO) FROM MEMBER_TBL";
			pstmt = conn.prepareStatement(getMaxNoSql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				memno = rs.getInt(1);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return memno;
	}

	// 데이터베이스 안에 있는 모든 멤버정보를 가져와 ArrayList 안에 넣어줍니다.
	// 그리고 Arraylist[변수명 : list]를 리턴해주어 사용할 곳에서 for문만 돌려주면 매우 간단하게 메서드 이용이 가능합니다.

	public ArrayList<MemberVO> selectMembers() {
		ArrayList<MemberVO> list = new ArrayList<MemberVO>();

		try {
			conn = instance.getConnection();
			String sql = "SELECT * FROM MEMBER_TBL ORDER BY MEMNO DESC";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MemberVO vo = new MemberVO();
				vo.setMemno(rs.getInt(1));
				vo.setName(rs.getString(2));
				vo.setId(rs.getString(3));
				vo.setPass(rs.getString(4));
				vo.setBirth(rs.getInt(5));
				vo.setGender(rs.getString(6));
				vo.setJob(rs.getString(7));
				vo.setCity(rs.getString(8));
				vo.setJoinDate(rs.getDate(9));

				list.add(vo);
			}
			System.out.println("멤버 출력 완료");

		} catch (Exception e) {
			// try 안에 있는 코드와 오류를 잡아서
			System.out.println("selectMembers() 오류");
			e.printStackTrace();
		}

		return list;
	}

	// 멤버를 등록할 때에 사용하는 메서드입니다.
	// 해당 메서드에 MemberVO 형식에 맞춰 집어 넣으면
	// 메서드 안에서 vo에 들어간 것을 get으로 각각 가져와 sql 쿼리를 해줍니다.
	// executeQuery에 성공한다면 정상적으로 멤버등록에 성공하게 됩니다.
	// 만약 실패한다면 catch로 빠지고 익셉션 이벤트 값이 프린트 될 것입니다.
	// 해당 메서드는 status라는 int형 변수로 0이면 실패, 1이면 성공으로 값을 리턴해줍니다.
	public int insertMember(MemberVO vo) {
		int status = 0;

		try {
			conn = instance.getConnection();
			String insertSql = "INSERT INTO MEMBER_TBL VALUES(?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";
			pstmt = conn.prepareStatement(insertSql);
			pstmt.setInt(1, vo.getMemno());
			pstmt.setString(2, vo.getName());
			pstmt.setString(3, vo.getId());
			pstmt.setString(4, vo.getPass());
			pstmt.setInt(5, vo.getBirth());
			pstmt.setString(6, vo.getGender());
			pstmt.setString(7, vo.getJob());
			pstmt.setString(8, vo.getCity());
			pstmt.executeQuery();

			status = 1;
			System.out.println("멤버 등록 성공");

		} catch (Exception e) {
			System.out.println("insertMembers() 오류");
			e.printStackTrace();
		}

		close(null, pstmt, conn);
		return status;

	}

	// 해당 메서드는 멤버정보를 변경할때에 사용하는 메서드입니다.
	// 위의 insertMember()와 동일하게 vo 형식으로 넣어서 get으로 각각 뽑아와 sql UPDATE문으로 데이터베이스의 각 칼럼
	// 값을 업데이트 해주는 역할을 합니다.
	// status가 0이면 실패, 1이면 성공을 의미하는 int형 변수를 return합니다.
	public int updateMember(MemberVO vo) {
		int status = 0;

		try {
			conn = instance.getConnection();

			String updateSql = "UPDATE MEMBER_TBL SET PASS = ?, BIRTH = ?, GENDER = ?, JOB= ?, CITY= ? WHERE MEMNO = ?";

			pstmt = conn.prepareStatement(updateSql);

			pstmt.setString(1, vo.getPass());
			pstmt.setInt(2, vo.getBirth());
			pstmt.setString(3, vo.getGender());
			pstmt.setString(4, vo.getJob());
			pstmt.setString(5, vo.getCity());
			pstmt.setInt(6, vo.getMemno());

			pstmt.executeUpdate();
			status = 1;
			System.out.println("멤버 정보 변경 성공");

		} catch (Exception e) {
			System.out.println("updateMember() 오류");
			e.printStackTrace();
		}

		close(null, pstmt, conn);
		return status;
	}

	// 멤버 삭제하는 메서드
	// 해당 메서드에 멤버번호를 넣으면 해당 번호의 멤버가 삭제됩니다.
	// status가 1이면 성공, 0이면 실패로 값을 return합니다.
	public int deleteMember(int memno) {
		int status = 0;

		try {
			conn = instance.getConnection();
			String sql = "DELETE FROM MEMBER_TBL WHERE MEMNO = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memno);
			pstmt.executeUpdate();

			status = 1;

			System.out.println("멤버 삭제 완료");

		} catch (Exception e) {
			System.out.println("deleteMember() 오류");
			e.printStackTrace();
		}

		close(rs, pstmt, conn);
		return status;
	}

	// 멤버 한명 정보 출력
	// MemberVO의 새 인스턴스를 호출하고 vo 형식에 맞게 각각 set으로 데이터베이스로부터 값을 가져온 rs변수를 형식에 맞게 잘
	// 넣어줍니다.
	// vo 변수를 return하여 사용할 곳에서 바로 가공할 수 있게 하였습니다.
	public MemberVO getAMember(int memno) {
		MemberVO vo = new MemberVO();

		try {
			conn = instance.getConnection();
			String sql = "SELECT * FROM MEMBER_TBL WHERE MEMNO = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memno);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				vo.setMemno(rs.getInt(1));
				vo.setName(rs.getString(2));
				vo.setId(rs.getString(3));
				vo.setPass(rs.getString(4));
				vo.setBirth(rs.getInt(5));
				vo.setGender(rs.getString(6));
				vo.setJob(rs.getString(7));
				vo.setCity(rs.getString(8));
				vo.setJoinDate(rs.getDate(9));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		close(rs, pstmt, conn);
		return vo;
	}

	// 해당 메서드는 db 관련 객체들의 사용이 끝났을때에 끝났다고 정리를 해주는 메서드입니다.
	// close시 역순으로 해주어야 합니다.
	// 자원 반환
	public void close(ResultSet rs, PreparedStatement pstmt, Connection conn) {
		if (rs != null)
			try {
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		if (pstmt != null)
			try {
				pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		if (conn != null)
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
	}
	
	//아이디 중복 체크해주는 메서드입니다.
	//status라는 변수명으로 boolean형 true false를 리턴받습니다.
	//sql문으로 해당 유저 아이디를 검색해서 존재하면 false, 존재하지 않으면 true로 하여
	//아이디 사용 가능여부를 알려줍니다.
	//아이디 중복 확인 페이지에서 해당 메서드를 사용하며
	//회원가입 PRO 페이지에서도 해당 메서드를 거쳐 최종 회원가입에 좌우를 시켜줍니다.
	public boolean idAvailableChk(String id) {
		boolean status = false;
		
		try {
			conn = instance.getConnection();
			String checkSql = "SELECT * FROM MEMBER_TBL WHERE id = ?";
			
			pstmt = conn.prepareStatement(checkSql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(!rs.next()) status = true;
			
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("idAvailableChk() 오류");
			e.printStackTrace();
		}
		
		return status;
	}
}