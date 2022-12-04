<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%
//parameter 받기
request.setCharacterEncoding("utf-8"); 
String id = (String)session.getAttribute("id");
String tnum = request.getParameter("tnum");
String dcontent=request.getParameter("dcontent");
String rnum = request.getParameter("rno");

String URL = (String)session.getAttribute("URL");
String USER_UNIVERSITY = (String)session.getAttribute("USER_UNIVERSITY");
String USER_PASSWD = (String)session.getAttribute("USER_PASSWD");
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

if(tnum!=null && rnum!=null && dcontent!=null&&id !=null){

	sql = "select snumber from student where sidentifier='"+id+"'";
	rs=stmt.executeQuery(sql);
	String snum = "";
	while(rs.next()){
		snum = rs.getString(1);
	}
	
	sql = "select dnumber from reply order by dnumber desc";
	rs=stmt.executeQuery(sql);
	int nextnum = 1;
	if(rs.next()){
		nextnum = rs.getInt(1) + 1;
	}
	sql = "insert into reply values(?,?,to_char(sysdate,'yyyy-mm-dd'),?,?)";
	PreparedStatement ps = conn.prepareStatement(sql);
	
	int tno = Integer.parseInt(tnum);
	int sno = Integer.parseInt(snum);
	
	ps.setInt(1,nextnum);
	ps.setString(2, dcontent);
	ps.setInt(3,sno);
	ps.setInt(4,tno);
	ps.executeUpdate();
	System.out.println("성공!");
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Comment submit</title>
</head>
<body>
<%
if(id==null){
	stmt.close();
  	conn.close();
%>
	<script>
		alert('로그인 해주세요.');
		history.go(-1);
	</script>
<%}else{%>
</body>
</html>
<%
 	stmt.close();
  	conn.close();
  	response.sendRedirect("./review_content.jsp?rno="+rnum);
  	}
%>