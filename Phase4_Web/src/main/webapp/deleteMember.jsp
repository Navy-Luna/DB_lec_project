<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%
/* 동아리 멤버 삭제용 jsp */
//url로 전달된 동아리ID 받아오기
String snum = request.getParameter("snum");
String clubID = request.getParameter("clubID");
	
String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
String USER_UNIVERSITY = "KNU_CLUB";
String USER_PASSWD = "comp322";
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

sql = "delete from member where sno = '" + snum + "' and cno = " + clubID;
stmt.executeUpdate(sql);



%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>동아리원 삭제</title>
</head>
<body>
<script>
	alert('동아리원이 삭제되었습니다.');
	history.go(-1);
</script>
</body>
</html>