<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java"
	import="java.text.*,java.sql.*,java.util.Scanner"%>
<%

String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
String USER_UNIVERSITY = "club";
String USER_PASSWD = "comp322";
Connection conn = null;
Statement stmt = null;
String sql="";
ResultSet rs = null;
String id =null;
String snumber=null;
String search=null;
StringBuffer sb = new StringBuffer();
Scanner sc= new Scanner(System.in);
request.setCharacterEncoding("utf-8");
snumber = request.getParameter("snumber");
search = request.getParameter("search");
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
sql = "select * from student";

//rs=stmt.executeQuery(sql);
//while(rs.next()){
	//String name = rs.getString(6);
	//System.out.println(name);
//}
%>
<!doctype html>
<html lang="ko">
<head>
<script src="https://kit.fontawesome.com/433b91c636.js"
	crossorigin="anonymous"></script>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="author" content="Untree.co">
<link rel="shortcut icon" href="favicon.png">

<meta name="description" content="" />
<meta name="keywords" content="bootstrap, bootstrap5" />

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap"
	rel="stylesheet">


<link rel="stylesheet" href="fonts/icomoon/style.css">
<link rel="stylesheet" href="fonts/flaticon/font/flaticon.css">

<link rel="stylesheet" href="css/tiny-slider.css">
<link rel="stylesheet" href="css/aos.css">
<link rel="stylesheet" href="css/style.css">

<title>Property &mdash; Free Bootstrap 5 Website Template by
	Untree.co</title>
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

					<ul
						class="js-clone-nav d-none d-lg-inline-block text-start site-menu float-end">
						<li><a href="index.html">Home</a></li>
						<li><a href="#">Club Search</a></li>
						<%if(snumber==null){%>
						<li><a href="/Phase4_Web/login_page.jsp">Sign In</a></li>
						<%}else{ %>
						<li class="has-children"><a href="#">MY</a>
							<ul class="dropdown">
								<li><a href="/Phase4_Web/Home.jsp">Sign Out</a></li>
								<li><a href="/Phase4_Web/seeMyclub.jsp">My Clubs</a></li>
								<li><a href="#">Settings</a></li>
							</ul> <%} %>
					</ul>

					<a href="#"
						class="burger light me-auto float-end mt-1 site-menu-toggle js-menu-toggle d-inline-block d-lg-none"
						data-toggle="collapse" data-target="#main-navbar"> <span></span>
					</a>

				</div>
			</div>
		</div>
	</nav>

	<div class="hero">


		<div class="hero-slide">
			<div class="img overlay"
				style="background-image: url('images/hobanu2.png')"></div>

		</div>

		<div class="container">
			<div class="row justify-content-center align-items-center">
				<div class="col-lg-9 text-center">
					<h1 class="heading" data-aos="fade-up">당신이 원하는 꿈의 동아리를 찾아보세요!</h1>
					
					<form name="form1" method="post"
					
						class="narrow-w form-search d-flex align-items-stretch mb-3"
						data-aos="fade-up" data-aos-delay="200">
						
						
						<input type="text" id="search_club" name="search_club"
							class="form-control px-4" placeholder="동아리를 검색해주세요"><br>
							<div>
							
							
						</div>
						<button type="button" class="btn btn-primary"
							onclick="post_search()">Search</button><br><br>
						
					</form>
				</div>
			</div>
		</div>
	</div>
	<script>
		function post_search(){
			
			console.log('js console');
			var snumber = <%out.println(snumber);%>;
			
			var club_name=form1.search_club.value;
			//alert(club_name);
			console.log('js console');
			console.log(snumber);
			console.log(club_name);
			//alert("hello");
			form1.action='Home.jsp?snumber='+snumber+'&search='+club_name;
			form1.submit();
		}
