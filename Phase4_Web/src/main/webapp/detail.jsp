<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%
//로그인 관련
session.setAttribute("id", "knu2020000029");
session.removeAttribute("id");
String id = (String)session.getAttribute("id");
String clubID = "15";

String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
String USER_UNIVERSITY = "club";
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

sql = "select snumber from student where sidentifier='"+id+"'";
rs=stmt.executeQuery(sql);
while(rs.next()){
	String snum = rs.getString(1);
}


sql = "select * from club where cnumber=" + clubID;
rs = stmt.executeQuery(sql);
rs.next();
Date cdate = rs.getDate(2);
String cname = rs.getString(3);
String ccollege = rs.getString(4);
String ctype = rs.getString(5);

// 평점
sql = "select avg(rrating), count(*) from review where cno=" + clubID;
rs = stmt.executeQuery(sql);
rs.next();
Float rt = rs.getFloat(1);
String rating = String.format("%.1f", rt);
if (rs.getInt(2) == 0)
    rating = "평가없음";

// 부장 이름
sql = "select s.sname from student s, member m where m.cno = " + clubID
        + " and m.sno = s.snumber and m.mposition = '부장'";
rs = stmt.executeQuery(sql);
rs.next();
String boss = rs.getString(1);

// 성비
sql = "select ssex, count(*) from student, member where cno = " + clubID
        + " and snumber = sno group by ssex";

rs = stmt.executeQuery(sql);
float mnum = 0;
float fnum = 0;
float mrate = 0;
float frate = 0;
while (rs.next()) {
    String sex = rs.getString(1);
    if (sex.compareTo("M") == 0)
        mnum = rs.getInt(2);
    else
        fnum = rs.getInt(2);
}
if (mnum + fnum != 0) {
    mrate = mnum / (mnum + fnum) * 100;
    frate = fnum / (mnum + fnum) * 100;
}

// 누적 지원자 수
sql = "select count(*) from student where exists(select * from apply where snumber = sno and cno = ?)";
ps = conn.prepareStatement(sql);
ps.setInt(1, Integer.parseInt(clubID));
rs = ps.executeQuery();
rs.next();
int anum = rs.getInt(1);
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

	<title>KNUClubs &mdash; <%out.println(cname);%></title>
	
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
					<h1 class="heading" data-aos="fade-up"><%out.println(cname);%></h1>

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
					<h2 class="font-weight-bold heading text-primary mb-4"><%out.println(cname+"동아리"); %></h2>
				</div>
				<div class="col-lg-6">
					<p class="text-black-50"><%out.println("구분: "+ccollege + " 동아리" + "(" + ctype + ")"); %></p>
					<p class="text-black-50"><%out.println("개설 날짜: " + cdate); %></p>
					<p class="text-black-50"><%out.println("평점: " + rating); %></p>
					<p class="text-black-50"><%out.println("부장: " + boss); %></p>
					<p class="text-black-50"><%out.println(
                            "남녀 성비:" + "    (남)" + String.format("%.1f", mrate) + "   (여)"
                                    + String.format("%.1f", frate)); %></p>
					<p class="text-black-50"><%out.println("누적 지원자 수: " + anum); %></p>
				</div>
				<div class="col-lg-6">
					<img src="images/knu_logo.jpg" alt="Image" class="img-fluid">
				</div>
				<%if(id==null){%>
					<p class="text-black-50"><a  class="btn btn-primary" href="#">지원하기</a></p>
				<%}else{ %>
					<p class="text-black-50"><a  class="btn btn-primary" href="apply.jsp">지원하기</a></p>
				<%} %>
				
			</div>

		</div>
	</div>



	<div class="section sec-testimonials bg-light">
		<div class="container">
			<div class="row mb-5 align-items-center">
				<div class="col-md-6">
					<h2 class="font-weight-bold heading text-primary mb-4 mb-md-0">Reviews</h2>
				</div>
				<div class="col-md-6 text-md-end">
					<div id="testimonial-nav">
						<span class="prev" data-controls="prev">Prev</span>

						<span class="next" data-controls="next">Next</span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-lg-4"></div>
			</div>
			<div class="testimonial-slider-wrap">
				<div class="testimonial-slider">
				<%
				int rnumber;
				String rtitle;
				String sname;
				String sdepartment;
				try {
	                // 리뷰 목록
	                sql = "select rnumber, rtitle, sname, sdepartment from review, student where sno=snumber and cno = " + clubID+"order by rdate desc";
	                rs = stmt.executeQuery(sql);
	                while (rs.next()) {
	                   rnumber=rs.getInt(1);
	                   rtitle=rs.getString(2);
	                   sname=rs.getString(3);
	                   sdepartment = rs.getString(4);
	                   out.println("<div class=\"item\"><div class=\"testimonial\"><img src=\"images/knu_ch.jpeg\" alt=\"Image\" class=\"img-fluid rounded-circle w-25 mb-4\">");
	                   out.println("<h3 class=\"h5 text-primary\">"+ sname +"</h3>");
	                   out.println("<p class=\"text-black-50\">"+ sdepartment +"</p>");
	                   out.println("<p>"+rtitle+"</p>");
	                   out.println("<a href=\"review_content.jsp?rno="+rnumber+"\"><img src=\"images/comment.png\" alt=\"cmt\"></a>");
	                   out.println("</div></div>");
	                }
				}catch (SQLException ex2) {
	                    System.out.println("sql error = " + ex2.getMessage());
	             
	                }
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
