<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%
//로그인 관련
String id = (String)session.getAttribute("id");
//url로 전달된 동아리ID 받아오기
String clubID = request.getParameter("clubID");

	
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
String snum=null; // 사용자의 학번을 조회한다.
while(rs.next()){
	snum = rs.getString(1);
}


// 동아리 탈퇴
sql = "DELETE FROM MEMBER WHERE SNO = '"+ snum +"' and CNO = " + clubID;
stmt.executeUpdate(sql);


%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>탈퇴완료</title>
</head>
<body>
<script>
	alert('동아리 탈퇴 완료되었습니다.');
	history.go(-1);
</script>
</body>
</html>