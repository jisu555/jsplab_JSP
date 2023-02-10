<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<SCRIPT language = "javascript"> 
	function check () {
		with(document.memdel){
			if ( password.value.length==0){
				alert ("비밀번호를 입력해 주세요!!"); 
				password.focus();
				return false; 
			}
			document.memdel.submit(); 	
		}	
	}
</SCRIPT>

<title>Insert title here</title>
</head>
<body>
	<form name="memdel" method = "post" action = "delete02_process.jsp"> 
	
	<input type="hidden" name = "idx" value = "<%= request.getParameter("idx") %>"> <!-- request에서 받아오는 거는 read에서 넘겨주는 거랑 동일하게! -->
   	<input type="hidden" name = "page" value = "<%= request.getParameter("page") %>">
   	
		<table width = "70%" cellspacing = "0" cellpadding="2"> 
   			<tr> <td colspan = "2" bgcolor = "#1f4f8f" height="1"> </td>
   			</tr>
   			<tr> <td colspan = "2" bgcolor = "#DFEDFF" height="20" class = "notice"> 
   				<b> 글 삭제 하기</b> </td>
   			</tr>
   			<tr>
   				<td colspan = "2" bgcolor = "#1F4F8F" height="1"> </td>
   			</tr>
   			<tr>
   				<td width ="124" height= "30" bgcolor= "#f4f4f4" align ="center" class= "input_style1">
   					비밀 번호 </td>
   				<td width = "494"> <input type="password" name = "password" class = "input_style1">
   				
   				</td>
   			</tr>
   			<tr> <td colspan = "2" height = "1" class= "button"> </td>
   			</tr>
   			<tr> <td colspan = "2" height = "1" bgcolor = "#1F4F8F"> </td>
   			</tr>
   			<tr> <td colspan ="2" height= "10"> 
   			</tr>
   			<tr> 
   				<td colspan = "2" align = "right"> 
   					<table width = "100%" border = "0" cellpadding = "4" cellspacing = "4"> 
   						<tr> <td width ="84%"> &nbsp; </td>
   							<td width = "8%"> 
   								<a href = "list02.jsp?go=<%= request.getParameter("page") %>" > 
   									<img src = "images/list.jpg" width="48" height="19" border="0">
   								</a>
   							</td>
   							<td width = "8%"> 
   								<a href = "#" onClick= "check(this.form);">
   									<img src = "images/del.jpg" width="46" height="19" border = "0"> 
   								</a>
   							</td>
   						</tr>
   					</table>
   				</td>
   			</tr>
   		
   		
   		</table>
	
	</form>

</body>
</html>

