<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
	String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
	String USER_UNIVERSITY = "club";
	String USER_PASSWD = "comp322";
	Connection conn = null;
	Statement stmt = null;
	String sql = "";
	ResultSet rs = null;

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
	StringBuffer sb = new StringBuffer();
	String id = request.getParameter("user");
	String password = request.getParameter("pass");
	stmt = conn.createStatement();
	sb.append("select COUNT(*) \r\n" + "from student s\r\n" + "where s.sidentifier=" + "'" + id + "'" + "and SPASSWORD="
			+ "'" + password + "'");
	sql = sb.toString();
	rs = stmt.executeQuery(sql);
	System.out.println("" + sql);
	rs.next();
	if (rs.getInt(1) > 0) {
		System.out.println("\n로그인에 성공했습니다. home으로 이동합니다.");
		// 학번 추출 sql
		sb = new StringBuffer();
		sb.append("select snumber\r\n" + "from student\r\n" + "where sidentifier='");
		sb.append(id + "'");
		sql = sb.toString();

		rs = stmt.executeQuery(sql);
		rs.next();
		String snumber = rs.getString(1);
		//home이동
		response.sendRedirect("Home.jsp?snumber=" + snumber);
		//홈 이동
		//home(snumber);
	} else {
		System.out.println("아이디가 존재하지않거나 비밀번호가 틀렸습니다. 추천아이디를 사용해주세요.");
		response.sendRedirect("login_page.jsp?error=login-failed");
	}
	%>

</body>
</html>