<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Oracle DB Connection</title>
</head>
<body>

	<%
		//변수 초기화		//JSP 블락내에서 주석
		Connection conn = null;
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		Boolean connect = false;		//접속이 잘 되었는지 확인하는 변수

		try {
			Class.forName(driver);  //오라클 드라이버를 로드함
			conn = DriverManager.getConnection (url, "c##HR", "1234");
			
			connect = true;
			conn.close();
		}catch (Exception e){
			connect = false;
			e.printStackTrace();
		}
		
		// 조건을 사용해서 잘 연결되면 잘 연결되었다고 확인 메세지 출력
		if (connect==true) {
			out.println ("오라클 DB에 잘 연결되었습니다.");
		}else {
			out.println ("오라클 DB에 연결 실패했습니다.");
		}
			
	%>
	
</body>
</html>