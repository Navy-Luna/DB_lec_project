<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%
/* 리뷰 삭제 jsp */
//로그인 관련
String id = (String)session.getAttribute("id");
//url로 전달된 동아리ID 받아오기
String rno = request.getParameter("rno");

	
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

sql = "select snumber from student where sidentifier='"+id+"'";
rs=stmt.executeQuery(sql);
String snum=null; // 사용자의 학번을 조회한다.
while(rs.next()){
	snum = rs.getString(1);
}


//리뷰 삭제
sql = "delete from review where rnumber = " + rno;
stmt.executeUpdate(sql);
out.println("리뷰 삭제가 완료되었습니다.");


%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>리뷰삭제</title>
</head>
<body>
</body>
</html>