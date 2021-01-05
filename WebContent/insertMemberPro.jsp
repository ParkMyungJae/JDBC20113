<%@page import="member.MemberVO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	/* 한글이 꺠지지 않게 UTF-8로 인코딩 포맷을 해줍니다.  */
	request.setCharacterEncoding("UTF-8");
	
	//MemberDAO 인스턴스를 불러와서 DAO 사용을 준비합니다.
	MemberDAO instance = MemberDAO.getInstance();
	
	//MemberVO의 새 인스턴스를 생성하여 vo 사용을 준비합니다.
	MemberVO vo = new MemberVO();
	
	//vo에 각각 형식에 맞게 setxxx으로 vo 내의 변수에 넣어줍니다.
	//넣을때에 형식에 맞춰서 넣어줘야 합니다.
	vo.setMemno(instance.getMaxNo() + 1);
	vo.setName(request.getParameter("name"));
	vo.setId(request.getParameter("id"));
	vo.setPass(request.getParameter("pass"));
	vo.setBirth(Integer.parseInt(request.getParameter("birth")));
	vo.setGender(request.getParameter("gender"));
	vo.setJob(request.getParameter("job"));
	vo.setCity(request.getParameter("city"));
	
	//msg는 멤버들의 가입 성공/실패 여부를 메시지로 찍어주기 위해 사용합니다.
	//자바스크립트 코드에서 사용이 될 것입니다.
	String msg = "";
	//아이디 중복 체크하는 페이지에서도 해당 메서드를 통해 걸렀으나 가입시에도 최종으로 걸러야 중복되는 아이디 가입을 막을 수가 있습니다.
	//따라서 idAvailableChk 메서드를 다시 사용해서 사용가능하다는 true 값을 반환해준다면 멤버 가입을 성공시켜주고  아니라면 중복 아이디라고 else로 빠지게 되어있습니다.
	//만약 가입시 isnertMember메서드에서 성공 여부 값인 1이 아닌 값이 나올 경우  가입 처리 실패이자 코드 처리 문제이기에 시스템 오류 메세지를 뿌리게 해놓았습니다.
	
	//비밀번호와 비밀번호 확인을 하여 일치하면 아이디 중복여부 체크하고 아니면 비밀번호 다르면 일치하지 않다는 메시지 출력 후 가입은 미처리 하고 select로 이동.
	if(request.getParameter("pass").equals(request.getParameter("rePass"))) {
		if(instance.idAvailableChk(request.getParameter("id")) == true) {
			if (instance.insertMember(vo) == 1) msg = "멤버 가입 성공";
			else msg = "멤버 가입 실패 : 시스템 오류";	
		}
		else msg = "Error : 중복된 아이디입니다. 다른 아이디를 사용해주세요.";
	}
	else msg = "오류 : 비밀번호와 비밀번호 확인이 일치하지 않습니다.";
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
</head>
<body>
	<!-- 얼럿으로 msg를 보여주고 alert ps가 끝나면 바로 selectMember.jsp로 이동이 되게 제작되었습니다. -->
	<script>
		alert("<%=msg%>");
		location.href("selectMember.jsp");
	</script>
</body>
</html>