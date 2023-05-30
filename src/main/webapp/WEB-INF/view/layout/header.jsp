<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린항공ㅣGREEN AIRLINES</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/layout.css">

<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<script defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAjjGP2VKpJKLym7EhCy_7fAFXxPOBuxL0&callback=initMap"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"
	integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500;700;900&display=swap" rel="stylesheet">
</head>

<style>
.ul--dropdown--menu>li {
	display: none;
	width: 85px;
}

.ul--dropdown--menu {
	position: absolute;
	padding: 5px;
	margin-left: -20px;
}
</style>

<body>

	<div class="page--container">
		<header>
			<div class="header--top">
				<ul>
					<c:choose>
						<%-- 로그인되지 않은 경우 --%>
						<c:when test="${principal == null}">
							<li class="material--li"><a href="/login"><span class="material-symbols-outlined" style="font-size: 22px;">login</span></a></li>
							<li><a href="/login">로그인</a></li>
							<li class="li--split">ㅣ</li>
							<li class="material--li"><a href="#"><span class="material-symbols-outlined" style="font-size: 22px;">person_add</span></a></li>
							<li><a href="/join">회원가입</a></li>
							<li class="li--split">ㅣ</li>
							<li class="material--li"><a href="#"><span class="material-symbols-outlined" style="font-size: 22px;">support_agent</span></a></li>
							<li class="customer--service--li"><a href="#">고객센터</a>
								<ul class="ul--dropdown--menu">
									<li class="li--dropdown--menu"><a href="/notice/noticeList">공지사항</a></li>
									<li class="li--dropdown--menu"><a href="#">자주묻는질문</a></li>
								</ul></li>
						</c:when>
						<c:otherwise>
							<li class="material--li"><a href="/logout"><span class="material-symbols-outlined" style="font-size: 22px;">logout</span></a></li>
							<li><a href="/logout">로그아웃</a></li>
							<li class="li--split">ㅣ</li>
							<li class="material--li"><a href="#"><span class="material-symbols-outlined" style="font-size: 22px;">badge</span></a></li>
							<li><a href="#">마이페이지</a></li>
							<li class="li--split">ㅣ</li>
							<li class="material--li"><a href="#"><span class="material-symbols-outlined" style="font-size: 22px;">support_agent</span></a></li>
							<li class="customer--service--li"><a href="#">고객센터</a>
								<ul class="ul--dropdown--menu">
									<li class="li--dropdown--menu"><a href="/notice/noticeList">공지사항</a></li>
									<li class="li--dropdown--menu"><a href="#">자주묻는질문</a></li>
									<li class="li--dropdown--menu">&nbsp;</li>
									<li class="li--dropdown--menu">&nbsp;</li>
								</ul></li>
						</c:otherwise>
					</c:choose>
				</ul>
			
			</div>
			<nav>
				<img alt="" src="/images/logo.jpg" class="logo" onclick="location.href='/';">
				<div class="main--menu" style="width: 100%;">
					<!-- todo : userRole에 따라 다르게 보이게 하기 -->
					<ul class="nav--depth1">
						<li><a href="#">예약</a></li>
						<li><a href="#">기내서비스</a></li>
						<li><a href="#">추천여행지</a></li>
						<li><a href="#">마일리지</a></li>
					</ul>
					<div class="nav--bar"></div>
					<!-- 내려오는 메뉴 -->
					<div class="nav--depth2">
						<div class="nav--depth2--div">
							<div class="nav--div1"></div>
							<div class="nav--split"></div>
							<div class="nav--div2"></div>
							<div class="nav--split"></div>
							<ul>
								<li><a href="/ticket/selectSchedule">항공권 예약</a>
								<li><a href="/airplane/info/1">항공기 정보</a>
								<li><a href="/ticket/list">항공권 구매 내역</a>
								<li><a href="/ticket/refundInfo">환불 안내</a>
								<li><a href="#">세부메뉴</a>
								<li><a href="#">세부메뉴</a>
							</ul>
							<div class="nav--split"></div>
							<ul>
								<li><a href="/inFlightService/inFlightServiceSearch">기내 서비스</a>
								<li><a href="/inFlightService/inFlightServiceSpecial">특별 기내식</a>
								<li><a href="/baggage/guide">수하물 안내</a>
								<li><a href="/baggage/baggageMiss">수하물 유실 (임시)</a>
								<li><a href="#">세부메뉴</a>
								<li><a href="#">세부메뉴</a>
							</ul>
							<div class="nav--split"></div>
							<ul>
								<li><a href="/board/list">여행일지</a>
								<li><a href="/map">공항위치</a>
								<li><a href="#">세부메뉴</a>
								<li><a href="#">세부메뉴</a>
								<li><a href="#">세부메뉴</a>
								<li><a href="#">세부메뉴</a>
								<li><a href="#">세부메뉴</a>
							</ul>
							<div class="nav--split"></div>
							<ul>
								<li><a href="/product/productMain">마일리지 사용몰</a>
								<li><a href="/product/registration">상품 등록</a>
								<li><a href="#">상품 수정</a>
								<li><a href="/mileage/selectAll">마일리지 조회</a>
								<li><a href="/mileage/request">마일리지 신청</a>
								<li><a href="#">세부메뉴</a>
								<li><a href="#">세부메뉴</a>
							</ul>
							<div class="nav--split"></div>
						</div>
						<div class="nav--depth2--background"></div>
					</div>
				</div>
			</nav>
		</header>

		<!-- 메인페이지가 아닐 때만 세부 메뉴 표시 -->
		<c:if test="${isMain == null}">
			<div class="header--menu--split">
				<div class="sub--menu">
					<div></div>
					<div>
						<button class="sub--menu--button home--button" onclick="location.href='/';">
							<ul class="d-flex">
								<li class="material--li"><span class="material-symbols-outlined material-symbols-outlined-white">house</span></li>
								<li>HOME</li>
							</ul>
						</button>
					</div>
					<div>
						<button class="sub--menu--button" style="border-left: hidden;">
							<ul class="d-flex justify-content-between" style="width: 100%">
								<li>대메뉴</li>
								<li class="material--li"><span class="material-symbols-outlined material-symbols-outlined-white">expand_more</span></li>
							</ul>
						</button>
					</div>
					<div>
						<button class="sub--menu--button" style="border-left: hidden;">
							<ul class="d-flex justify-content-between" style="width: 100%">
								<li>소메뉴</li>
								<li class="material--li"><span class="material-symbols-outlined material-symbols-outlined-white">expand_more</span></li>
							</ul>
						</button>
							</div>
						</div>
					</div>
		</c:if>

		<script type="text/javascript">
			$(".customer--service--li").on("mouseover", function() {
				$(".ul--dropdown--menu").css("display", "block");
				$(".li--dropdown--menu").css("display", "block");
				$(".ul--dropdown--menu").css("border", "1px solid black");
			});

			$(".customer--service--li").on("mouseleave", function() {
				$(".ul--dropdown--menu").css("display", "none");
				$(".li--dropdown--menu").css("display", "none");
			});
		</script>
		<script src="/js/layout.js"></script>