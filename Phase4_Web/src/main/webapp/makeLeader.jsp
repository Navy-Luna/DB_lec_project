<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%
/* 동아리원 직위 변경 jsp */
String id = (String)session.getAttribute("id");

//url로 전달된 동아리ID 받아오기
String snumber = request.getParameter("snum"); // 학생의 학번
String clubID = request.getParameter("clubID"); // 동아리 ID
	
String URL = (String)session.getAttribute("URL");
String USER_UNIVERSITY = (String)session.getAttribute("USER_UNIVERSITY");
String USER_PASSWD = (String)session.getAttribute("USER_PASSWD");
Connection conn = null;
Statement stmt = null;

try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
} catch (ClassNotFoundException e) {
    System.err.println("error: " + e.getMessage());
    System.exit(1);
}

// Make a Connection
try {
    conn = DriverManager.getConnection(URL, USER_UNIVERSITY, USER_PASSWD);
} catch (SQLException ex) {
    ex.printStackTrace();
    System.err.println("Cannot get a connection: " + ex.getLocalizedMessage());
    System.err.println("Cannot get a connection: " + ex.getMessage());
    System.exit(1);
}

stmt = conn.createStatement();
ResultSet rs;
String sql;
PreparedStatement ps;

sql = "select snumber from student where sidentifier='"+id+"'";
rs=stmt.executeQuery(sql);
String snum=null; // 부장의 학번을 조회한다.
while(rs.next()){
	snum = rs.getString(1);
}

// 학생 직위를 부장으로 변경
sql = "update member set mposition='부장' where cno=" + clubID + "and sno='" + snumber + "'";
stmt.executeUpdate(sql);
// 기존 동아리 부장을 일반 부원으로 변경
sql = "update member set mposition='회원' where cno=" + clubID + "and sno='" + snum + "'";
stmt.executeUpdate(sql);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>리더 임명</title>
</head>
<body>
<script>
	alert('직위가 정상적으로 변경되었습니다.');
</script>
<script type="text/javascript">
   location.href="Home.jsp";
</script>
</body>
</html>