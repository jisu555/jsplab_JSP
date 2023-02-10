<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>
<%@ include file = "conn_oracle.jsp" %>

<%
	String sql = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	int idx = Integer.parseInt(request.getParameter("idx"));
	String p = request.getParameter("page");
	
	try {	
		sql = "select * from mbTbl where idx=" +idx;
		stmt = conn.createStatement();		 
		rs = stmt.executeQuery(sql);
		
		//rs의 값이 잘 가져왔을 때 
		
		if (! (rs.next())){
			//값이 없을 때
			out.println("해당 내용이 DataBase에 존재하지 않습니다.");
		}else {
			//값이 있을 때 

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update 를 통한 데이터 수정 </title>

<script>
	function check(){
		with (document.filemember){
			if(password.value.length==0){
				alert ("패스워드를 입력해 주세요");
				password.focus();
				return false;
			}
			if(name.value.length==0){
				alert ("이름을 입력해 주세요");
				name.focus();
				return false;
			}
			if(email.value.length==0){
				alert ("e-mail을 입력해 주세요");
				email.focus();
				return false;
			}
			if(city.value.length==0){
				alert ("사는곳을 입력해 주세요");
				city.focus();
				return false;
			}
			if(phone.value.length==0){
				alert ("핸드폰을 입력해 주세요");
				phone.focus();
				return false;
			}
			document.filemember.submit();
		}
	}
</script>

</head>
<body>

	<form name="filemember" method = "post" action = "update01_process.jsp"> 
		<input type="hidden" name = "idx" value = "<%= request.getParameter("idx") %>"> <!-- request에서 받아오는 거는 read에서 넘겨주는 거랑 동일하게! -->
   		<input type="hidden" name = "page" value = "<%= request.getParameter("page") %>">
   		
   		<table width="300px" cellspacing = "0" cellpadding = "2">
			<tr>
				<td> 패스워드 : </td>
				<td> <input type = "text" name = "password" value="<%= rs.getString("pass") %>" class = "input_style1"> </td>
			</tr>
			<tr>
				<td> 이름 : </td>
				<td> <input type = "text" name = "name" value="<%= rs.getString("name") %>" class = "input_style1"> </td>
			</tr>
			<tr>
				<td> 이메일 : </td>
				<td> <input type = "text" name = "email" value="<%= rs.getString("email") %>" class = "input_style1"> </td>
			</tr>
			<tr>
				<td> 사는곳 : </td>
				<td> <input type = "text" name = "city" value="<%= rs.getString("city") %>" class = "input_style1"> </td>
			</tr>
			<tr>
				<td> 핸드폰 : </td>
				<td> <input type = "text" name = "phone" value="<%= rs.getString("phone") %>" class = "input_style1"> </td>
			</tr>
			<tr> 
   <td colspan="2" height="1" class='button'></td>
  </tr>
  <tr> 
   <td colspan="2" height="1" bgcolor="#1F4F8F"></td>
  </tr>
  <tr> 
   <td colspan="2" height="10"></td>
  </tr>
  <tr> 
   <td colspan="2" align="right"> 
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
     <tr> 
      <td width="64%">&nbsp;</td>
      <td width="12%"><a href="#" onClick="check();"><img src="images/ok.gif" border="0"></a></td>
      <td width="12%"><a href="#" onClick="history.go(-1)"><img src="images/cancle.gif"  border="0"></td>
      <td width="12%"><A href="list01.jsp?go=<%= request.getParameter("page") %>"> <img src="images/list.jpg" border=0></a></td>
     </tr>
			</table>
			
	</form>
	
<%

		}	//if문 종료

	}catch (Exception e) {
		
		// e.printStackTrace(); //디버깅
	}finally {
		if(conn != null) conn.close();
		if(stmt != null) stmt.close();
		if(rs != null) rs.close();
	}

%>	
	
	
	

</body>
</html>