<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="member.MemberDAO"%>
<%@page import="org.omg.PortableServer.REQUEST_PROCESSING_POLICY_ID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//인코딩 방식을 UTF-8로 하여 한글 표시에 문제가 없게 포맷해줍니다.
	request.setCharacterEncoding("UTF-8");
	// GET방식으로 넘어온 ID를 String형 변수에 담아 대기시켜줍니다.
	String id = request.getParameter("id");
	//아이디 사용가능 여부를 Boolean형 타입으로 대기해줍니다.
	Boolean status = false;
			
	//MemberDAO 안에 있는  메서드를 사용하기 위해 instance를 불러옵니다. 
	MemberDAO instance = MemberDAO.getInstance();
	//id체크하는 메서드를 사용하고 이게 True면 사용 가능을 나타내고 아니면 false 그대로 유지합니다.
	if(instance.idAvailableChk(id) == true) status = true;
	//status 기본을 false로 두었기 때문에 따로 else문을 미사용해도 됩니다.
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중복 아이디 확인</title>
</head>
<body bgcolor="yellow">
<!-- 각 헤더와 푸터의 jsp 문서를 인클루드 하여 표시가 가능합니다.  -->
<jsp:include page="header.jsp" />

<div align="center">
	<b><%=id %></b>는
	<%
		//status가 True면 사용가능, 아니면 불가능을 html 태그로 뽑아내고 있습니다.
		//if(status) 의 status는 boolean 형이기에 그냥 쓰면 true일 경우만 받아들입니다.
		if(status) {
	%> <font color="blue">사용 가능</font>합니다.
	<% } else {
	%> <font color="red">사용 불가능</font>합니다.
	<% }
	%>
	<hr>
	<!-- 자바스크립트로 팝업창을 닫는 문입니다. -->
	<a href="javascript:self.close()">창 닫기</a>
</div>

<!-- 각 헤더와 푸터의 jsp 문서를 인클루드 하여 표시가 가능합니다.  -->
<jsp:include page="footer.jsp" />
</body>
</html>