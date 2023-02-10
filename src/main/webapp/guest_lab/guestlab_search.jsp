<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*,java.util.*" %> 
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "conn_oracle.jsp" %>
<HTML>
<HEAD><TITLE>게시판(검색모드)</TITLE>
</HEAD>
<BODY>
<P>
<P align=center>
 <FONT color=#0000ff face=굴림 size=3>
 <STRONG>자유 게시판(검색모드)</STRONG>
 </FONT>
</P> 
<FORM method=post name=search action="guestlab_search.jsp">
 <TABLE border=0 width=95%>
  <TR>
   <TD align=left width=30% valign=bottom>
    [<A href="guestlab_list.jsp">자유 게시판(일반모드)</A>]</TD>
   <TD align=right width=70% valign=bottom>
    <FONT size=2 face=굴림>
     <SELECT name=stype >
     <!-- stype 에 넘어오는 value 값에 따라서 다르게 출력
     	<OPTION value=1 >이름</OPTION>
	    <OPTION value=2 >제목</OPTION>
	    <OPTION value=3 >내용</OPTION>
	    <OPTION value=4 >이름+제목</OPTION>
	    <OPTION value=5 >이름+내용</OPTION>
	    <OPTION value=6 >제목+내용</OPTION>
	    <OPTION value=7 >이름+제목+내용</OPTION>
	 -->
<% 
      //jsp 코드 블락 : <option> 넘어오는 변수에 따라서 해당 내용을 출력
      String cond = null;	// SQL 쿼리를 담는 변수 : stype : 1
      int what = 1;	// stype 에 넘어오는 변수 int 형으로 변환해서 담는 변수
      		// 2 : 제목 , 3 : 내용, 4 : 이름 + 제목 
      String val = null; // sval 에서 넘어오는 검색어를 담는 변수
      what = Integer.parseInt(request.getParameter("stype"));	//옵션
      val = request.getParameter("sval");	//검색어
      
      if (what ==1) {
    	  out.println("<OPTION value=1 selected>이름</OPTION>");
    	  cond = "where ename like '%" + val + "%'";
      }else {
    	  out.println ("<OPTION value=1> 이름 </OPTION>");
      }
      
      if (what ==2) {
    	  out.println("<OPTION value=2 selected>핸드폰</OPTION>");
    	  cond = "where phone like '%" + val + "%'";
      }else {
    	  out.println ("<OPTION value=2> 핸드폰 </OPTION>");
      }
      
      if (what ==3) {
    	  out.println("<OPTION value=3 selected>성별</OPTION>");
    	  cond = "where gender like '%" + val + "%'";
      }else {
    	  out.println ("<OPTION value=3> 성별 </OPTION>");
      }
      
      if (what ==4) {
    	  out.println("<OPTION value=4 selected>이름+핸드폰</OPTION>");
    	  cond = "where ename like '%" + val + "%' or phone like '%" + val + "%'";
      }else {
    	  out.println ("<OPTION value=4> 이름+핸드폰 </OPTION>");
      }
      
      if (what ==5) {
    	  out.println("<OPTION value=5 selected>이름+성별</OPTION>");
    	  cond = "where ename like '%" + val + "%' or gender like '%" + val + "%'";
      }else {
    	  out.println ("<OPTION value=5> 이름+성별 </OPTION>");
      }
      
      if (what ==6) {
    	  out.println("<OPTION value=6 selected>이름+주소</OPTION>");
    	  cond = "where ename like '%" + val + "%' or addr like '%" + val + "%'";
      }else {
    	  out.println ("<OPTION value=6> 이름+주소 </OPTION>");
      }
      
      if (what ==7) {
    	  out.println("<OPTION value=7 selected>이름+핸드폰+성별</OPTION>");
    	  cond = "where ename like '%" + val + "%' or phone like '%" + val + "%'";
    	  cond += " or addr like '%" + val + "%'";
      }else {
    	  out.println ("<OPTION value=7> 이름+핸드폰+성별 </OPTION>");
      }

      
%>
     </SELECT>
	</FONT>
    <INPUT type=text name="sval" value="<%=request.getParameter("sval")%>">
    <INPUT type=submit value="검색">
   </TD>
  </TR>
 </TABLE>
