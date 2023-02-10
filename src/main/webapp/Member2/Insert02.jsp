<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>
	function check(){
		with (document.filemember){
			if(id.value.length==0){
				alert ("아이디를 입력해 주세요");
				id.focus();
				return false;
			}
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

	<form name="filemember" method = "post" action = "insert02_process.jsp">
		<table width="300px" cellspacing = "0" cellpadding = "2">
			<tr>
				<td> 아이디 : </td>
				<td> <input type = "text" name = "id" class = "input_style1"></td>
			</tr>
			<tr>
				<td> 패스워드 : </td>
				<td> <input type = "text" name = "password" class = "input_style1"> </td>
			</tr>
			<tr>
				<td> 이름 : </td>
				<td> <input type = "text" name = "name" class = "input_style1"> </td>
			</tr>
			<tr>
				<td> 이메일 : </td>
				<td> <input type = "text" name = "email" class = "input_style1"> </td>
			</tr>
			<tr>
				<td> 사는곳 : </td>
				<td> <input type = "text" name = "city" class = "input_style1"> </td>
			</tr>
			<tr>
				<td> 핸드폰 : </td>
				<td> <input type = "text" name = "phone" class = "input_style1"> </td>
			</tr>
			</table>
	
			<p> <a href="#" onclick= "check(this.form)"><input type = "submit" values = "전송"></a> 
	
	</form>

</body>
</html>

