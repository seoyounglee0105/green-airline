	//$(".header--menu--split").css("width", $(".page--container").width());
	let footerBottom;
	
	$(document).ready(function() {
		footerBottom = $("footer").position().top + $("footer").height() + 60;
	});
	
	$(window).resize(function() {
		$(".nav--depth2--background").css("width", $(".nav--depth2--div").width());	
		footerBottom = $("footer").position().top + $("footer").height() + 60;
	});

	let menuIndex;
	
	// 상단 메뉴에서 nav--bar 움직이게
	$(".nav--depth1").contents().on("mouseenter", function() {
		// 이미 해당 메뉴로 이동 중이면 밑의 코드 실행 X
		if (menuIndex == $(this).index()) {
			return;
		}
		
		// 선택된 요소 인덱스
		menuIndex = $(this).index();
		let navBarLeft = menuIndex * $(this).width();
		
		$(".nav--bar").stop();
		
		// 이미 메뉴가 내려와있는 상태라면
		if ($(".nav--bar").css("display") == "block") {
			if (menuIndex == 1) {
				$(".nav--bar").animate({left : navBarLeft + 1}, 700);	
			} else if (menuIndex > 2) {
				$(".nav--bar").animate({left : navBarLeft + 2}, 700);			
			} else {
				$(".nav--bar").animate({left : navBarLeft}, 700);
			}
			$(this).children().css("color", "#314f79");
			$(this).siblings().children().css("color", "#3e3e3e");
		} else {
			$(".nav--bar").css("display", "block");
			if (menuIndex > 0) {
				$(".nav--bar").css("left", navBarLeft + 1);
 			} else {
				$(".nav--bar").css("left", navBarLeft); 				
 			}
			$(".nav--depth1").css("margin-bottom", "10px");
			//$(".nav--depth2").css("width", $(".page--container").width());	
			//$(".header--menu--split").css("width", $(".page--container").width());
			
			// 세부 메뉴 밑으로는 어둡게 처리
			let headerHeight = 569;
			let backgroundHeight;
			if (footerBottom < window.innerHeight) {
				backgroundHeight = window.innerHeight - headerHeight;	
			} else {
				backgroundHeight = footerBottom - headerHeight;
			}
			$(".nav--depth2--background").css("height", backgroundHeight);	
			$(this).children().css("color", "#314f79");
			$(this).siblings().children().css("color", "#3e3e3e");
			
			$(".nav--depth2").slideDown(function() {
				$(".nav--depth2--background").css("width", $(".nav--depth2--div").width());	
			});
		}
	});

	// 내려온 메뉴 내에서 nav--bar 움직이게
	$(".nav--depth2--div").contents().on("mouseover", function() {
		let thisIndex = $(this).index();
		if (thisIndex <= 4) {
			// 이미 해당 메뉴로 이동 중이면 밑의 코드 실행 X
			if (menuIndex == 0) {
				return;
			}
			menuIndex = 0;
		} else if (thisIndex == 6) {
			if (menuIndex == 1) {
				return;
			}
			menuIndex = 1;
		} else if (thisIndex == 8) {
			if (menuIndex == 2) {
				return;
			}
			menuIndex = 2;
		} else if (thisIndex == 10) {
			if (menuIndex == 3) {
				return;
			}
			menuIndex = 3;
		}
		
		$(".nav--bar").stop();
		
		let navBarLeft = menuIndex * 230;
		if (menuIndex == 1) {
			$(".nav--bar").animate({left : navBarLeft + 1}, 700);	
		} else if (menuIndex == 2) {
			$(".nav--bar").animate({left : navBarLeft + 2}, 700);			
		} else if (menuIndex == 3) {
			$(".nav--bar").animate({left : navBarLeft + 3}, 700);	
		} else {
			$(".nav--bar").animate({left : navBarLeft}, 700);
		}
		
		$(".nav--depth1 li").eq(menuIndex).children().css("color", "#314f79");
		$(".nav--depth1 li").eq(menuIndex).siblings().children().css("color", "#3e3e3e");
	
	});
	
	$(".main--menu").on("mouseleave", function() {
		menuIndex = null;
		$(".nav--bar").css("display", "none");
		$(".nav--depth1").css("margin-bottom", "17px");
		$(".nav--depth2").css("display", "none");
		$(".nav--depth1 li").children().css("color", "#3e3e3e");
	});
	
	$(".nav--depth2--background").on("mouseover", function() {
		menuIndex = null;
		$(".nav--bar").css("display", "none");
		$(".nav--depth1").css("margin-bottom", "17px");
		$(".nav--depth2").css("display", "none");
	});
	
// 현재 날짜
function getCurrentDate() {
    var date = new Date();
    var year = date.getFullYear().toString();

    var month = date.getMonth() + 1;
    month = month < 10 ? '0' + month.toString() : month.toString();

    var day = date.getDate();
    day = day < 10 ? '0' + day.toString() : day.toString();

    return year + "-" + month + "-" + day ;
}

$.datepicker.setDefaults({
	dateFormat: 'yy-mm-dd',
	prevText: '이전 달',
	nextText: '다음 달',
	monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	showMonthAfterYear: true,
	yearSuffix: '년'
});

$(function() {
	$('.datepicker').datepicker();
});
	
// 날짜 차이를 '일'로 계산
function calculateDayDiff (date1, date2) {
	let time1 = date1.getTime();
	let time2 = date2.getTime();
	let timeDiff = time1 - time2;

	let dayCount = Math.floor(timeDiff / (1000 * 60 * 60 * 24));
	return dayCount;
}
