<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*, java.util.*, java.text.*" %>   
<% request.setCharacterEncoding("UTF-8"); %> 

<%@ include file = "conn_oracle.jsp" %>

<!-- 폼에서 넘겨주는 변수와 값을 받아서 저장 : request.getParameter("변수명");-->
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pass");
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String ci = request.getParameter("city");
	String pho = request.getParameter("phone");
	/* 
	out.println(id + "<p/>");
	out.println(pw + "<p/>");
	out.println(na + "<p/>");
	out.println(em + "<p/>");
	out.println(pho + "<p/>");
	if (true) return; 
	*/ 
	int idx = 1;
	
	String sql = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

try {
	
stmt = conn.createStatement();
sql = "select max(idx) from mbTbl";

rs = stmt.executeQuery(sql);

//테이블의 id컬럼의 값을 적용 : 최대값을 가져와서 + 1
if(!(rs.next())) {	 //테이블의 값이 존재하지 않는 경우
	idx = 1;
}else {			//테이블의 값이 존재하는 경우
	idx = rs.getInt(1) + 1;
}


sql= "insert into mbTbl(idx, id, pass, name, email, city, phone)";
sql = sql + "values ('"+idx+"', '"+id+"', '"+pw+"', '"+na+"', '"+em+"', '"+ci+"', '"+pho+"')";	

stmt.executeUpdate(sql);
		

} catch (Exception e) {
	out.println("DataBase Insert 중 문제가 발생되었습니다. <p/>");
	out.println("고객센터 : 02-1111-1111로 문의 바랍니다.");
	e.printStackTrace();
} finally {
	if( conn != null) conn.close();
	if (stmt != null) stmt.close();
	if (rs != null) rs.close();
}

%>

<jsp:forward page = "list01.jsp" />

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>