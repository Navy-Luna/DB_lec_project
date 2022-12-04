<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.Date,java.text.SimpleDateFormat" %>
<%
/* 합/불 결정용 jsp */
//url로 전달된 동아리ID 받아오기
String snum = request.getParameter("snum");
String clubID = request.getParameter("clubID");
int selection = Integer.parseInt(request.getParameter("sel"));
	
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

if(selection == 0) // 지원서 불합격
{
	sql = "update apply set apass=\'N\' where cno=" + clubID + "and sno='" + snum + "'";
	stmt.executeUpdate(sql);
	out.println("<script> alert('해당 학생을 불합격시켰습니다.');</script>");
	out.println("<script> history.go(-1);</script>");
}
else
{
	sql = "update apply set apass=\'Y\' where cno=" + clubID + "and sno='" + snum + "'";
	stmt.executeUpdate(sql);
	out.println("<script> alert('해당 학생을 합격시켰습니다.');</script>");
	out.println("<script> history.go(-1);</script>");
	
	sql = "select * from member";
	
	// 현재 날짜로 가입날짜가 들어감
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	String now_dt = format.format(new Date());
	String date = "TO_DATE(\'"+now_dt+"\', \'yyyy-mm-dd\')";
	
	try {
		ps = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
		rs = ps.executeQuery();
		rs.last();
		int memnum = rs.getInt(1);
		
		sql = "INSERT INTO MEMBER VALUES (" + (memnum+1) + ", " + clubID + ", \'" + snum + "\', "+ "\'회원\'" + ", "+ date + ")";
		stmt.executeUpdate(sql);


	} catch (SQLException e) {
		e.printStackTrace();
		System.exit(-1);
	}
}



%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>합/불</title>
</head>
<body>
</body>
</html>