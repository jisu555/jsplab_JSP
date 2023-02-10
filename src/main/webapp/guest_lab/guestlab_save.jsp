<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 사용할 클래스를 해당 패키지에서 import -->    
<%@ page import = "java.sql.*, java.util.*" %>

<!-- 클라이언트에서 유니코드를 UTF-8로 처리해야함 (MVC Model 1) -->
<!-- JSP에서 내장 객체 : Import없이 사용 가능한 객체 
	 request 객체 : 클라이언트에서 넘겨주는 정보를 서버에서 받아서 처리,
	 response 객체 : 서버에서 클라이언트에게 정보를 처리하는 객체 -->
	 
<% request.setCharacterEncoding("UTF-8"); %>


<!-- DB를 접속하는 파일을 include해서 사용 -->
<%@ include file = "conn_oracle.jsp" %>

<!-- 폼에서 넘겨주는 변수와 값을 받아서 저장 : request.getParameter("변수명");-->
<%
	String idx = request.getParameter("idx");
	String en = request.getParameter("ename");
	String pho = request.getParameter("phone");
	String gen = request.getParameter("gender");
	String addr = request.getParameter("addr");

%>

<!-- 폼에서 넘긴 변수를 출력 후 주석 처리 :  -->  
<%
	//out.println("idx 변수에 담긴 값 : " + idx + "<p/>");
	//out.println("en 변수에 담긴 값 : " + en + "<p/>");
	//out.println("pho 변수에 담긴 값 : " + pho + "<p/>");
	//out.println("gen 변수에 담긴 값 : " + gen + "<p/>");
	//out.println("addr 변수에 담긴 값 : " + addr + "<p/>");
%>
<%= "idx 변수에 담긴 값 : " + idx + "<p/>" %>

<!-- 변수에 넘어오는 값을 SQL 쿼리에 담아서 DB에 저장 -->
<%


String sql = null;		//sql <== SQL 쿼리를 담는 변수
Statement stmt = null;	//SQL 쿼리를 DB에 적용하는 객체

//Connection 객체의 conn.createStatement() 메소드를 써서 stmt 객체에 할당.
stmt = conn.createStatement();

try {
sql = "insert into guestlab (idx, ename, phone, gender, addr) ";
sql = sql + "values ('"+idx+"', '"+en+"', '"+pho+"', '"+gen+"', '"+addr+"')";

// out.println(sql); 

// int cnt = 0 ; //sql 쿼리가 잘 처리되었는지 확인 변수

//Statement 객체가 sql 쿼리를 실행해서 DB에 저장
//cnt = stmt.executeUpdate(sql);		//Statement 객체의 excuteUpdate(sql) : insert, update, delete
stmt.executeUpdate(sql);
//stmt.executeQuery(sql);		//Statement 객체의 excuteQuery(sql) : select 
									//Recordset 객체로 리턴을 시켜줌 : select한 결과를 담은 객체

 // Statement 객체나 PreparedStatement 객체를 사용해서 Insert/Update/Delete
 		// 저장할 경우 commit 는 자동으로 처리됨
 //
//out.println(cnt);

// if( cnt > 0 ) {
//	 out.println ("DB에 잘 insert 되었습니다.");
// }else {
//	 out.println ("DB에 저장을 실패했습니다.");
// }

} catch (Exception e) {
	out.println("DataBase Insert 중 문제가 발생되었습니다. <p/>");
	out.println("고객센터 : 02-1111-1111로 문의 바랍니다.");
	e.printStackTrace();
} finally {
	//사용한 객체를 close()   // Connection, Statement객체 메모리에서 제거
	if(conn != null){
		conn.close();
	}
	if(stmt != null){
		stmt.close();
	}
}

//dbgb_save.jsp : 폼에서 받은 값을 DB에 저장이 완료되면 출력 페이지로 이동

%>

<jsp:forward page = "guestlab_list.jsp" />
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기의 폼의 변수의 값을 받아서 DB에 저장 후 보기 페이지로 이동</title>
</head>
<body>

</body>
</html>