<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<%@ include file = "conn_oracle.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	

	String sql = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String idx = request.getParameter("id");
	

	sql = "select * from mbTbl where idx = ?" ;
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,idx);
	rs = pstmt.executeQuery();		
									
	
	if (rs.next()){

%>

	<table width='600'>
		<tr>
			<td> 이름 : <%= rs.getString("name") %></td>
		</tr>
		<tr>
			<td> 아이디 : <%= rs.getString("id") %></td>
		</tr>
		<tr>
			<td> 주소 : <%= rs.getString("city") %></td>
		</tr>
		<tr>
			<td> 이메일 : <%= rs.getString("email") %></td>
		</tr>
		<tr>
			<td> 핸드폰 : <%= rs.getString("phone") %></td>
		</tr>
	</table> 

	<%
	 
		}else {
			out.println("해당 레코드는 존재하지 않습니다.");
		}
	 
	 %>

	<table width="300">
	<tr> 
		<td >
			<A href="list02.jsp?go=<%= request.getParameter("page") %>"><img src="images/list.jpg"></a></td>
		<td >
			<A href="freeboard_rwrite.jsp?idx=<%= request.getParameter("idx") %>&page=<%= request.getParameter("page") %>"> <img src="images/reply.jpg" ></A></td>
		<td>
			<A href="update02.jsp?idx=<%= idx %>&page=<%= request.getParameter("page") %>"><img src="images/edit.jpg"></A></td>
		<td >
			<A href="delete02.jsp?idx=<%= idx %>&page=<%= request.getParameter("page") %>">
			<img src="images/del.jpg" ></A></td>
	</tr>
  </table>


</body>
</html>