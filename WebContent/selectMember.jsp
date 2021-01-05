<%@page import="member.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레코드 출력</title>
</head>
<body>
<!--  header를 인클루드 해줍니다. -->
	<jsp:include page="header.jsp" />
	
<%
	//MemberDAO 인스턴스를 생성하여 사용 준비를 합니다.
	MemberDAO instance = MemberDAO.getInstance();
	//ArrayList를 생성하여 새로 생성한 리스트 (변수 : list)에 instance.selectMember();를 넣어줍니다.
	//미리 DAO에서 전체목록을 조회하는 부분을 메서드화 해놓았기 때문에 해당 메서드에서 list로 return(반환)됩니다.
	//instance.selectMembers(); 자체가 list 반환이라 list라 보면 되기에 새로 생성한 list에 list를 넣었습니다.
	ArrayList<MemberVO> list = instance.selectMembers();
%>

<h2>회원 목록</h2>
<table border="1">
	<tr align="center">
		<th width="100">회원번호</th>
		<th width="100">이름</th><th width="100">아이디</th>
		<th width="100">비밀번호</th><th width="100">생년(4자리)</th>
		<th width="50">성별</th><th width="100">직업</th>
		<th width="100">도시</th><th width="100">가입일자</th>
		<th width="50">탈퇴</th>
	</tr>

<%
	//for 문을 돌려 위에 만든 전체목록을 담고 있는 리스트의 사이즈만큼 반복해줍니다.
	for(int i = 0; i < list.size(); i++) {
		//MemberVO 에 list.get(i);를 해주어 각각 vo 형식에 맞게 담아줍니다.
		//사용사에는 vo.getXXX로 사용이 가능하게 되었습니다.
		//list.get(i)로 포문 한번 돌고 또돌고 또돌고 해서 html 테이블을 리스트 사이즈만큼 돌아 리스트를 표시화 해줍니다.
		MemberVO vo = list.get(i);
		String gender = "";
		//성별을 M 또는 남자 로 받으면 남자로 표시해주고 F 또는 여자 로 받으면 여자 라고 표시됩니다.
		//구분 실패할 경우 구분오류 라고 나옵니다.
		if(list.get(i).getGender().equals("M") || list.get(i).getGender().equals("m") || list.get(i).getGender().equals("남자")) {
			gender = "남자";
		}
		else if(list.get(i).getGender().equals("F") || list.get(i).getGender().equals("f") || list.get(i).getGender().equals("여자")) {
			gender = "여자";
		}
		else gender = "구분오류";
%>
	<!-- 표현식 태그를 사용하여 vo.getXXX()으로 각각 테이블 요소에 맞게 데이터를 스트링화 해 들어가 표시되고 있습니다.  -->
	<tr align="center">
		<td width="100"><a href="updateMember.jsp?memno=<%= vo.getMemno() %>"><%= vo.getMemno() %></a></td>
		<td width="100"><%= vo.getName() %></td><td width="100"><%= vo.getId() %></td>
		<td width="100"><%= vo.getPass() %></td><td width="100"><%= vo.getBirth() %></td>
		<td width="50"><%= gender %></td><td width="100"><%= vo.getJob() %></td>
		<td width="100"><%= vo.getCity() %></td><td width="100"><%= vo.getJoinDate() %></td>
		<td width="50"><a href="deleteMember.jsp?memno=<%= vo.getMemno() %>">탈퇴</a></td>
	</tr>
<%
	}
%>
</table>

<!--  footer를 인클루드 해줍니다. -->
<jsp:include page="footer.jsp" />
</body>
</html>