<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*,java.util.*" %> 
<%@ include file = "conn_oracle.jsp" %> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UT-8">
<title>DB의 내용을 가져와서 출력 하기 </title>
<SCRIPT language="javascript">
	function check(){
		with(document.memsearch){
			if(sval.value.length == 0){
				alert("검색어를 입력해 주세요!");
				sval.focus();
				return false;
			}
			document.memsearch.submit();
		}
	}
	function rimgchg(p1,p2) {
		  if (p2==1) 
		   document.images[p1].src= "images/open.gif";
		  else
		   document.images[p1].src= "images/arrow.gif";
		  }

		 function imgchg(p1,p2) {
		  if (p2==1) 
		   document.images[p1].src= "images/open.gif";
		  else
		   document.images[p1].src= "images/close.gif";
		 }
</SCRIPT>	
</head>
<body>

<table border=0 width = "800" >
	<tr align="center"> 
   		<td colspan="7" height="1" bgcolor="#1F4F8F" ></td>
  	</tr> 
	<tr align="center" bgcolor="#87E8FF">
		<th width="100"> 번호 </th>   
		<th width="100"> 아이디 </th> 
		<th width="150"> 비밀번호 </th> 
		<th width="100"> 이름 </th> 
		<th width="300">email</th> 
		<th width="100"> city</th>
		<th width="300">phone</th>  
	</tr>
	<tr align="center"> 
   		<td colspan="7" bgcolor="#1F4F8F" height="1"></td>
  	</tr>
	
	<%
	
	Vector keyidx = new Vector();
	Vector id = new Vector();
	Vector pass = new Vector();
	Vector name = new Vector();
	Vector email = new Vector();
	Vector city = new Vector();
	Vector phone = new Vector();
	
	// << 페이징을 처리할 변수 선언 시작>>
	int where = 1;
	
	int totalgroup = 0 ;	
	int maxpages = 5;		
	int startpage = 1;
	int endpage = startpage + maxpages - 1 ;
	int wheregroup = 1;
	
	if (request.getParameter("go")!=null){	
		where = Integer.parseInt(request.getParameter("go"));   
		wheregroup = (where -1) / maxpages  + 1;  
		startpage = (wheregroup - 1)* maxpages +1 ;
		endpage = startpage + maxpages - 1 ;
	
	
	//gogroup 변수를 넘겨 받아서 startpage, endpage, where 의 정보를 알아낼 수 있다.
		//코드 블락	
	}else if (request.getParameter("gogroup") !=null) {  
		wheregroup = Integer.parseInt(request.getParameter("gogroup"));  
		startpage = (wheregroup -1) * maxpages +1 ;
		where = startpage;
		endpage = startpage + maxpages -1;
	}
		
	int nextgroup = wheregroup +1 ;
	int priorgroup = wheregroup -1 ;
	
	int nextpage = where + 1 ;	//where : 현재 내가 위치한 페이지
	int priorgage = where - 1;
	int startrow = 0 ;			//하나의 page에서 레코드 시작 번호
	int endrow = 0;				//하나의 page에서 레코드 마지막 번호
	int maxrow = 5;				//한페이지 내에 출력할 행의 갯수(row(행,레코드) 갯수)
	int totalrows = 0;			//DB에서 select한 총 레코드 갯수
	int totalpages = 0;			//총 페이지 갯수 
	
	//<<페이징 처리할 변수 선언 끝>>
	
	int idx = 0;
	String em = null;
	
		String sql = null;
		ResultSet rs = null;       //ResultSet 객체는 DB의 테이블을 Select 해서 나온 결과 레코드셋을 담는 객체 
		Statement stmt = null;     //SQL 쿼리를 담아서 실행하는 객체 
		
		sql = "select * from mbTbl order by to_number (idx) desc";
		
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		if (!(rs.next())){	//rs의 값이 존재하지 않을 때 
			out.println("게시판에 올라온 글이 없습니다.");
		}else {		// rs의 값이 존재할 때(게시판의 글이 존재할 때)
			do {
			
			//정수형으로 변환 필요 : id, readcount
				keyidx.addElement(new Integer(rs.getString("idx")));
				id.addElement(rs.getString("id"));
				pass.addElement(rs.getString("pass"));
				name.addElement(rs.getString("name"));
				email.addElement(rs.getString("email"));
				city.addElement(rs.getString("city"));
				phone.addElement(rs.getString("phone"));
			
			}while (rs.next());	
		}
		
		totalrows = name.size();	//DB에서 가져온 총 레코드 갯수
		totalpages = (totalrows-1)/maxrow + 1;	//전체 페이지 갯수 출력
		startrow = (where -1) * maxrow ;		//해당 페이지에서 Vector의 방 번호 : 시작
		endrow = startrow + maxrow -1;			//해당 페이지에서 Vector의 방 번호 : 마지막
		
		totalgroup = (totalpages -1) /maxpages + 1 ;  
			//전체 페이지 그룹, 하단에 출력할 페이지 갯수(5개)의 그룹핑
		
		//endrow가 totalrows보다 크면 totalrows -1로 처리해야함.
		if(endrow >= totalrows) {
			endrow = totalrows -1;
		}
		if(endpage > totalpages){
			endpage = totalpages;
		}
		
		for (int j = startrow; j <= endrow ; j++){
			

			%>

			<tr align="center">
				<td> <%= keyidx.elementAt(j) %></td>
				<td> <a href="read01.jsp?id=<%= keyidx.elementAt(j) %>&page=<%=where%>">
						<%= id.elementAt(j) %></a></td>
				<td> <%= pass.elementAt(j) %></td>
				<td> <%= name.elementAt(j) %></td>
				<td> <%= email.elementAt(j) %></td>
				<td> <%= city.elementAt(j) %></td>
				<td> <%= phone.elementAt(j) %></td>
			</tr>

			<%
			
			}

			%>
		 </TABLE>
		
		<!-- 페이징 출력 부분 : [처음][이전] 1 2 3 4 5 [다음][마지막] -->
 
 <%
 
 	 //	 [처음][이전]
	 if(wheregroup > 1 ){	//현재 나의 그룹이 1 이상일 때 처음
	 	out.println("[<a href='list01.jsp?gogroup=1'>처음</a>]");
	 	out.println("[<a href='list01.jsp?gogroup=" + priorgroup + "'>이전</a>]");

	 }else{			//현재 나의 페이지 그룹이 1일때는 
		out.println("[처음]");
		out.println("[이전]");
	 }
 
 	//페이징 갯수를 출력 : 1 2 3 4 5
 	
 	if (name.size() !=0 ) {		// name.size() : 총 레코드의 갯수가 0이 아니라면
 		for (int jj = startpage; jj <=endpage ;jj ++){
 			if(jj == where) {		//jj가 자신의 페이지 번호라면 링크없이 출력
 				out.println ("["+jj+"]");
 			}else {		//jj가 현재 자신의 페이지 번호가 아니라면 링크를 걸어서 출력
 				out.println("[<a href=list01.jsp?go="+jj+ ">" +jj+ "</a>]");
 			}
 		}
 	}
 	
 	// [다음][마지막]
 	if (wheregroup < totalgroup) {	//링크를 처리
 		out.println("[<a href=list01.jsp?gogroup=" + nextgroup + ">다음</a>]");
 		out.println("[<a href=list01.jsp?gogroup=" + totalgroup + ">마지막</a>]");
 	}else {	//마지막 페이지에 왔을 때 링크를 해지
 		out.println("[다음]");
 		out.println("[마지막]");
 	}
 
 	out.println("전체 글 수 : " + totalrows);
 %>
 
 <FORM method="post" name="memsearch" action="search01.jsp">
<TABLE border=0 width=600 cellpadding=0 cellspacing=0>
 <TR>
  <TD align=right width="241"> 
   <SELECT name=stype >
    <OPTION value=1 >이름</OPTION>
    <OPTION value=2 >제목</OPTION>
    <OPTION value=3 >내용</OPTION>
    <OPTION value=4 >이름+제목</OPTION>
    <OPTION value=5 >이름+내용</OPTION>
    <OPTION value=6 >제목+내용</OPTION>
    <OPTION value=7 >이름+제목+내용</OPTION>
   </SELECT>
  </TD>
  <TD width="127" align="center">
   <INPUT type=text size="17" name="sval" >
  </TD>
  <TD width="115">&nbsp;<a href="#" onClick="check();"><img src="images/serach.gif" border="0" align='absmiddle'></A></TD>
  <TD align=right valign=bottom width="117"><A href="Insert01.jsp"><img src="images/write.gif" border="0"></TD>
 </TR>
</TABLE>
</FORM>

</body>
</html>