</FORM>
<CENTER>
<TABLE border=0 width=600 cellpadding=4 cellspacing=0>
 <tr align="center"> 
  <td colspan="5" height="1" bgcolor="#1F4F8F"></td>
 </tr>
 <tr align="center" bgcolor="#87E8FF"> 
  <td width="42" bgcolor="#DFEDFF"><font size="2">번호</font></td>
  <td width="340" bgcolor="#DFEDFF"><font size="2">이름</font></td>
  <td width="84" bgcolor="#DFEDFF"><font size="2">핸드폰</font></td>
  <td width="78" bgcolor="#DFEDFF"><font size="2">성별</font></td>
  <td width="49" bgcolor="#DFEDFF"><font size="2">주소</font></td>
 </tr>
 <tr align="center"> 
  <td colspan="5" bgcolor="#1F4F8F" height="1"></td>
 </tr>
<%	
/* DB에서 값을 가져와서 Vector 컬렉션에 저장 후 페이징 처리 */

//Vector 변수 선언
	Vector idx = new Vector();		//name 컬럼의 모든 값을 저장하는 vector	
	Vector ename = new Vector();
	Vector phone = new Vector();
	Vector gender = new Vector();
	Vector addr = new Vector();
	
//페이징을 처리할 변수 선언


	int where = 1;		//현재 위치한 페이징 변수

	
	//where = Integer.parseInt(request.getParameter("where"));
	
	int totalgroup = 0;		//출력할 페이징의 총 그룹수
	int maxpages = 2;		//출력할 최대 페이지(row, 행, 레코드) 수
	int startpage = 1;		
	int endpage = startpage + maxpages -1;
	int wheregroup = 1;		//현재 위치한 페이징 그룹

	//go	//get 방식으로 해당 페이지 번호로 이동하도록 설정하는 변수
	//freeboard_list03.jsp?go=3
	//gogroup : get 방식으로 해당 페이지 그룹으로 이동하도록
		//freeboard_list03.jsp?go=3&gogroup=2
		
	//go 변수를 넘겨 받아서 wheregroup, startpage, endpage 정보를 알아낼 수 있다.
		//코드 블락
	if (request.getParameter("go") != null) { //freeboard_list03.jsp?go=
		where = Integer.parseInt(request.getParameter("go"));	// go 변수의 값을 where 변수에 할당
		wheregroup = (where - 1) / maxpages + 1;	//현재 내가 속한 그룹을 알 수 있다.
		startpage = (wheregroup -1) * maxpages + 1;
		endpage = startpage + maxpages -1;
	
	
	//gogroup 변수를 넘겨 받아서 startpage, endpage, where 의 정보를 알아낼 수 있다.
		//코드 블락
	} else if (request.getParameter("gogroup") != null){ //freeboard_list03.jsp?gogroup=
		wheregroup = Integer.parseInt(request.getParameter("gogroup")); //현재 내가 위치한 그룹
		startpage = (wheregroup -1) * maxpages + 1;
		where = startpage;                                                     
		endpage = startpage + maxpages -1;
	}

		
	//where : 현재 내가 위치한 페이지
	int nextgroup = wheregroup + 1;
	int priorgroup = wheregroup - 1;
	
	int nextpage = where + 1;	// 현재 내가 위치한 페이지의 다음
	int priorpage = where - 1;	// 현재 내가 위치한 이전
	int startrow = 0;			//하나의 page 에서 레코드 시작 번호
	int endrow = 0;				//하나의 page에서 레코드 마지막 번호
	int maxrow = 2; 			//한 페이지 내에 출력할 행의 갯수 (row, 행, 레코드 갯수)
	int totalrows = 0;			//DB에서 select 한 총 레코드 갯수
	int totalpages = 0;			//총 페이지 갯수
	
	// <<<페이징 처리할 변수 선언 끝 >>>

	//검색된 내용을 출력하는 블락
	String sql = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	//cond : option 에 선택자에 따라서 다른 쿼리가 변수로 들어옴.
	sql = "select * from guestlab " + cond;
	sql += " order by idx desc";
	
	
	out.println (sql);
	/*
	if (true) return;
	*/
	
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);	//
	
	if (!(rs.next())) {
		out.println("해당 내용이 DB 에 존재 하지 않습니다.");
	} else {	//검색된 내용이 존재 한다면 
		
		do {
		
			//정수 형으로 변환 필요 id, readcount step 컬럼은 DB에서 값으 가져와서 정수형으로 변환
			
			idx.addElement(rs.getString("idx"));
			ename.addElement(rs.getString("ename"));
			phone.addElement(rs.getString("phone"));
			gender.addElement(rs.getString("gender"));
			addr.addElement(rs.getString("addr"));
			

		} while(rs.next());
	}
	
	totalrows = ename.size();	//DB에서 가져온 총 레코드 갯수 
	totalpages = (totalrows-1) / maxrow + 1;	//전체 페이지 갯수 출력
	startrow = (where -1) * maxrow;			//해당 페이지에서 Vector의 방 번호 : 시작
	endrow = startrow + maxrow - 1;			//해당 페이지에서 Vector의 방 번호 : 끝
	
	totalgroup = (totalpages - 1) / maxpages + 1; 
	//전체 페이지 그룹, 하단에 출력할 페이지 갯수 (5개)의 그룹핑
	
	
	
	//endrow 가 totalrow 보다 크면 totalrows -로 처리해야함.
	if (endrow >= totalrows) {
		startrow = totalrows -1;
		endrow = totalrows -1;
	}
	if (endpage > totalpages) {
		endpage = totalpages;
	}
	
	// 페이징 변수 출력
	/*
	out.println ("<p/> 총 레코드 갯수 (totalrows : ) : " + totalrows + "<p/>" );
	out.println ("<p/> 전체 페이지 갯수 (totalpage : ) : " + totalpages + "<p/>" );
	out.println ("<p/> 시작 row 갯수 (startrow : ) : " + startrow + "<p/>" );
	out.println ("<p/> 마지막 row 갯수 (endrow : ) : " + endrow + "<p/>" );
	*/
	
	//if (true) return;	// 프로그램 멈춤
	
	//해당 페이지를 처리하면서 해당 페이지에 대한 내용을 출력 (rs의 값을 Vector에 저장했으므로 for)
	for (int j=startrow; j<=endrow; j++) {
%>
	<tr>
		<td> <%= idx.elementAt(j) %></td>
		<td> <a href="guestlab_read.jsp?id=<%= ename.elementAt(j) %>&page=<%=where%>">
				<%= ename.elementAt(j) %></td>
		<td> <%= phone.elementAt(j) %></td>
		<td> <%= gender.elementAt(j) %></td>
		<td> <%= addr.elementAt(j) %></td>
	</tr>

	<%
		}
	%>

