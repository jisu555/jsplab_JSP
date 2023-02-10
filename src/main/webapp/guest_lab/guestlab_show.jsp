<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<!-- 필요한 라이브러리 등록 -->    
<%@ page import = "java.sql.*, java.util.*" %>    
    
<!-- DB의 값을 select해서 select한 값을 출력  -->    
<%@ include file="conn_oracle.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방명록의 내용을 DB에서 가져와서 출력하는 페이지 </title>
<link href="filegb.css" rel="stylesheet" type="text/css">
<style>
	div {
		/*
		border : 1px solid red; 
		height : 300ox;
		*/
		width : 600px;
		margin : 0 auto;
	}
	
	table, tr, td {
		padding : 5px ;
		border-collapse : collapse;
	}
	
</style>
</head>
<body>

<!-- DataBase에서 Select 한 결과를 담는 변수 선언 : 컬렉션 : 방이 자동으로 늘어난다. -->
<%
	
	//사용할 변수 선언
	String sql = null;			//SQL 쿼리를 담은 변수
	Statement stmt = null;		//DBMS에 sql 쿼리를 보내는 객체. Connection객체로 생성
	ResultSet rs = null;		//select한 결과 레코드 셋을 담은 객체
	
	//sql 쿼리를 변수에 할당 
	sql = "select * from guestlab order by idx desc";
	
	//Connection (conn) 객체를 사용해서 Statement객체를 생성
	stmt = conn.createStatement();
	
	//stmt 객체를 실행
	// rs : select 한 결과 레코드를 담은 객체
	rs = stmt.executeQuery(sql);
	
	//rs에 담긴 값을 루프를 돌리면서 출력
		//rs.next() : 커서의 위치를 다음 레코드로 이동
			//레코드가 존재하면 rs.next 가 true
			//레코드의 값이 존재하지 않으면 false
			
	if(rs.next()){	   //레코드가 존재할 때 루프를 돌리면서 출력
		do {
			
		
%>

<!-- rs에 담긴 내용을 출력할 테이블 생성
	rs.getString("컬럼명")

-->
<div>
	<table width="300px" border = "1px">
		<tr>
			<td colspan="2" align = "center">
				<h3> <%= rs.getString("ename") %></h3>
			</td>
			
		</tr>
		<tr>
			<td> 번호 : <%= rs.getString("idx") %> </td>
			<td> 성별 : <%= rs.getString("gender") %> </td>
		</tr>
		<tr>
			<td colspan = "2"> 핸드폰 번호 : <%= rs.getString("phone") %></td>
		</tr>
		<tr>
			<td colspan = "2"> 주소 : <%= rs.getString("addr") %> </td>
		</tr>
		
	</table>
		<p/><p/>
</div>	
	
<%
		} while (rs.next());
		
	}else {		//레코드가 존재하지 않을 때  
		out.println("방명록에 데이터가 존재하지 않습니다. ");
	}
		
	%>		
		
<div>
	<a href = "guestlab_write.html"> <img src="images/write.gif" width="100px"> </a>
</div>		
		


</body>
</html>