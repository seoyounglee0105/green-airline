
$(document).ready(function() {

	$("#inFlightMeals--option").on("change", function() {

		let nameVal = $("#inFlightMeals--option").val();
		$("#inFlightMeals--description").empty();
		$("#inFlightMeals--detail").empty();
		$(".modal--ifmdName").empty();
		/*$(".modal-content").empty();*/

		$.ajax({
			type: "get",
			url: "/changeCategory?name=" + nameVal,
			contentType: "application/json; charset=utf-8"
		}).done(function(data) {
			let description = $("#inFlightMeals--description");
			let detail = $("#inFlightMeals--detail");
			let modalIfmdName = $(".modal--ifmdName");
			for (let i = 0; i < data.length; i++) {
				// div태그 만들기
				let divNode = $("<div>");
				// 속성 추가
				divNode.attr("class", "ifm--detail");
				detail.append(divNode);

				let divNode2 = $("<span>");
				divNode.append(divNode2);
				divNode2.append(data[i].ifmdName);

				let radioNode = $("<input>");
				radioNode.attr("type", "radio");
				radioNode.attr("name", "ifmdName");
				radioNode.attr("id", "ifmdName--label" + i);
				radioNode.attr("value", data[i].ifmdName);
				modalIfmdName.append(radioNode);

				let labelNode = $("<label>");
				labelNode.attr("for", "ifmdName--label" + i);
				labelNode.append(data[i].ifmdName);
				modalIfmdName.append(labelNode);
				modalIfmdName.append("<br>");

				let divNode3 = $("<p>");
				divNode.append(divNode3);
				divNode3.append(data[i].ifmdDescription);

				let descriptionNode = $("#meals--image");
				descriptionNode.attr("src", "/images/in_flight/" + data[i].image);
			}

			description.append(data[1].ifmName);
			description.append(" : ");
			description.append(data[1].ifmDescription);

		}).fail(function(error) {
			console.log(error);
		})
	});



	$("#inFlightMeals--request--btn").on("click", function() {
		let isLoginCheck = $("#isLogin--check").val();
		if (isLoginCheck == "false") {
			alert("로그인 후 이용 가능합니다.");
			window.location.href = '/login';
			return false;
		}
	});
});

function departureDateFormat(date) {
	const year = date.getFullYear();
	const month = (1 + date.getMonth());
	const day = date.getDate();
	return `${year}년 ${month}월 ${day}일`; //Template literals 이용
}

$(document).ready(function() {
	$("#inflightmeal--request").on("click", function() {
		// 체크박스 체크 여부 확인
		let radioVal = $('input[name="ifmdName"]:checked').val();
		let amountVal = $('input[name="amount"]').val();
		let selectVal = $('select[name="modal--name--arrivaldate"').val();

		$.ajax({
			type: "get",
			url: "/inFlightService/specialMealReq?name=" + radioVal + "&amount=" + amountVal + "&departureDate=" + selectVal,
			contentType: "application/json; charset=utf-8",
		}).done(function(data) {

		}).fail(function(error) {
			console.log(error);
		})
	});
});

$('.modal').on('hidden.bs.modal', function(e) {
	console.log('modal close');
	$(this).find('form')[0].reset();
});

$(document).ready(function() {
	$("#modal--id--arrivaldate").on("change", function() {
		let arrivalDateVal = $("#modal--id--arrivaldate").val();

		$.ajax({
			type: "get",
			url: "/setMaxCount?departureDate=" + arrivalDateVal,
			contentType: "application/json; charset=utf-8"
		}).done(function(data) {
			$("#seat--count--input").attr("max", data.seatCount);
		}).fail(function(error) {
			console.log(error);
		});
	});
});


