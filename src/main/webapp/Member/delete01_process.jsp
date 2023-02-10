<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ include file = "conn_oracle.jsp" %>    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

[ <a href= "list01.jsp?go=<%= request.getParameter("page") %>">
	게시판으로 이동 </a>]	

<%

String sql = null;
Statement stmt = null;		
ResultSet rs = null;	

int idx = Integer.parseInt(request.getParameter("idx"));  //delete01에서 name값이랑 동일!
int page1 = Integer.parseInt(request.getParameter("page"));
String pw = request.getParameter("password");	//폼에서 넘겨진 password

try{	//DB에 쿼리를 보내는 블락 : DB에 오류가 발생 시 프로그램이 종료되지 않도록 처리

	sql = "select * from mbTbl where idx=" +idx;
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	
	

	if (!(rs.next())) {	//rs의 값이 비어있을 때
		out.println ("해당 값이 존재하지 않습니다.");
	}else{	//rs의 값이 존재할 때
		//rs의 password 컬럼의 값을 가져와서 폼에서 넘겨받은 password(pw)와 맞으면 삭제
				//pwd : DB에서 가져온 password
				//pw : 사용자가 폼에서 넘긴 password
				
			String pwd = rs.getString("pass"); //DB값이니까 컬럼명이랑 같게!
		
			
		if (pwd.equals(pw)){		//DB의 password와 폼의 password가 같을 때
			//delete 쿼리를 적용
			sql = "delete mbTbl where idx="+idx;
			
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
			
			//위 쿼리가 성공적으로 작동되면 아래 코드가 실행
			out.println ("잘 삭제되었습니다.");
			
		}else {	//다를 때
			out.println ("패스워드가 다릅니다");
		}
	}
	
	
	
	}catch (Exception e){
		out.println("DB 오류로 인해서 삭제 실패했습니다.");
		e.printStackTrace();	  //디버깅
	}finally {
		if (conn != null) {conn.close();}
		if (stmt != null) {stmt.close();}
		if (conn != null) {conn.close();}
	}







%>	

</body>
</html>