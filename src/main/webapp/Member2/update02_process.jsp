<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>
<%@ include file = "conn_oracle.jsp" %>
<% request.setCharacterEncoding("UTF-8"); %>    

<%

	int idx = Integer.parseInt(request.getParameter("idx"));
	String p = request.getParameter("page");
	
	String id = request.getParameter("id");
	String pw = request.getParameter("password");
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String ci = request.getParameter("city");
	String pho = request.getParameter("phone");

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

[ <a href = "list02.jsp?go=<%= p %>" > 게시판 목록으로 </a>]

<%

	String sql = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	sql = "select * from mbTbl where idx = ?" ;
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, idx);
	rs = pstmt.executeQuery();	
	
	try{	//DB에 쿼리를 보내는 블락 : DB에 오류가 발생 시 프로그램이 종료되지 않도록 처리
		

		if (!(rs.next())) {	//rs의 값이 비어있을 때
			out.println ("해당 값이 존재하지 않습니다.");
		}else{	//rs의 값이 존재할 때
			String pwd = rs.getString("pass");
			//rs의 password 컬럼의 값을 가져와서 폼에서 넘겨받은 password(pw)와 맞으면 삭제
					//pwd : DB에서 가져온 password
					//pw : 사용자가 폼에서 넘긴 password
					
					
					/*
					out.println("<p/>" + pwd + "<p/>");
					out.println(pw + "<p/>");
					out.println(pwd.equals(pw));	// 두 값이 같으면 true, 다르면 false
					
					if (true) return;
					*/
				
			if (pwd.equals(pw)){		//DB의 password와 폼의 password가 같을 때
				
				sql = "update mbTbl set name=?, email=?,";
				sql += "city=?, phone=? where idx =?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, na);
				pstmt.setString(2, em);
				pstmt.setString(3, ci);
				pstmt.setString(4, pho);
				pstmt.setInt(5, idx);
				
				pstmt.executeUpdate();
				
				//위 쿼리가 성공적으로 작동되면 아래 코드가 실행
				out.println ("<p/> 내용이 잘 수정되었습니다.");
				
			}else {	//다를 때
				out.println ("패스워드가 다릅니다");
			}
		}
		
		
		
		}catch (Exception e){
			out.println("DB 저장 시 오류가 발생되었습니다.");
			e.printStackTrace();	  //디버깅
		}finally {
			if (conn != null) {conn.close();}
			if (pstmt != null) {pstmt.close();}
			if (conn != null) {conn.close();}
		}

%>

</body>
</html>