function post_search2(){
			
			console.log('js console');
			var snumber = <%out.println(snumber);%>;
			
			var club_name=<%out.println(search);%>;
			var type=form2.type.value;
			if(club_name==null)alert(club_name);
			console.log('js console');
			console.log(snumber);
			console.log(club_name);
			//alert("hello");
			form1.action='Home.jsp?snumber='+snumber+'&search='+club_name+'&type='+type;
			form1.submit();
		}
	</script>

	<div class="section" id="club_list_section">
		<div class="container">
			<div class="row mb-5 align-items-center">
				<div class="col-lg-6">
					<h2 class="font-weight-bold text-primary heading">동아리 리스트</h2>
					<div>
					<form name=form2>
					<input type="radio" name="type" value="center" onclick="post_search2()">중앙
							<input type="radio" value="single"name="type" >단대
							<input type="radio" value="depart" name="type" >학과
					</form>
					</div>
					
				</div>
			</div>
			<div class="section section-properties" id="club_list_section_p">
				<div class="container" id="club_list_container">
					<div class="row" id="club_list">
						<script>
							//alert("스크립트 시작");
							let pTagCount = 1;
							var search="<%=search%>";
							//alert("스크립트 중간");
							function create_club_list() {
								let inputString = document.getElementById("search_club").value;
								//alert("create_club_list()");
								//contatiner 삭제
								let container = document
										.getElementById('club_list_container');
								container.remove();
								// section_proper.. 받기
								let section = document
										.getElementById('club_list_section_p');
								//container div 생성
								let new_cont_divTag = document
										.createElement('div');
								new_cont_divTag.setAttribute('class',
										'container');
								new_cont_divTag.setAttribute('id',
										'club_list_container');
								section.appendChild(new_cont_divTag);
								//row_list div 생성
								let new_list_divTag = document
										.createElement('div');
								new_list_divTag.setAttribute('class', 'row');
								new_list_divTag.setAttribute('id', 'club_list');
								new_cont_divTag.appendChild(new_list_divTag);
								//item 단위시작
								var i;
								<%
								
								int i=0;
								System.out.println("search="+search);
								sb= new StringBuffer();
								
								if(search.equals("null") || search==null){
									System.out.println("searh가 null");
									if(type.equals("null")){
										sb.append("select distinct c1.cname,c1.ccollege,c1.ctype,u.rating,c1.cnumber\r\n"
												+ "from club c1,\r\n"
												+ "(select cname,round(AVG(r.rrating),1)rating\r\n"
												+ "from club c, review r\r\n"
												+ "where c.cnumber=r.cno\r\n"
												+ "group by c.cname) u\r\n"
												+ "where c1.cname = u.cname and rownum<10");
									}
									
								}
								else{
									System.out.println("검색들어옴");
									sb.append("select distinct c1.cname,c1.ccollege,c1.ctype,u.rating,c1.cnumber\r\n"
											+ "from club c1,\r\n"
											+ "(select cname,round(AVG(r.rrating),1)rating\r\n"
											+ "from club c, review r\r\n"
											+ "where c.cnumber=r.cno\r\n"
											+ "group by c.cname)u\r\n"
											+ "where c1.cname = u.cname and rownum<=10 and c1.cname='");
									sb.append(search+"'");
								}
								//System.out.printf(search);
								sql=sb.toString();
								rs=stmt.executeQuery(sql);
								
								System.out.printf("%-2s|%-10s|%-10s|%-10s|%-6s\n","번호","동아리명","단대","동아리타입","평점");
								int cnt=0;
								int num[]=new int[10];
								String []name;
								name=new String[10];
								String []type;
								type=new String[10];
								String college[]=new String[10];
								String []rating;
								rating=new String[10];
								int clubId[]=new int[10];
								
								while(rs.next()) {
									num[cnt]=cnt+1;
									name[cnt] = rs.getString(1);
									college[cnt]=rs.getString(2);
									type[cnt] = rs.getString(3);
									rating[cnt] = rs.getString(4);
									clubId[cnt]=rs.getInt(5);
									System.out.printf("%-2s|%-10s|%-10s|%-10s|%-6s\n",cnt+1,name[cnt],college[cnt],type[cnt],rating[cnt]);
									cnt++;
								}
								System.out.printf("cnt=%d\n",cnt);
								int club_cnt=0;
								
								%>
								//alert("변수 담기시작");
								var name=[];
								var type=[];
								var rate=[];
								//alert("변수 담기시작");
								name[0]="<%=name[0]%>";
								name[1]="<%=name[1]%>";
								name[2]="<%=name[2]%>";
								name[3]="<%=name[3]%>";
								name[4]="<%=name[4]%>";
								name[5]="<%=name[5]%>";
								name[6]="<%=name[6]%>";
								name[7]="<%=name[7]%>";
								name[8]="<%=name[8]%>";
								type[0]="<%=type[0]%>";
								type[1]="<%=type[1]%>";
								type[2]="<%=type[2]%>";
								type[3]="<%=type[3]%>";
								type[4]="<%=type[4]%>";
								type[5]="<%=type[5]%>";
								type[6]="<%=type[6]%>";
								type[7]="<%=type[7]%>";
								type[8]="<%=type[8]%>";
								rate[0]="<%=rating[0]%>";
								rate[1]="<%=rating[1]%>";
								rate[2]="<%=rating[2]%>";
								rate[3]="<%=rating[3]%>";
								rate[4]="<%=rating[4]%>";
								rate[5]="<%=rating[5]%>";
								rate[6]="<%=rating[6]%>";
								rate[7]="<%=rating[7]%>";
								rate[8]="<%=rating[8]%>";
								//alert("변수 담기완료");
								for (i = 0; i <<%out.println(cnt);%>; i++) {

									//col div 생성

									let new_col_divTag = document
											.createElement('div');
									new_col_divTag
											.setAttribute('class',
													'col-xs-12 col-sm-6 col-md-6 col-lg-4');
									new_list_divTag.appendChild(new_col_divTag);
									//p-i div 생성
									let new_pi_divTag = document
											.createElement('div');
									new_pi_divTag.setAttribute('class',
											'property-item mb-30');
									new_col_divTag.appendChild(new_pi_divTag);
									//p-i div 내부 태그들
									//img a 태그생성
									let new_img_aTag = document
											.createElement('a');
									new_img_aTag.setAttribute('href',
											'property-single.html');
									new_img_aTag.setAttribute('class', 'img');
									new_pi_divTag.appendChild(new_img_aTag);
									//img 태그생성
									let new_img_imgTag = document
											.createElement('img');
									new_img_imgTag.setAttribute('src',
											'images/img_1.jpg');
									new_img_imgTag.setAttribute('alt', 'Image');
									new_img_imgTag.setAttribute('class',
											'img-fluid');
									new_img_aTag.appendChild(new_img_imgTag);
									//pro_contetnt div 태그
									let new_content_divTag = document
											.createElement('div');
									new_content_divTag.setAttribute('class',
											'property-content');
									new_pi_divTag
											.appendChild(new_content_divTag);
									//content 내부
									//bin 태그 
									let new_null_divTag = document
											.createElement('div');
									new_content_divTag
											.appendChild(new_null_divTag);
									//bin 내부
									//제목 span 태그
									let new_title_spanTag = document
											.createElement('span');
									new_title_spanTag.setAttribute('class',
											'city d-block mb-3');
									new_title_spanTag.innerHTML = name[i];
									new_null_divTag
											.appendChild(new_title_spanTag);
									//specs div태그
									let new_specs_divTag = document
											.createElement('div');
									new_specs_divTag.setAttribute('class',
											'specs d-flex mb-4');
									new_null_divTag
											.appendChild(new_specs_divTag);
									//specs div 내부
									//block span 태그
									let new_block_spanTag = document
											.createElement('span');
									new_block_spanTag
											.setAttribute('class',
													'd-block d-flex align-items-center me-3');
									new_specs_divTag
											.appendChild(new_block_spanTag);
									//block span 내부
									//icon span 태그
									let new_icon1_spanTag = document
											.createElement('span');
									new_icon1_spanTag.setAttribute('class',
											'fa-solid fa-hashtag');
									new_block_spanTag
											.appendChild(new_icon1_spanTag);
									//icon1 이름
									let new_name1_spanTag = document
											.createElement('span');
									new_name1_spanTag.setAttribute('class',
											'caption');
									new_name1_spanTag.innerHTML = type[i];
									new_block_spanTag
											.appendChild(new_name1_spanTag);
									//block2 span 태그
									let new_block2_spanTag = document
											.createElement('span');
									new_block2_spanTag
											.setAttribute('class',
													'd-block d-flex align-items-center');
									new_specs_divTag
											.appendChild(new_block2_spanTag);
									//icon2 span 태그
									let new_icon2_spanTag = document
											.createElement('span');
									new_icon2_spanTag.setAttribute('class',
											'fa-regular fa-star');
									new_block2_spanTag
											.appendChild(new_icon2_spanTag);
									//icon2 이름
									let new_name2_spanTag = document
											.createElement('span');
									new_name2_spanTag.setAttribute('class',
											'caption');
									new_name2_spanTag.innerHTML = rate[i]
											+ "(평점)";
									new_block2_spanTag
											.appendChild(new_name2_spanTag);
									//detail a태그
									let new_detail_aTag = document
											.createElement('a');
									new_detail_aTag.setAttribute('href',
											'property-single.html');
									new_detail_aTag.setAttribute('class',
											'btn btn-primary py-2 px-3');
									new_detail_aTag.innerHTML = "자세히 보기";
									new_null_divTag
											.appendChild(new_detail_aTag);
								}
						<%
					 	System.out.println("hello~");
					 %>
							/* new_pTag.innerHTML = pTagCount + ". 추가된 p태그";

														new_divTag.appendChild(new_pTag); */

								pTagCount++;

							}
							create_club_list();
						</script>
					</div>
					<div class="row align-items-center py-5">
						<div class="col-lg-3">Pagination (1 of 10)</div>
						<div class="col-lg-6 text-center">
							<div class="custom-pagination">
								<a href="#" class="active">1</a> <a href="#">2</a> <a href="#">3</a>
								<a href="#">4</a> <a href="#">5</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="section section-5 bg-light">
		<div class="container">
			<div class="row justify-content-center  text-center mb-5">
				<div class="col-lg-6 mb-5">
					<h2 class="font-weight-bold heading text-primary mb-4">Our
						Agents</h2>
					<p class="text-black-50">학교에 동아리 정식 등록후에 저희 서비스에 등록하고 싶으시다면
						주저말고 연락부탁드립니다!</p>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-6 col-md-6 col-lg-4 mb-5 mb-lg-0">
					<div class="h-100 person">

						<img src="images/person_1-min.jpg" alt="Image" class="img-fluid">

						<div class="person-contents">
							<h2 class="mb-0">
								<a href="#">James Doe</a>
							</h2>
							<span class="meta d-block mb-3">Real Estate Agent</span>
							<p>Lorem ipsum dolor sit amet consectetur adipisicing elit.
								Facere officiis inventore cumque tenetur laboriosam, minus culpa
								doloremque odio, neque molestias?</p>

							<ul class="social list-unstyled list-inline dark-hover">
								<li class="list-inline-item"><a href="#"><span
										class="icon-twitter"></span></a></li>
								<li class="list-inline-item"><a href="#"><span
										class="icon-facebook"></span></a></li>
								<li class="list-inline-item"><a href="#"><span
										class="icon-linkedin"></span></a></li>
								<li class="list-inline-item"><a href="#"><span
										class="icon-instagram"></span></a></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="col-sm-6 col-md-6 col-lg-4 mb-5 mb-lg-0">
					<div class="h-100 person">

						<img src="images/person_2-min.jpg" alt="Image" class="img-fluid">

						<div class="person-contents">
							<h2 class="mb-0">
								<a href="#">Jean Smith</a>
							</h2>
							<span class="meta d-block mb-3">Real Estate Agent</span>
							<p>Lorem ipsum dolor sit amet consectetur adipisicing elit.
								Facere officiis inventore cumque tenetur laboriosam, minus culpa
								doloremque odio, neque molestias?</p>

							<ul class="social list-unstyled list-inline dark-hover">
								<li class="list-inline-item"><a href="#"><span
										class="icon-twitter"></span></a></li>
								<li class="list-inline-item"><a href="#"><span
										class="icon-facebook"></span></a></li>
								<li class="list-inline-item"><a href="#"><span
										class="icon-linkedin"></span></a></li>
								<li class="list-inline-item"><a href="#"><span
										class="icon-instagram"></span></a></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="col-sm-6 col-md-6 col-lg-4 mb-5 mb-lg-0">
					<div class="h-100 person">

						<img src="images/person_3-min.jpg" alt="Image" class="img-fluid">

						<div class="person-contents">
							<h2 class="mb-0">
								<a href="#">Alicia Huston</a>
							</h2>
							<span class="meta d-block mb-3">Real Estate Agent</span>
							<p>Lorem ipsum dolor sit amet consectetur adipisicing elit.
								Facere officiis inventore cumque tenetur laboriosam, minus culpa
								doloremque odio, neque molestias?</p>

							<ul class="social list-unstyled list-inline dark-hover">
								<li class="list-inline-item"><a href="#"><span
										class="icon-twitter"></span></a></li>
								<li class="list-inline-item"><a href="#"><span
										class="icon-facebook"></span></a></li>
								<li class="list-inline-item"><a href="#"><span
										class="icon-linkedin"></span></a></li>
								<li class="list-inline-item"><a href="#"><span
										class="icon-instagram"></span></a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>




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
