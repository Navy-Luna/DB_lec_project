<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%
//로그인 관련
String id = (String)session.getAttribute("id");
String clubID = "15";

//url로 전달된 동아리ID 받아오기
String urlID = request.getParameter("clubID");
if (urlID != null) // 동아리 보기에서 바로 넘어온 경우
	clubID = urlID; // clubID 갱신

	
	String URL = (String)session.getAttribute("URL");
	String USER_UNIVERSITY = (String)session.getAttribute("USER_UNIVERSITY");
	String USER_PASSWD = (String)session.getAttribute("USER_PASSWD");
Connection conn = null;
Statement stmt = null;

try {
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
String snum=null; // 사용자의 학번을 조회한다.
while(rs.next()){
	snum = rs.getString(1);
}

// 동아리명, 동아리 종류, 동아리 타입
sql = "select * from club where cnumber=" + clubID;
rs = stmt.executeQuery(sql);
rs.next();
String cname = rs.getString(3);
String ccollege = rs.getString(4);
String ctype = rs.getString(5);

/* 지원서 출력을 위한 작업 */
// 지원서가 NULL인 애들을 불러옴
String[] applyName = new String[15];
String[] applySnum = new String[15];
String[] applyContent = new String[15];
sql = "SELECT * from student WHERE student.snumber IN (SELECT apply.sno FROM apply WHERE apass IS NULL AND CNO = " + clubID + ")";
rs = stmt.executeQuery(sql);

int applyCount = 0;
while(rs.next())
{
	applyName[applyCount] = rs.getString(6);
	applySnum[applyCount] = rs.getString(1);
	applyCount += 1;
}

if(applyCount > 0) // 한명이라도 지원자 있는경우
{
	sql = "select sname, sno, acontent, apass from apply join student on snumber=sno where sno = ? and cno = " + clubID;
	ps = conn.prepareStatement(sql);
	
	for(int i=0; i<applyCount; i++)
	{
		ps.setString(1, applySnum[i]);
		rs = ps.executeQuery();
		rs.next();
		
		applyContent[i] = rs.getString(3); // 지원서 내용을 저장!
	}
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

	<title>동아리관리 &mdash; <%out.println(cname);%></title>
	
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
								<li><a href="Home.jsp?session=-1">Sign Out</a></li>
								<li><a href="seeMyclub.jsp">My Clubs</a></li>
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
					<h1 class="heading" data-aos="fade-up">지원서 확인 / 정보 수정</h1>

					<nav aria-label="breadcrumb" data-aos="fade-up" data-aos-delay="200">
						<ol class="breadcrumb text-center justify-content-center">
							<li class="breadcrumb-item "><a href="index.html">Home</a></li> <!-수정필요!-->
							<li class="breadcrumb-item active text-white-50"><%out.println("<a href=\"manageMyclub.jsp?clubID=" + clubID + "\" >Manage Home</a>"); %></li><!-수정필요!-->
						</ol>
					</nav>
				</div>
			</div>
		</div>
	</div>


	<div class="section bg-light">
		<div class="container">
			<div class="row">
				<div class="col-6 col-lg-3"  data-aos="fade-up" data-aos-delay="300">
					<div class="box-feature mb-4">
						<span class="flaticon-house mb-4 d-block"></span>
						<h3 class="text-black mb-3 font-weight-bold"><%=applyName[0]%>(<%=applySnum[0]%>)</h3>
						<p class="text-black-50"><%=applyContent[0]%></p>
						<p><%out.println("<a href=\"pass.jsp?clubID=" + clubID + "&sel=1&snum=" + applySnum[0] + "\" class=\"learn-more\" >"); %>
						ACCEPT<%out.println("</a>"); %>&nbsp;&nbsp;&nbsp;<%out.println("<a href=\"pass.jsp?clubID=" + clubID + "&sel=0&snum=" + applySnum[0] + "\" class=\"learn-more\" >"); %>
						REJECT<%out.println("</a>"); %></p>
					</div>
				</div>
				<div class="col-6 col-lg-3"  data-aos="fade-up" data-aos-delay="400">
					<div class="box-feature mb-4">
						<span class="flaticon-house-2 mb-4 d-block-3"></span>
						<h3 class="text-black mb-3 font-weight-bold"><%=applyName[1]%>(<%=applySnum[1]%>)</h3>
						<p class="text-black-50"><%=applyContent[1]%></p>
						<p><%out.println("<a href=\"pass.jsp?clubID=" + clubID + "&sel=1&snum=" + applySnum[1] + "\" class=\"learn-more\" >"); %>
						ACCEPT<%out.println("</a>"); %>&nbsp;&nbsp;&nbsp;<%out.println("<a href=\"pass.jsp?clubID=" + clubID + "&sel=0&snum=" + applySnum[1] + "\" class=\"learn-more\" >"); %>
						REJECT<%out.println("</a>"); %></p>
					</div>
				</div>
				<div class="col-6 col-lg-3"  data-aos="fade-up" data-aos-delay="500">
					<div class="box-feature mb-4">
						<span class="flaticon-building mb-4 d-block"></span>
						<h3 class="text-black mb-3 font-weight-bold"><%=applyName[2]%>(<%=applySnum[2]%>)</h3>
						<p class="text-black-50"><%=applyContent[2]%></p>
						<p><%out.println("<a href=\"pass.jsp?clubID=" + clubID + "&sel=1&snum=" + applySnum[2] + "\" class=\"learn-more\" >"); %>
						ACCEPT<%out.println("</a>"); %>&nbsp;&nbsp;&nbsp;<%out.println("<a href=\"pass.jsp?clubID=" + clubID + "&sel=0&snum=" + applySnum[2] + "\" class=\"learn-more\" >"); %>
						REJECT<%out.println("</a>"); %></p>
					</div>
				</div>
				<div class="col-6 col-lg-3"  data-aos="fade-up" data-aos-delay="600">
					<div class="box-feature mb-4">
						<span class="flaticon-house-3 mb-4 d-block-1"></span>
						<h3 class="text-black mb-3 font-weight-bold"><%=applyName[3]%>(<%=applySnum[3]%>)</h3>
						<p class="text-black-50"><%=applyContent[3]%></p>
						<p><%out.println("<a href=\"pass.jsp?clubID=" + clubID + "&sel=1&snum=" + applySnum[3] + "\" class=\"learn-more\" >"); %>
						ACCEPT<%out.println("</a>"); %>&nbsp;&nbsp;&nbsp;<%out.println("<a href=\"pass.jsp?clubID=" + clubID + "&sel=0&snum=" + applySnum[3] + "\" class=\"learn-more\" >"); %>
						REJECT<%out.println("</a>"); %></p>
					</div>
				</div>	

				<div class="col-6 col-lg-3"  data-aos="fade-up" data-aos-delay="300">
					<div class="box-feature mb-4">
						<span class="flaticon-house-4 mb-4 d-block"></span>
						<h3 class="text-black mb-3 font-weight-bold"><%=applyName[4]%>(<%=applySnum[4]%>)</h3>
						<p class="text-black-50"><%=applyContent[4]%></p>
						<p><%out.println("<a href=\"pass.jsp?clubID=" + clubID + "&sel=1&snum=" + applySnum[4] + "\" class=\"learn-more\" >"); %>
						ACCEPT<%out.println("</a>"); %>&nbsp;&nbsp;&nbsp;<%out.println("<a href=\"pass.jsp?clubID=" + clubID + "&sel=0&snum=" + applySnum[4] + "\" class=\"learn-more\" >"); %>
						REJECT<%out.println("</a>"); %></p>
					</div>
				</div>
				<div class="col-6 col-lg-3"  data-aos="fade-up" data-aos-delay="400">
					<div class="box-feature mb-4">
						<span class="flaticon-building mb-4 d-block-3"></span>
						<h3 class="text-black mb-3 font-weight-bold"><%=applyName[5]%>(<%=applySnum[5]%>)</h3>
						<p class="text-black-50"><%=applyContent[5]%></p>
						<p><%out.println("<a href=\"pass.jsp?clubID=" + clubID + "&sel=1&snum=" + applySnum[5] + "\" class=\"learn-more\" >"); %>
						ACCEPT<%out.println("</a>"); %>&nbsp;&nbsp;&nbsp;<%out.println("<a href=\"pass.jsp?clubID=" + clubID + "&sel=0&snum=" + applySnum[5] + "\" class=\"learn-more\" >"); %>
						REJECT<%out.println("</a>"); %></p>
					</div>
				</div>
				<div class="col-6 col-lg-3"  data-aos="fade-up" data-aos-delay="500">
					<div class="box-feature mb-4">
						<span class="flaticon-house mb-4 d-block"></span>
						<h3 class="text-black mb-3 font-weight-bold"><%=applyName[6]%>(<%=applySnum[6]%>)</h3>
						<p class="text-black-50"><%=applyContent[6]%></p>
						<p><%out.println("<a href=\"pass.jsp?clubID=" + clubID + "&sel=1&snum=" + applySnum[6] + "\" class=\"learn-more\" >"); %>
						ACCEPT<%out.println("</a>"); %>&nbsp;&nbsp;&nbsp;<%out.println("<a href=\"pass.jsp?clubID=" + clubID + "&sel=0&snum=" + applySnum[6] + "\" class=\"learn-more\" >"); %>
						REJECT<%out.println("</a>"); %></p>
					</div>
				</div>
				<div class="col-6 col-lg-3"  data-aos="fade-up" data-aos-delay="600">
					<div class="box-feature mb-4">
						<span class="flaticon-house-1 mb-4 d-block-1"></span>
						<h3 class="text-black mb-3 font-weight-bold"><%=applyName[7]%>(<%=applySnum[7]%>)</h3>
						<p class="text-black-50"><%=applyContent[7]%></p>
						<p><%out.println("<a href=\"pass.jsp?clubID=" + clubID + "&sel=1&snum=" + applySnum[7] + "\" class=\"learn-more\" >"); %>
						ACCEPT<%out.println("</a>"); %>&nbsp;&nbsp;&nbsp;<%out.println("<a href=\"pass.jsp?clubID=" + clubID + "&sel=0&snum=" + applySnum[7] + "\" class=\"learn-more\" >"); %>
						REJECT<%out.println("</a>"); %></p>
					</div>
				</div>	

			</div>
		</div>
	</div>


	<div class="section">
		<div class="container">
			<div class="row text-left mb-5">
				<div class="col-12">
					<h2 class="font-weight-bold heading text-primary mb-4">동아리 정보 수정:</h2>
				</div>
				<div style="color:black; font-weight:400; font-size:1.5em">
					<form action="edit_info.jsp?clubID=7">
					1. 동아리명: <input type="text" name="clubname" size=10><br>
					<%out.println("2. 동아리ID <input type=\"text\" name=\"clubId\" size=3 value=\""+ clubID +"\"><br>"); %>
					3. 동아리종류(단대|중앙|학과): <input type="text" name="clubcollege" size=10><br>
					4. 동아리타입: <input type="text" name="clubtype" size=10><br>
					5. 동아리지원양식: <input type="text" name="clubform" size=30>
					<input type="submit" name="send" value="Submit">
					</form>
				</div>
			</div>
			<div class="row text-left mb-5">
				<div class="col-12">
					<h2 class="font-weight-bold heading text-primary mb-4">동아리원 추가:</h2>
				</div>
				<div style="color:black; font-weight:400; font-size:1.7em">
				<form action="edit_info.jsp">
					<%out.println("동아리ID: <input type=\"text\" name=\"clubId\" size=3 value=\""+ clubID +"\"><br>"); %>
					추가하고자하는 학생의 학번을 입력하세요: <input type="text" name="ssn" size=10>
					<input type="submit" name="send" value="Submit">
				</form>
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
							<li style="white-space:nowrap;">윤주영 <a href="mailto:info@mydomain.com">yjooy34@gmail.com</a></li>
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
