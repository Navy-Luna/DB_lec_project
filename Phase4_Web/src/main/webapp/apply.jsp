<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%
//로그인 관련
request.setCharacterEncoding("utf-8"); 
String id = (String)session.getAttribute("id");
String clubID = request.getParameter("clubID");

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
String snum = "";
if(id!=null){
	sql = "select snumber from student where sidentifier='"+id+"'";
	rs=stmt.executeQuery(sql);
	while(rs.next()){
		snum = rs.getString(1);
	}
}

sql = "select cname from club where cnumber = "+clubID;
rs = stmt.executeQuery(sql);
rs.next();
String cname = rs.getString(1);

sql = "select cform from club where cnumber=" + clubID;
rs = stmt.executeQuery(sql);
rs.next();
String form = rs.getString(1);

%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="author" content="Untree.co">
	<link rel="shortcut icon" href="favicon.gif">

	<meta name="description" content="" />
	<meta name="keywords" content="bootstrap, bootstrap5" />
	
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">


	<link rel="stylesheet" href="fonts/icomoon/style.css">
	<link rel="stylesheet" href="fonts/flaticon/font/flaticon.css">

	<link rel="stylesheet" href="css/tiny-slider.css">
	<link rel="stylesheet" href="css/aos.css">
	<link rel="stylesheet" href="css/style.css">

	<title><%out.println(cname);%> 지원하기</title>
	
	<style>
	.col-lg-6 .text-black-50{
	font-size: 25px
	}
	</style>
	
</head>
<body>
<%
sql = "select * from apply where sno = '" + snum + "' and cno = " + clubID;
rs = stmt.executeQuery(sql);

if (rs.next()) {%>
	<script>
		alert('이미 지원하셨습니다.');
		history.go(-1);
	</script>
<%}
sql = "select * from member where sno = '" + snum + "'and cno = " + clubID;
rs = stmt.executeQuery(sql);
if (rs.next()) {%>
	<script>
		alert('이미 회원입니다.');
		history.go(-1);
	</script>
<%}
if(id==null){%>
	<script>
		alert('로그인 해주세요.');
		history.go(-1);
	</script>
<%}%>

	<div class="site-mobile-menu site-navbar-target">
		<div class="site-mobile-menu-header">
			<div class="site-mobile-menu-close">
				<span class="icofont-close js-menu-toggle"></span>
			</div>
		</div>
		<div class="site-mobile-menu-body"></div>
	</div>

	<nav class="site-nav">
		<div class="container">
			<div class="menu-bg-wrap">
				<div class="site-navigation">
					<a href="Home.jsp" class="logo m-0 float-start">KNUClubs</a>

					<ul class="js-clone-nav d-none d-lg-inline-block text-start site-menu float-end">
						<li><a href="Home.jsp">Club Search</a></li>						
						<!-- <li><a href="club_serach.jsp">Club Search</a></li> -->
						<%if(id==null){%>
							<li><a href="login_page.jsp">Sign In</a></li>
						<%}else{ %>	
						<li class="has-children">
							<a href="#"><%out.println(id); %></a>
							<ul class="dropdown">
								<li><a href="#">Sign Out</a></li>
								<li><a href="seeMyclub.jsp">My Clubs</a></li>
								<li><a href="#">Settings</a></li>
							</ul>
						<%} %>
					</ul>

					<a href="#" class="burger light me-auto float-end mt-1 site-menu-toggle js-menu-toggle d-inline-block d-lg-none" data-toggle="collapse" data-target="#main-navbar">
						<span></span>
					</a>

				</div>
			</div>
		</div>
	</nav>

	<div class="hero page-inner overlay" style="background-image: url('images/hero_bg_3.jpg');">

		<div class="container">
			<div class="row justify-content-center align-items-center">
				<div class="col-lg-9 text-center mt-5">
					<h1 class="heading" data-aos="fade-up">Apply</h1>

					<nav aria-label="breadcrumb" data-aos="fade-up" data-aos-delay="200">
						<ol class="breadcrumb text-center justify-content-center">
							<li class="breadcrumb-item "><a href="Home.jsp">Club Search</a></li> <!-수정필요!-->
							<li class="breadcrumb-item "><a href="#"><%out.println(cname); %></a></li> <!-수정필요!-->
							<li class="breadcrumb-item active text-white-50" aria-current="page">Apply</li><!-수정필요!-->
						</ol>
					</nav>
				</div>
			</div>
		</div>
	</div>



	<div class="section">
		<div class="container">
			<div class="row">
				<div class="col-lg-4 mb-5 mb-lg-0" data-aos="fade-up" data-aos-delay="100">
					<div class="contact-info">

						<div class="address mt-2">
							<h4 class="mb-2">양식에 맞게 작성해 주세요.</h4>
							<p><%out.println(form); %><br></p>
						</div>

					</div>
				</div> 
				<div class="col-lg-8" data-aos="fade-up" data-aos-delay="200">
					<form action="apply_submit.jsp?clubid=<%out.println(clubID);%>" method="post">
						<div class="row">
						<div class="col-12 mb-3">
							
						</div>
							<div class="col-12 mb-3">
								<textarea name="acontent" cols="30" rows="5" class="form-control" placeholder="150자 이내로 작성해 주세요."></textarea>
							</div>
							<div class="col-12">
								<input type="submit" value="Send" class="btn btn-primary">
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div> <!-- /.untree_co-section -->



	<div class="site-footer">
		<div class="container">

			<div class="row">
			<div class="col-lg-4"></div>
				<div class="col-lg-4">
					<div class="widget">
						<h3>About us</h3>
						<address>COMP322 데이타베이스004 Team경상도사나이</address>
						<ul class="list-unstyled links">
							<li style="white-space:nowrap;">김동근 <a href="mailto:info@mydomain.com">tyt0815@icloud.com</a></li>
							<li style="white-space:nowrap;">윤주영 <a href="mailto:info@mydomain.com">email@mydomain.com</a></li>
							<li style="white-space:nowrap;">김도선 <a href="mailto:info@mydomain.com">email@mydomain.com</a></li>
						</ul>
					</div> <!-- /.widget -->
				</div> <!-- /.col-lg-4 -->
				
			</div> <!-- /.row -->

			<div class="row mt-5">
				<div class="col-12 text-center">
					<!-- 
              **==========
              NOTE: 
              Please don't remove this copyright link unless you buy the license here https://untree.co/license/  
              **==========
            -->

            <p>Copyright &copy;<script>document.write(new Date().getFullYear());</script>. All Rights Reserved. &mdash; Designed with love by <a href="https://untree.co">Untree.co</a> <!-- License information: https://untree.co/license/ -->
            </p>

          </div>
        </div>
      </div> <!-- /.container -->
    </div> <!-- /.site-footer -->


    <!-- Preloader -->
    <div id="overlayer"></div>
    <div class="loader">
    	<div class="spinner-border" role="status">
    		<span class="visually-hidden">Loading...</span>
    	</div>
    </div>


    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/tiny-slider.js"></script>
    <script src="js/aos.js"></script>
    <script src="js/navbar.js"></script>
    <script src="js/counter.js"></script>
    <script src="js/custom.js"></script>
  </body>
  </html>
  <%
 	stmt.close();
  	conn.close();
  %>