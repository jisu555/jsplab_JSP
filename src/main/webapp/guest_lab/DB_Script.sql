
/* Oracle XE DataBase에서 Table 생성 */

Create Table guestlab (

	idx varchar2(200) primary key,
	ename varchar2(200),
	phone varchar2(200),
	gender varchar2(200),
	addr varchar2(200)
	);
	
	
/*
   1. WEB-INF\lib 라이브러리 넣어야함
   2. Oracle DB 연결 설정
   3. 폼 페이지를 생성해야함. guestlab_write.html
   4. form에서 action 을 처리하는 페이지 생성. guestlab_save.jsp
   			폼에서 넣는 값을 받아서 DB에 저장하는 페이지
 */
	
/*
 	guestlab_show.jsp	 //rs에서 값을 가져와서 출력
 	guestlab_show02.jsp	 	//rs의 값을 Vector에 저장 후 출력
 	guestlab_show03.jsp 	//rs의 값을 ArrayList에 저장 후 출력
*/	
	
	
/*
 	guestlab_list.jsp	<== guestlab_read.jsp, guestlab_del.jsp, guestlab_upd.jsp 
 	
 		================================================
 		번호    메일          폰             성별    주소 
 		================================================
 		30    a@aaa.com   010-1111-1111   남자    서울
 		29    a@aaa.com   010-1111-1111   남자    서울
 		28    a@aaa.com   010-1111-1111   남자    서울
 		27    a@aaa.com   010-1111-1111   남자    서울
 		26    a@aaa.com   010-1111-1111   남자    서울
 		
 		================================================
 		[처음][이전] 1 2 3 4 5 [다음][마지막]
 		
*/
	
	
	
	
	
	
	