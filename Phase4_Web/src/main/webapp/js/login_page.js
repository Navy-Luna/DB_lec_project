function categoryChange(e) {
	var good_a = ["전자공학부", "컴퓨터학부", "전기공학과"];
	var good_b = ["신소재공학부", "기계공학부", "건축학부", "화학공학과"];
	var good_c = ["경제통상학부", "경영학부"];
	var target = document.getElementById("department");

	if(e.value == "IT") var d = good_a;
	else if(e.value == "engineering") var d = good_b;
	else if(e.value == "EBA") var d = good_c;

	target.options.length = 0;

	for (x in d) {
		var opt = document.createElement("option");
		opt.value = d[x];
		opt.innerHTML = d[x];
		target.appendChild(opt);
	}	
}