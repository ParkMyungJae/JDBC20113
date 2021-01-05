<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- html 문서 인코딩 방식을 잡아줍니다. -->
<meta charset="UTF-8">
<!-- 타이틀은  웹 타이틀 공간에 표시가  됩니다. -->
<title>회원 탈퇴</title>
</head>
<body>
<!-- GET 방식으로 넘어온 memno를 int형 변수에 담아놓습니다. -->
<% int memno = Integer.parseInt(request.getParameter("memno")); %>

<!-- 헤더를 인클루드 해줍니다. -->
<jsp:include page="header.jsp" />

<h2>회원 탈퇴</h2>
<!-- POST 방식으로 딜리트 프로로 이동하여 해당 memno에 대한 비밀번호가 맞다면 탈퇴처리되게 해주는 form을 제작하였습니다. -->
<form method="POST" action="deleteMemberPro.jsp">
	<!-- hidden 타입을 사용하여 value값을 안보이게, 화면상에 안보이게 전달하는 방식입니다. -->
	<!-- 다만 HTML 문서를 보면, 개발자 도구로 보면 해당 태그가 보여지기 때문에 사용 여부를 잘 판단하여 사용해야 합니다. value 값에 값이 그대로 보이기 때문입니다. -->
	<input type="hidden" name="memno" value="<%=memno%>">
	<!-- 비밀번호는 password로 타입을 설정하여 00000으로 안보이게 처리됩니다.  -->
	비밀번호 : <input type="password" name="pass">
	
	<!-- submit 버튼을 누르면  form 태그가 담고있는 내용을 POST 방식으로 action 해줍니다.  -->
	<input type="submit" value="탈퇴">
</form>

<!-- 푸터를 인클루드 해줍니다. -->
<jsp:include page="footer.jsp" />
</body>
</html>