<%@page import="member.MemberVO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
	//한글이 깨지지 않게 인코딩 방식을 UTF-8로 잡아줍니다.
    request.setCharacterEncoding("UTF-8");

	//MemberDAO 인스턴스를 가져와서 사용 준비를 합니다.
	MemberDAO instance = MemberDAO.getInstance();

	//GET방식으로 넘어온 memno를 인트형으로 변환해서 가져옵니다.
	//memno와 birth 빼고 나머지는 그냥 가져옵니다. String으로.
	int memno = Integer.parseInt(request.getParameter("memno"));
    String pass = request.getParameter("pass");
    int birth = Integer.parseInt(request.getParameter("birth"));
    String gender = request.getParameter("gender");
    String job = request.getParameter("job");
    String city = request.getParameter("city");   
    
    
    //MemberVO의 새 인스턴스를 생성합니다.
    MemberVO vo = new MemberVO();
    
    //vo에 각각 형식에 맞게 setXXX로 넣어줍니다.
    //그러면 생성한 vo 인스턴스 속에 vo의 값이 다 차게 됩니다.
    vo.setPass(pass);
    vo.setBirth(birth);
    vo.setGender(gender);
    vo.setJob(job);
    vo.setCity(city);
    vo.setMemno(memno);
    
    //msg는 사용자에게 알릴 문자를 넣을 때 사용할 것입니다.
    String msg = null;
    //updateMember() 메서드에 새 인스턴스 생성했던 vo를 넣어주면 처리가 되어 멤버 정보 변경이 성공하면 그 메서드가 1을 리턴(반환) 해줍니다.
    //다만 1이 아닌 다른 값이 반환된다면 실패를 출력하게 됩니다.
    //if나 else나 각각 하나만 명령시키기 떄문에 간략하게 한줄 한줄씩 간단하게 코드 작성 하였습니다.
    if(instance.updateMember(vo) == 1) msg = "멤버 정보 변경 성공";
    else msg = "멤버 정보 변경 실패";
    
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레코드 수정</title>
</head>
<body>
<script>
   alert('<%= msg %>');            
   location.href = 'selectMember.jsp';
</script>
</body>
</html>