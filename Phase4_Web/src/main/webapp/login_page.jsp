<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="EUC-KR">
<link href="css/login/style.css" rel="stylesheet">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript" src="js/login_page.js"></script>
	<% if (request.getParameter("error") != null) { %>
	<script type="text/javascript">
		alert("아이디가 존재하지 않거나 비밀번호가 틀렸습니다.");
	</script>
	<% } %>

	<div class="login-wrap">
		<div class="login-html">
			<input id="tab-1" type="radio" name="tab" class="sign-in" checked><label
				for="tab-1" class="tab">Sign In</label> <input id="tab-2"
				type="radio" name="tab" class="sign-up"><label for="tab-2"
				class="tab">Sign Up</label>
			<div class="login-form">
				<div class="sign-in-htm">
					<form action="login_ok.jsp" method="post">
						<div class="group">
							<label for="user" class="label" style="color: black;">Username</label>
							<input id="user" name="user" type="text" class="input">
						</div>
						<div class="group">
							<label for="pass" class="label" style="color: black;">Password</label>
							<input id="pass" name="pass" type="password" class="input"
								data-type="password">
						</div>
						<div class="group">
							<input type="submit" class="button" value="Sign In">
						</div>
					</form>
				</div>
				<div class="sign-up-htm">
					<form action="sign_up.jsp" method="post">
						<div class="group">
							<label for="user" class="label" style="color: black">이름</label> <input
								id="user_name" name="user_name" type="text" class="input">
						</div>
						<div class="group">
							<label for="user" class="label" style="color: black">ID</label> <input
								id="user_id" name="user_id" type="text" class="input">

						</div>
						<div class="group">
							<label for="pass" class="label" style="color: black">Password</label>
							<input id="pass" name="user_pass" type="password" class="input"
								data-type="password">
						</div>
						<div class="group">
							<label for="pass" class="label" style="color: black">Repeat
								Password</label> <input id="pass" name="user_pass_repeat" type="password" class="input"
								data-type="password">
						</div>
						<div class="group">
							<label for="pass" class="label" style="color: black">학번</label> <input
								id="user_number" name="user_number" input type="text" pattern="[0-9]+"
								class="input">
						</div>
						<div class="group">
							<label for="pass" class="label" style="color: black">단대</label> <select
								name="college" class="select" onchange="categoryChange(this)">
								<option value="IT">IT대학
								<option value="engineering">공과대학
								<option value="EBA">경상대학
							</select>
						</div>
						<div class="group">
							<label for="pass" class="label"style="color: black">학부</label> <select
								id="department" name="department" class="select">
								<option></option>
							</select>
							<script>
								function categoryChange(e) {
									var good_a = [ "전자공학부", "컴퓨터학부", "전기공학과" ];
									var good_b = [ "신소재공학부", "기계공학부", "건축학부",
											"화학공학과" ];
									var good_c = [ "경제통상학부", "경영학부" ];
									var target = document
											.getElementById("department");

									if (e.value == "IT")
										var d = good_a;
									else if (e.value == "engineering")
										var d = good_b;
									else if (e.value == "EBA")
										var d = good_c;

									target.options.length = 0;

									for (x in d) {
										var opt = document
												.createElement("option");
										opt.value = d[x];
										opt.innerHTML = d[x];
										target.appendChild(opt);
									}
								}
							</script>
						</div>
						<div class="group">
							<label for="user" class="label" style="color: black">이메일</label>
							<input id="user_email" name="user_email" type="text" class="input">
						</div>
						<div class="group">
							<label for="user" class="label" style="color: black">휴대폰번호(-제외)</label>
							<input id="user_phone" name="user_phone" input type="text" pattern="[0-9]+"
								class="input">
						</div>
						<div class="group">
							<label for="user" class="label" style="color: black">성별</label> <input
								type="radio" name="user_sex" value="M"> 남 <input
								type="radio" name="user_sex" value="F"> 여
						</div>
						<div class="group">
							<input type="submit" class="button" value="Sign Up">
						</div>
					</form>
					<div class="hr"></div>
					<div class="foot-lnk">
						<label for="tab-1">Already Member?</a>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>