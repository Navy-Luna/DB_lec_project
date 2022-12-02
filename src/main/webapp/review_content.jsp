<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%
//로그인 관련
request.setCharacterEncoding("utf-8"); 
String id = (String)session.getAttribute("id");
String rnum = request.getParameter("rnum");


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
PreparedStatement ps;
String snum="";
if(id!=null){
	sql = "select snumber from student where sidentifier='"+id+"'";
	rs=stmt.executeQuery(sql);
	while(rs.next()){
		snum = rs.getString(1);
	}
}

sql = "select cno from review where rnumber="+rnum;
rs = stmt.executeQuery(sql);
int clubID=0;
rs.next();
	clubID = rs.getInt(1);


sql = "select cname from club where cnumber=" + clubID;
rs = stmt.executeQuery(sql);
String cname="";
rs.next();
	cname = rs.getString(1);

sql = "select r.*, sname from review r, student where rnumber = " + rnum
+ " and r.sno = snumber";
rs = stmt.executeQuery(sql);
String content, title, sname;
int rating=0;
Date date;
rs.next();
	rating = rs.getInt(2);
	content = rs.getString(3);
	title = rs.getString(4);
	date = rs.getDate(5);
	sname = rs.getString(8);

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

	<title><%out.println(cname);%> Review &mdash; <%out.println(title); %></title>
	
	<style>
	.col-lg-6 .text-black-50{
	font-size: 25px
	}
	</style>
	
</head>
<body>
<%
if(rnum==null){%>
<script>
location.href = detailed_information.jsp;
</script>
<% }
%>

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
						<!-- <li><a href="club_serach.jsp">Club Search</a></li> -->
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
					<h1 class="heading" data-aos="fade-up"><%out.println(title); %></h1>

					<nav aria-label="breadcrumb" data-aos="fade-up" data-aos-delay="200">
						<ol class="breadcrumb text-center justify-content-center">
							<li class="breadcrumb-item "><a href="index.html"><%out.println(sname); %></a></li>
							<li class="breadcrumb-item "><a href="index.html"><%out.println(date); %></a></li> 
							<li class="breadcrumb-item "><a href="index.html"><%out.println(rating); %>점</a></li>
						</ol>
					</nav>
				</div>
			</div>
		</div>
	</div>



	<div class="section">
		<div class="container">
			<div class="row text-left mb-5">
				
				<div class="col-lg-6">
					<p class="text-black-50" style="font-size:20px"><%out.println(content); %></p>
				</div>
					
			</div>

		</div>
	</div>
	
	
	<div class="card-body">
                                <!-- Comment form-->
                                <form action="comment_submit.jsp?rnum=<%out.println(rnum); %>" class="narrow-w form-search d-flex mb-3" data-aos-delay="200" method="post">
									<textarea class="form-control" rows="3" placeholder="Join the discussion and leave a comment!" name="tcontent"></textarea>
									<button type="submit" class="btn btn-primary">Submit</button>
								</form>
                                
                                <!-- Comment with nested comments-->
                                <!-- <div class="d-flex mb-4"> -->
                                	<%
                                		
	                                	sql = "select c.*, sname from commentt c, student where rno = " + rnum
	                                    + " and c.sno = snumber "
	                                    + "order by tdate desc";
			                            rs = stmt.executeQuery(sql);
			                            int j = 0;
			                            
			                            Statement istmt = conn.createStatement();
			                            while (rs.next()) {
			                            	out.println("<div class=\"d-flex mb-4\">");
			                            	out.println("<div class=]\"flex-shrink-0\"><img class=\"rounded-circle\" src=\"./images/knu_ch.jpeg\" alt=\"...\" height=\"50\" width=\"50\"/></div>");
			                            	out.println("<div class=\"ms-3\">");
			                                ++j;
			                                int tnumb = rs.getInt(1);
			                             
			                                // int tsno = rs.getInt(3);
			                                String tcontent = rs.getString(4);
			                                Date tdate = rs.getDate(5);
			                                String tsname = rs.getString(6);
			                                
			                                out.println("<div class=\"fw-bold\">"+tsname+"(" + tdate + ")"+"</div>");
			                                out.println(tcontent);
			                                out.println("<div>");
			                                out.println("<a style=\"font-size:11px\" value=\"더보기\" onclick=\"if(this.parentNode.getElementsByTagName('div')[0].style.display != ''){this.parentNode.getElementsByTagName('div')[0].style.display = '';this.value = '숨기기';}else{this.parentNode.getElementsByTagName('div')[0].style.display = 'none'; this.value = '더보기';}\" type=\"button\" >답글 작성</a>");
			                                out.println("<div style=\"display: none;\">");
			                                out.println("<form action=\"reply_submit.jsp?tnum="+tnumb+"&rnum="+rnum+"\" class=\"narrow-w form-search d-flex align-items-stretch mb-3\" data-aos=\"fade-up\" data-aos-delay=\"200\"method=\"post\">");
			                                out.println("<textarea style=\"width: 1000px;\"class=\"form-control\" rows=\"2\" placeholder=\"Join the discussion and leave a comment!\" name=\"dcontent\"></textarea>");
			                                out.println("<button type=\"submit\" class=\"btn btn-primary\" style=\"padding: 0px 20px 0px 20px;\">Submit</button>");
			                                out.println("</form>");
			                            	out.println("</div> </div>");
                              // 답글
			                                sql = "select r.*, sname from reply r, student where tno = " + tnumb + " and r.sno=snumber";
			
			                                ResultSet trs = istmt.executeQuery(sql);
			                                while (trs.next()) {
			                                	out.println("<div class=\"d-flex mt-4\"><div class=\"flex-shrink-0\"><img class=\"rounded-circle\" src=\"./images/knu_ch.jpeg\" alt=\"...\"  height=\"50\" width=\"50\"/></div><div class=\"ms-3\">");
			                                    String dcontent = trs.getString(2);
			                                    Date ddate = trs.getDate(3);
			                                    // String dsno = trs.getString(4);
			                                    String dsname = trs.getString(6);
			                                   
			                                    out.println("<div class=\"fw-bold\">" + dsname + "(" + ddate + ")" +"</div>");
			                                    out.println(dcontent);
			                                    out.println("</div></div>");
			                                }
			                                out.println("</div></div>");
			                            }
			                            
                                	%>
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
  <%
 	stmt.close();
  	conn.close();
  %>