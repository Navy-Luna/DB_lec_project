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
		alert("���̵� �������� �ʰų� ��й�ȣ�� Ʋ�Ƚ��ϴ�.");
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
							<label for="user" class="label" style="color: black">�̸�</label> <input
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
							<label for="pass" class="label" style="color: black">�й�</label> <input
								id="user_number" name="user_number" input type="text" pattern="[0-9]+"
								class="input">
						</div>
						<div class="group">
							<label for="pass" class="label" style="color: black">�ܴ�</label> <select
								name="college" class="select" onchange="categoryChange(this)">
								<option value="IT">IT����
								<option value="engineering">��������
								<option value="EBA">������
							</select>
						</div>
						<div class="group">
							<label for="pass" class="label"style="color: black">�к�</label> <select
								id="department" name="department" class="select">
								<option></option>
							</select>
							<script>
								function categoryChange(e) {
									var good_a = [ "���ڰ��к�", "��ǻ���к�", "������а�" ];
									var good_b = [ "�ż�����к�", "�����к�", "�����к�",
											"ȭ�а��а�" ];
									var good_c = [ "��������к�", "�濵�к�" ];
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
							<label for="user" class="label" style="color: black">�̸���</label>
							<input id="user_email" name="user_email" type="text" class="input">
						</div>
						<div class="group">
							<label for="user" class="label" style="color: black">�޴�����ȣ(-����)</label>
							<input id="user_phone" name="user_phone" input type="text" pattern="[0-9]+"
								class="input">
						</div>
						<div class="group">
							<label for="user" class="label" style="color: black">����</label> <input
								type="radio" name="user_sex" value="M"> �� <input
								type="radio" name="user_sex" value="F"> ��
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