</TABLE>
 
  <!-- 페이징 출력 부분 : [처음][이전] 1 2 3 4 5 [다음][마지막] -->
 
<%
	if (wheregroup > 1) { //현재 나의 그룹이 1 이상일 때 처음
		out.println("[<a href = 'guestlab_search.jsp?gogroup=1"+ "&stype=" + what + "&sval=" + val +"'> 처음 </a>]");
		out.println("[<a href = 'guestlab_search.jsp?gogroup=" + priorgroup + "&stype=" + what + "&sval=" + val +"'> 이전 </a>]");
	} else {	//현재 나의 페이지 그룹이 1일 떄는
		out.println ("[처음]");
		out.println ("[이전]");
	}

	//페이징 갯수를 출력 : 1 2 3 4 5 
	
	if (ename.size() != 0) { 	//name.size() : 총 레코드의 갯수가 0이 아니라면
		for (int jj=startpage; jj<=endpage; jj++){
			if (jj == where) {
				out.println ("[" +jj+ "]");
			} else { // jj가 현재 자신의 페이지 번호가 아니라면 링크를 걸어서 출력
				out.println("[<a href='guestlab_search.jsp?go=" + jj + "&stype=" + what + "&sval=" + val +"'>"+ jj + "</a>]" );
			}
		}
	}
	// [다음][마지막]
	if (wheregroup < totalgroup) { //링크를 처리
		out.println("[<a href='guestlab_search.jsp?gogroup=" + nextgroup + "&stype=" + what + "&sval=" + val +"'>다음</a>]");
		out.println("[<a href='guestlab_search.jsp?gogroup=" + totalgroup + "&stype=" + what + "&sval=" + val +"'>마지막]</a>");
	} else {	//마지막 페이지에 왔을 떄 링크를 해지
		out.println("[다음]");
		out.println("[마지막]");
	}
	out.println("전체 글수 : " + totalrows);	
	
%>

	


</BODY>
</HTML>