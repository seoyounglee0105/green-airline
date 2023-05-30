<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린항공ㅣGREEN AIRLINES</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/layoutManager.css">

<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"
	integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500;700;900&display=swap" rel="stylesheet">
</head>

<style>
</style>

<body>

	<div class="page--container">
		<div class="header--container" style="width: 100%;">
			<header>
				<div class="header--top">
					<ul>
						<li class="material--li"><a href="/logout"><span class="material-symbols-outlined material-symbols-outlined-white-not" style="font-size: 22px;">logout</span></a></li>
						<li class="top--text--li"><a href="/logout">로그아웃</a></li>
					</ul>
				
				</div>
				<nav>
					<img alt="" src="/images/logo2.png" class="logo" onclick="location.href='/manager/dashboard';">
					<div class="main--menu" style="width: 100%;">
						<ul class="nav--depth1">
							<li><a href="#">회원관리</a></li>
							<li><a href="/inFlightService/inFlightServiceSearch">기내서비스</a></li>
							<li><a href="/product/productMain">마일리지</a></li>
							<li><a href="/notice/noticeList">고객센터</a></li>
						</ul>
					</div>
				</nav>
			</header>
		</div>

		<c:if test="${isMain == null}">
			<div class="header--menu--split">
				<div class="sub--menu">
					<div>
						<button class="sub--menu--button home--button" onclick="location.href='/manager/dashboard';">
							<ul class="d-flex">
								<li class="material--li"><span class="material-symbols-outlined material-symbols-outlined-white">house</span></li>
								<li>HOME</li>
							</ul>
						</button>
					</div>
					<div>
						<button id="subMenu1" class="sub--menu--button" style="border-left: hidden;">
							<ul class="d-flex justify-content-between" style="width: 100%">
								<li id="currentMainMenu"></li>
								<li class="material--li"><span class="material-symbols-outlined material-symbols-outlined-white">expand_more</span></li>
							</ul>
						</button>
						<ul id="dropMenu1" class="drop--menu">
							<!-- AJAX로 추가 -->
						</ul>
					</div>
					<div>
						<button id="subMenu2" class="sub--menu--button" style="border-left: hidden;">
							<ul class="d-flex justify-content-between" style="width: 100%">
								<li id="currentSubMenu"></li>
								<li class="material--li"><span class="material-symbols-outlined material-symbols-outlined-white">expand_more</span></li>
							</ul>
						</button>
						<ul id="dropMenu2" class="drop--menu">
							
						</ul>
					</div>
				</div>
			</div>
		</c:if>

		<script src="/js/layoutManager.js"></script>