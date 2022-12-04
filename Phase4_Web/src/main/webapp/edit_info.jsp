<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*,java.util.Date,java.text.SimpleDateFormat" %>
<%
/* 합/불 결정용 jsp */
//url로 전달된 동아리ID 받아오기
String ssn = request.getParameter("ssn");
String name = request.getParameter("clubname");
String clubID = request.getParameter("clubId");
String college = request.getParameter("clubcollege");
String type = request.getParameter("clubtype");
String forms = request.getParameter("clubform");
	
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


if(ssn!=null && ssn.length() == 10) // 동아리원 추가: ssn이 10글자일때 수정 작업 진행
{
	
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
		
		sql = "INSERT INTO MEMBER VALUES (" + (memnum+1) + ", " + clubID + ", \'" + ssn + "\', "+ "\'회원\'" + ", "+ date + ")";
		stmt.executeUpdate(sql);
		out.println("동아리원이 추가되었습니다. <br><br>");

	} catch (SQLException e) {
		e.printStackTrace();
		System.exit(-1);
	}
}

/* 동아리 정보 수정 */
if(name!=null&&name.length()>0) // 동아리명을 바꿀 경우
{
	sql = "update club set cname = '"+ name + "' where cnumber = " + clubID;
	stmt.executeUpdate(sql);
	out.println("동아리명이 변경되었습니다. <br>");
}
if((college!=null)&&((college.equals("중앙") || college.equals("단대") || college.equals("학과")))&&college.length()>0) // ccollege 변경
{
	try
	{
		sql = "update club set ccollege = '"+ college + "' where cnumber = " + clubID;
		stmt.executeUpdate(sql);
		out.println("동아리 종류가 변경되었습니다. <br>");
	}catch(SQLException e)
	{
		out.println("동아리 종류는 변경되지 않았습니다. <br>");
	}
}
if(type!=null && type.length()>0)
{
	try
	{
		sql = "update club set ctype = '"+ type + "' where cnumber = " + clubID;
		stmt.executeUpdate(sql);	
		out.println("동아리 타입이 변경되었습니다. <br>");
	}catch(SQLException e)
	{
		out.println("동아리 타입은 변경되지 않았습니다. <br>");
	}
}
if(forms!=null && forms.length()>0)
{
	
	System.out.println(forms.length());
	try
	{
		sql = "update club set cform = '"+ forms + "' where cnumber = " + clubID;
		stmt.executeUpdate(sql);
		out.println("동아리 지원양식이 변경되었습니다. <br>");
	}catch(SQLException e)
	{
		out.println("동아리 지원양식은 변경되지 않았습니다. <br>");
	}
	
}

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>동아리 정보 변경</title>
</head>
<body>
</body>
</html>