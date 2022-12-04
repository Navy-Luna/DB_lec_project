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
	String URL = (String)session.getAttribute("URL");
	String USER_UNIVERSITY = (String)session.getAttribute("USER_UNIVERSITY");
	String USER_PASSWD = (String)session.getAttribute("USER_PASSWD");
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
	// Statement object
			try {
				stmt = conn.createStatement();
			} catch (SQLException e2) {
				e2.printStackTrace();
			}
	request.setCharacterEncoding("euc-kr");
	String name = request.getParameter("user_name");
	String ID= (String)request.getParameter("user_id");
	System.out.println(ID);
	StringBuffer sb = new StringBuffer();
	sb.append("SELECT COUNT(*)\r\n"
			+ "from student s\r\n"
			+ "where s.sidentifier='"+ID+"'");
	sql =sb.toString();
	rs = stmt.executeQuery(sql);
	System.out.println(sql);
	rs.next();
	if(rs.getInt(1)!=0){
		out.println("<script>alert('중복되는 아이디가 있습니다!'); window.history.back();</script>");
		return;
	}
	else {
		System.out.println("중복되는 아이디가 있습니다. 다시 입력해주세요.");
	}
	String PW = (String)request.getParameter("user_pass");
	String PW_repeat= (String)request.getParameter("user_pass_repeat");
	if(!(PW.equals(PW_repeat))){
		System.out.println("비밀번호가 일치하지 않습니다.");
		out.println("<script>alert('비밀번호가 일치하지 않습니다!'); window.history.back();</script>");
		return;
	}
	String snumber = request.getParameter("user_number");
	String college =  request.getParameter("college");
	String department = request.getParameter("department");
	String email = request.getParameter("user_email");
	String phone = request.getParameter("user_phone");
	 sb = new StringBuffer();
		sb.append("SELECT COUNT(*)\r\n"
				+ "from student s\r\n"
				+ "where s.sphone='"+phone+"'");
		sql =sb.toString();
		rs = stmt.executeQuery(sql);
		System.out.println(sql);
		rs.next();
		if(rs.getInt(1)!=0){
			out.println("<script>alert('중복되는 휴대폰 번호가 있습니다!'); window.history.back();</script>");
			return;
		}
		else {
		}
	String sex = request.getParameter("user_sex");
	sb = new StringBuffer();
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
	session.setAttribute("id",ID);
	response.sendRedirect("Home.jsp");
	%>

</body>
</html>