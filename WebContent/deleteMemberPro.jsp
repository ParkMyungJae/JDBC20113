<%@page import="member.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/* 인코딩 방식을 UTF-8로 해주어  한글 깨짐 방지를 해줍니다. */
	request.setCharacterEncoding("UTF-8");

	/* memno에 대한 값을 GET방식으로 넘어왔기에 받아줍니다. */
	//memno의 경우 int 값인데 넘어올때 String으로 넘어오기에 형변환을 해줍니다.
	//Integer.parseInt()로 내용 감싸주면 형변환이 됩니다.
	int memno = Integer.parseInt(request.getParameter("memno"));
	String pass = request.getParameter("pass");
	
	//MemberDAO 인스턴스 사용 준비를 합니다.
	MemberDAO instance = MemberDAO.getInstance();
	//msg 변수에는 탈퇴 성공여부 실패여부를 보여줍니다.
	//자바스크립트에서 클라이언트에게 보여줄 것입니다.
	String msg = null;

	//ArrayList를 생성해줍니다.
	ArrayList<MemberVO> list = new ArrayList<>();
	//리스트에 instance.getAMember(memno) 를 넣어줍니다.
	//해당 메서드는 memno를 넣어서 그 유저에 대한 정보를 vo로 리턴(반환) 해주기 때문에 바로 리스트에 넣어줄 수가 있습니다.
	list.add(instance.getAMember(memno));
	
	//사용자에게 입력받은 비밀번호와 리스트 안에 있는 비밀번호가 일치하다면 멤버 탈퇴하는 메서드를 동작시키고 msg 탈퇴완료를 보여줍니다.
	//실패라면 else로 빠지게 되며 비밀번호가 다르다고 알려줍니다.
	if(pass.equals(list.get(0).getPass())) {
		instance.deleteMember(memno);
		msg = "멤버 탈퇴 완료";
	}
	else msg = "탈퇴 실패 : 비밀번호 오류";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
</head>
<body>
	<script>
		alert("<%= msg %>");
		location.href("selectMember.jsp");
	</script>
</body>
</html>