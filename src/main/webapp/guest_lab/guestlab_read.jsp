<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<%@ include file = "conn_oracle.jsp" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>컬럼의 특정 레코드를 읽는 페이지 </title>
</head>
<body>

	<!-- JSP 코드 블락 -->
	<%
		//SQL 쿼리를 사용할 변수 선언 블락 
		String sql = null;
		Statement stmt = null;
		PreparedStatement pstmt = null;		//변수를 ? 로 처리함.
		ResultSet rs = null;
		
		//Get 방식으로 넘어오는 변수 값을 저장
		//String 형식으로 모두 넘어온다. Integer.PerseInt();
		int id = Integer.parseInt(request.getParameter("id"));
		int page2 = Integer.parseInt(request.getParameter("page"));
		
		
		
		/* Statement 객체를 사용해서 처리
		sql = "select * from freeboard where id = " +id ;
		
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		*/
		
		//PreparedStatemnet 객체를 사용해서 처리, 변수에 들어가는 값을 ?로 처리함.
				//매번 컴파일하지 않기 때문에 처리속도가 빠름
		sql = "select * from guestlab where idx = ?";
		pstmt = conn.prepareStatement(sql);		  //pstmt객체 생성 시 sql문을 넣는다.
		pstmt.setInt(1, id);	//1 첫 번째 물음표, 들어갈 변수
		rs = pstmt.executeQuery();		//select문인 경우 executeQuery()
										//insert, update, delete문인 경우 : executeUpdate()
		
		if (rs.next()){

	%>

	<table width='500' cellspacing='0' cellpadding='2' align='center'>
			   <tr>
			   <td height='22'>&nbsp;</td></tr>
			   <tr align='center'>
			   <td height='1' bgcolor='#1F4F8F'></td>
			   </tr>
			   <tr align='center' bgcolor='#DFEDFF'>
			   <td class='button' bgcolor='#DFEDFF'> 
			   <div align='left'><font size='4'> 이름 : <%= rs.getString("ename") %></font></div> </td>
			   </tr>
			   <tr align='center' bgcolor='#FFFFFF'>
			   <td align='center' bgcolor='#F4F4F4'>
			   <table width='100%' border='0' cellpadding='0' cellspacing='4' height='1'>
			   <tr bgcolor='#F4F4F4'>
			   <td width='13%' height='7'></td>
			   <td width='51%' height='7'>성별 : <%= rs.getString("gender") %></td>
			   <td width='25%' height='7'></td>
			   <td width='11%' height='7'></td>
			   </tr>
			   <tr bgcolor='#F4F4F4'>
			   <td width='13%'></td>
			   <td width='51%'>핸드폰 : <%= rs.getString("phone") %> </td>
			 
			   <td width='11%'></td>
			   </tr>
			   </table>
			   </td>
			   </tr>
			   <tr align='center'>
			   <td bgcolor='#1F4F8F' height='1'></td>
			   </tr>
			   <tr align='center'>
			   <td style='padding:10 0 0 0'>
			   <div align='left'><br>
			   <font size='3' color='#333333'> <pre><%= rs.getString("addr") %> </pre> </div>
			   <br>
			   </td>
			   </tr>
			   <tr align='center'>
			   <td class='button' height='1'></td>
			   </tr>
			   <tr align='center'>
			   <td bgcolor='#1F4F8F' height='1'></td>
			   </tr>
	 </table>
	 
	 <%
	 
		}else {
			out.println("해당 레코드는 존재하지 않습니다.");
		}
	 
	 %>
			  
		
   <table width="600" border="0" cellpadding="0" cellspacing="5">
	<tr> 
		<td align="right" width="450"><A href="guestlab_list.jsp?go=<%= request.getParameter("page") %>"><img src="images/list.jpg" border=0></a></td>
		<td width="70" align="right"><A href="guestlab_rwrite.jsp?id=<%= request.getParameter("id") %>&page=<%= request.getParameter("page") %>"> <img src="images/reply.jpg" border=0></A></td>
		<td width="70" align="right"><A href="guestlab_upd.jsp?id=<%= id %>&page=<%= request.getParameter("page") %>"><img src="images/edit.jpg" border=0></A></td>
		<td width="70" align="right"><A href="guestlab_del.jsp?id=<%= id %>&page=<%= request.getParameter("page") %>"><img src="images/del.jpg"  border=0></A></td>
	</tr>
  </table>

</BODY>
</HTML>

<%

		//읽기 페이지 마지막에서 글 조회수를 늘려준다.
		// sql = "update guestlab set readcount= readcount +1 where id =" + id ;

		//Statement 객체의 insert/update/delete 쿼리인 경우 executeUpdate(sql) 를 실행
		//Statement 객체의 select 쿼리인 경우 executeQuery(sql) 를 실행, ResultSet 객체로 리턴
		stmt = conn.createStatement();
		//stmt.executeUpdate(sql);

%>








