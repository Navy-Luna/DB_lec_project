<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%
//로그인 관련
session.setAttribute("id", "knu2022000008");
// session.removeAttribute("id");
String id = (String)session.getAttribute("id");

String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
String USER_UNIVERSITY = "KNU_CLUB";
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
PreparedStatement ps;


// 아이디로 학번 받아오기
sql = "select snumber from student where sidentifier = \'" + id + "\'";
rs = stmt.executeQuery(sql);

rs.next();
String snum = rs.getString(1);


// 가입한 동아리 이름, clubID 받아오기
String[] club_name = new String[10];
int[] club_num = new int[10];
int rowcount = 0; // 동아리 개수 

sql = "SELECT CNAME, CNUMBER FROM (STUDENT JOIN MEMBER ON SNUMBER = SNO) JOIN CLUB ON CNUMBER = CNO WHERE SNUMBER = \'" + snum + "\'";
rs = stmt.executeQuery(sql);

while(rs.next())
{
	String clubName = rs.getString(1);
	int clubNum = rs.getInt(2); 
	
	club_name[rowcount] = clubName; // 동아리 이름 저장
	club_num[rowcount] = clubNum; // club ID 저장
	
	rowcount += 1;
}


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

	<title>KNUClubs &mdash; 내 동아리 보기</title>
	
	<style>
	.col-lg-6 .text-black-50{
	font-size: 25px
	}
	</style>
	
</head>
<body>

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
					<a href="index.html" class="logo m-0 float-start">KNUClubs</a>

					<ul class="js-clone-nav d-none d-lg-inline-block text-start site-menu float-end">
						<li><a href="index.html">Home</a></li>						
						<li><a href="#">Club Search</a></li>
						<%if(id==null){%>
							<li><a href="#">Sign In</a></li>
						<%}else{ %>	
						<li class="has-children">
							<a href="#"><%out.println(id); %></a>
							<ul class="dropdown">
								<li><a href="#">Sign Out</a></li>
								<li><a href="#">My Clubs</a></li>
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
					<h1 class="heading" data-aos="fade-up">내 동아리 보기</h1>

					<nav aria-label="breadcrumb" data-aos="fade-up" data-aos-delay="200">
						<ol class="breadcrumb text-center justify-content-center">
							<li class="breadcrumb-item "><a href="index.html">Home</a></li> <!-수정필요!-->
							<li class="breadcrumb-item active text-white-50" aria-current="page">Club Search</li><!-수정필요!-->
						</ol>
					</nav>
				</div>
			</div>
		</div>
	</div>


	<div class="section">
		<div class="container">
			<div class="row text-left mb-5">
				<div class="col-12">
					<h2 class="font-weight-bold heading text-primary mb-4">내 동아리 목록:</h2>
				</div>
				<div style="color:black; font-weight:400; font-size:2.0em">
					<%
						if(rowcount == 0)
							out.println("가입한 동아리가 없습니다.");
						else
						{
							for(int i=0; i<rowcount; i++)
								out.println("<p>▷ <a style=\"color:black\" href=\"detailed_information_mem.jsp?clubID="+ club_num[i] + "\">" + club_name[i] + "</a></p>");
						}
					%>
				</div>
				
			</div>
		</div>
	</div>



	<div class="section sec-testimonials bg-light">
		<div class="container">
			<div class="row text-left mb-5">
				<div class="col-12">
					<h2 class="font-weight-bold heading text-primary mb-4">지원한 동아리:</h2>
				</div>
				<div style="color:black; font-weight:400; font-size:1.5em">
					<%
						int rowcount2 = 0;
					
						String query2 = "select c.cname, a.apass from apply a, student s, club c where a.sno = s.snumber and c.cnumber = a.cno and snumber = \'" + snum + "\'";
						rs = stmt.executeQuery(query2);

						while(rs.next())
						{
							String clubNames = rs.getString(1);
							String pass = rs.getString(2);
							if(pass == null)
								pass = "검토 중";
						
							out.println("<p> > 동아리 이름: " + clubNames + " || 합/불 여부: " + pass + "</p>");
							rowcount2 += 1;
						}
						
						// ResultSet의 행의 개수
						if (rowcount2 == 0)
							out.println("<p>지원한 동아리가 없습니다.</p>");	
					%>
				</div>
				
			</div>
		</div>
	</div>

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
