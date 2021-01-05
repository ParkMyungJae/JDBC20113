<%@page import="member.MemberVO"%>
<%@page import="java.util.ArrayList"%>
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
<title>회원 정보 수정</title>
</head>
<body>
<%
	/* 한글이 꺠지지 않게 UTF-8로 인코딩 포맷을 해줍니다.  */
	request.setCharacterEncoding("UTF-8");
	//GET 방식인 memno 값을 가져오기 위해 getParameter 사용하고 스트링을 인트로 변환해야 하기에 인티저.파스인트 사용해줍니다.
	int memno = Integer.parseInt(request.getParameter("memno"));
	//MemberDAO 인스턴스를 불러와서 DAO 사용을 준비합니다.
	MemberDAO instance = MemberDAO.getInstance();
	
	//새로운 ArrayList를 생성해줍니다.
	ArrayList<MemberVO> list = new ArrayList<>();
	//생성한 리스트에 getAMember메서드를 활용하여 한명의 유저만 넣어줍니다.
	//리스트에 하나만 넣었고 하나만 사용할 것이기에 list.get(0).getXXX 형식으로 사용하면 됩니다.
	//따라서 for문을 돌리지 않아도 됩니다.
	//getAMember는 vo return(반환) 형식이기에 바로 리스트에 집어넣으면 들어가집니다.
	list.add(instance.getAMember(memno));
%>
<!-- 헤더 인클루드 해줍니다.  -->
<jsp:include page="header.jsp" />

	<form action="updateMemberPro.jsp" method="POST">
		<table border="1" style="width:400">
			<tr><td colspan="2" align="center"><b>회원 수정 정보 입력</b></td></tr>
			<tr><th>회원번호</th><td><input type="text" name="memno" value="<%=list.get(0).getMemno()%>" readonly></td></tr>
			<tr><th>이름</th><td><input type="text" name="name" value="<%=list.get(0).getName()%>" disabled></td></tr>
			<tr><th>아이디</th><td><input type="text" name="id" value="<%=list.get(0).getId()%>" disabled></td></tr>
			<tr><th>비밀번호</th><td><input type="password" name="pass" value="<%=list.get(0).getPass()%>"></td></tr>
			<tr><th>생년(4자리)</th>
				<td>
					<select name ="birth">
					<%
					for(int i = 2001; i <= 2010; i++) {
						if(list.get(0).getBirth() == i) {
					%>
					<option value="<%=i%>" selected><%=i%></option>
					<%
						} else {
					%>
					<option value="<%=i %>"><%=i %></option>
					<%
						}
					}
					%>
					</select>
				</td>
			</tr>
			
			<tr>
				<th>성별</th>
				<td>
				<!-- 남자는M, 여자는 F로 데이터베이스에 저장합니다.  -->
					<% if(list.get(0).getGender().equals("M") || list.get(0).getGender().equals("m") || list.get(0).getGender().equals("남자")) { %>
					<input type="radio" name="gender" value="M" checked> 남자
					<input type="radio" name="gender" value="F"> 여자
					<% } else { %>
					<input type="radio" name="gender" value="M"> 남자
					<input type="radio" name="gender" value="F" checked> 여자
					<% } %>
				</td>
			</tr>
			<tr><th>직업</th><td><input type="text" name="job" value="<%=list.get(0).getJob()%>"></td></tr>
			<tr><th>도시</th><td><input type="text" name="city" value="<%=list.get(0).getCity()%>"></td></tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="수정"> <input type="reset" value="취소">
				</td>
			</tr>
		</table>
	</form>
<!-- 헤더 인클루드 해줍니다.  -->
<jsp:include page="footer.jsp" />
</body>
</html>