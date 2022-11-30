<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%
//parameter 받기
String id = (String)session.getAttribute("id");
String clubID = request.getParameter("clubid");
String acontent=request.getParameter("acontent");

String URL = "jdbc:oracle:thin:@112.157.15.34:1521:xe";
String USER_UNIVERSITY = "dbproject";
String USER_PASSWD = "comp322";
Connection conn = null;
Statement stmt = null;



try {
    // Load a JDBC Driver for oracle DBMS
    Class.forName("oracle.jdbc.driver.OracleDriver");
    System.out.println("Driver Loading: Success!");
} catch (ClassNotFoundException e) {
    System.err.println("error: " + e.getMessage());
    System.exit(1);
}

// Make a Connection
try {
    conn = DriverManager.getConnection(URL, USER_UNIVERSITY, USER_PASSWD);
    System.out.println("Oracle Connected.");
} catch (SQLException ex) {
    ex.printStackTrace();
    System.err.println("Cannot get a connection: " + ex.getLocalizedMessage());
    System.err.println("Cannot get a connection: " + ex.getMessage());
    System.exit(1);
}

stmt = conn.createStatement();
ResultSet rs;
String sql;


sql = "select snumber from student where sidentifier='"+id+"'";
rs=stmt.executeQuery(sql);
String snum = "";
while(rs.next()){
	snum = rs.getString(1);
}

sql = "select anumber from apply order by anumber desc";
rs=stmt.executeQuery(sql);
int nextnum = 1;
if(rs.next()){
	nextnum = rs.getInt(1) + 1;
}
System.out.println(clubID);
sql = "insert into apply values(?,?,?,?,?)";
PreparedStatement ps = conn.prepareStatement(sql);

int cid = Integer.parseInt(clubID);

ps.setInt(1, nextnum);
ps.setString(2, snum);
ps.setInt(3, cid);
ps.setString(4, acontent);
ps.setString(5, null);
ps.executeUpdate();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Apply submit</title>
</head>
<body>
<script>
	alert('제출 성공!');
	history.go(-2);
</script>
</body>
</html>