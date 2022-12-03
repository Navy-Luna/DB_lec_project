<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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
	request.setCharacterEncoding("euc-kr");
	String name = request.getParameter("user_name");
	String ID= request.getParameter("user_id");
	String PW = request.getParameter("user_pass");
	String PW_repeat= request.getParameter("user_pass_repeat");
	if(!(PW.equals(PW_repeat))){
		System.out.println("비밀번호가 일치하지 않습니다.");
		response.sendRedirect("login_page.jsp?error=login-failed");
	}
	String snumber = request.getParameter("user_number");
	String college =  request.getParameter("college");
	String department = request.getParameter("department");
	String email = request.getParameter("user_email");
	String phone = request.getParameter("user_phone");
	String sex = request.getParameter("user_sex");
	StringBuffer sb = new StringBuffer();
	sb.append("INSERT INTO STUDENT VALUES(");
	sb.append("'"+snumber+"',");
	sb.append("'"+college+"',");
	sb.append("'"+email+"',");
	sb.append("'"+PW+"',");
	sb.append("'"+phone+"',");
	sb.append("'"+name+"',");
	sb.append("'"+sex+"',");
	sb.append("'"+department+"',");
	sb.append("'"+ID+"')");
	System.out.println("append종료: "+sb.toString());
	stmt = conn.createStatement();
	System.out.println("createStatement종료: ");
	sql = sb.toString();
	int res = stmt.executeUpdate(sql);
	System.out.println("sql종료: ");
	
	
	%>
	<%
	response.sendRedirect("Home.jsp?snumber=" + snumber);
	%>

</body>
</html>