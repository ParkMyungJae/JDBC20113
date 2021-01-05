<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<!-- 헤더 인클루드 해줍니다. -->
<jsp:include page="header.jsp" />

<h2>회원 가입</h2>

<!-- form 태그로 POST 형식으로 form 데이타들을 insertMemberPro로 보내줍니다.  -->
<form method="POST" action="insertMemberPro.jsp" name="regForm">
	<table border="1" style="width:400px;">
		<tr>
			<td colspan="2" align="center">
				<b>회원 가입 정보 입력</b>
			</td>
		</tr>
		
		<tr><th>이름</th><td><input type="text" name="name" value="강길동"></td></tr>
		
		<tr>
			<th>아이디</th>
			<td>
				<input type="text" name="id">
				<!-- 자바스크립트 onclick을 사용하여 맨 하단에 있는 스크립트 코드인 idCheck를 거치게 됩니다. -->
				<input type="button" value="중복확인" onclick="idCheck(this.form.id.value)">
			</td>
		</tr>
		<!-- 비밀번호는 password 타입으로 해주어 00으로 안보이게 가려줍니다. -->
		<tr><th>비밀번호</th><td><input type="password" name="pass" value="1234"></td></tr>
		<tr><th>비밀번호 확인</th><td><input type="password" name="rePass" value="1234"></td></tr>
		
		<tr>
			<th>생년(4자리)</th>
			<td>
				<select name="birth">
					<%
					/* 2001년부터 2010년까지 option 태그를 반복하고 i 값을 넣어줍니다.  */
						for(int i = 2001; i <= 2010; i++) { %>
						<option value="<%= i %>"><%= i %></option>
					<%	} %>
				</select>
			</td>
		</tr>
		
		<tr>
			<th>성별</th>
			<td>
			<!-- 기본 선택을 남자로 해줍니다. checked로 선택 가능합니다. -->
				<input type="radio" name="gender" value="M" checked="checked"> 남자
				<input type="radio" name="gender" value="F"> 여자
			</td>
		</tr>
		
		<tr>
			<th>직업</th>
			<td><input type="text" name="job" value="학생"></td>
		</tr>
		
		<tr>
			<th>도시</th>
			<td><input type="text" name="city" value="성남"></td>
		</tr>
		
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="가입"><input type="reset" value="재작성">
			</td>
		</tr>
	</table>
</form>

<script>
	/* function 으로 id를 체크하는 메서드를 생성해서 비교해줍니다. */
	function idCheck(id) {
		if(id == "") {
			alert("아이디를 입력해 주세요.");
			/* 아이디 입력창을 포커스 해주어 깜빡이게 되고 바로 입력할 수 있게 됩니다. */
			document.regForm.id.focus();	
		}else {
			/* url 뒤에 id값을 적어주어 GET 방식 동작을 시켜줍니다. */
			url = "idCheck.jsp?id=" + id;
			/* 윈도우.오픈으로 팝업창을 가로 400 세로 200 사이즈로 열리게 됩니다. */
			window.open(url, "post", "width=400, height=200");
		}
	}
</script>

<!-- 푸터 인클루드 해줍니다. -->
<jsp:include page="footer.jsp" />
</body>
</html>