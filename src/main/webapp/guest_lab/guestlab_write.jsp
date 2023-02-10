<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="filegb.css" rel="stylesheet" type="text/css">
<style>
	div {
		width : 800px;
		margin : 0 auto;	
	}
	#write {
		font-size : 30px;
	}
</style>
<script>
	function check() {
		with (document.filelabwrite) {
			if (idx.value.length==0){
				alert ("번호를 입력해 주세요");
				idx.focus();
				return false;
			}
			if (ename.value.length==0) {
				alert("이름을 입력해 주세요");
				ename.focus();
				return false;
			}
			if (phone.value.length==0){
				alert ("핸드폰번호를 입력해 주세요");
				phone.focus();
				return false;
			}
			if (gender.value.length ==0) {
				alert ("성별을 입력해 주세요");
				gender.focus();
				return false;
			}
			if (addr.value.length ==0) {
				alert ("주소를 입력해 주세요");
				addr.focus();
				return false;
			}
			document.filelabwrite.submit();
		}
	}

</script>
</head>
<body>

<div>
	<form name= "filelabwrite" method = "post" action="guestlab_save.jsp">
		<table width="330px" cellspacing = "0" cellpadding = "2">
			<tr>
				<td colspan="2" bgcolor="#1F4F8F" height  = "1"></td>
			</tr>
			<tr>
				<td colspan="2" bgcolor="white" height  = "1"><span id="write">회원가입</span></td>
			</tr>
			<tr>
				<td> 번호 : </td>
				<td> <input type = "text" name = "idx" class = "input_style1"></td>
			</tr>
			<tr>
				<td> 이름 : </td>
				<td> <input type = "text" name = "ename" class = "input_style1"> </td>
			</tr>
			<tr>
				<td> 핸드폰 : </td>
				<td> <input type = "text" name = "phone" class = "input_style1"> </td>
			</tr>
			<tr>
				<td> 성별 : </td>
				<td> <input type = "text" name = "gender" class = "input_style1"> </td>
			</tr>
			<tr>
				<td> 주소 : </td>
				<td> <input type = "text" name = "addr" class = "input_style1"> </td>
			</tr>			
			<tr>
				<td colspan = "2" height ="30px"> &nbsp;</td>
			</tr>
			<tr>
				<td colspan = "2"> <!-- 취소 / 확인 / 글쓰기 이미지를 처리 -->
					<table width = "100%" border = "0" cellspacing = "0" cellpadding="0">
						<tr>
							<td width="28%"> &nbsp; </td>
							<td width="51%"> &nbsp; </td>
							<td width="12%">
								<a href = "dbgb_show.jsp">
								<img src ="images/cancle.gif" width="46px" height="20px"></a>
							</td>
							<td width="9%">
								<a href= "#" onclick= "check(this.form)">
								<img src ="images/ok.gif" width="46px" height="20px"></a>
							</td>
						</tr>
					</table>
				</td>
			</tr>		
		</table>	
	
	</form>
</div>

</body>
</html>