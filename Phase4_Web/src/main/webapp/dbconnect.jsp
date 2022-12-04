<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 	String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
	String USER_UNIVERSITY = "club";
	String USER_PASSWD = "comp322";
	session.setAttribute("URL",URL);
	session.setAttribute("USER_UNIVERSITY",USER_UNIVERSITY);
	session.setAttribute("USER_PASSWD",USER_PASSWD);
	response.sendRedirect("./Home.jsp");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
</body>
</html>
