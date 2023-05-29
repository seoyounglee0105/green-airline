<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<!-- 지우면 안됨 !! -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
#departure, #destination {
	margin-top: 10px;
	font-size: 25px;
	border: none;
	border-bottom: 2px solid black;
	padding-bottom: 5px;
}

.inFlightSvSearch--img--wrap img {
	display: flex;
	justify-content: center;
	align-items: center;
	width: auto;
}

.inFlightService--name--div {
	display: flex;
	justify-content: center;
	align-items: center;
}

/* input::placeholder{
	text-align: center;
} */
.pop--rel--keyword li {
	margin-top: 10px;
	font-size: 25px;
}

.search--airport--li {
	margin-top: 10px;
	font-size: 25px;
}

.modal-body {
	display: flex;
	flex-direction: column;
	height: 500px;
}

.modal-footer {
	display: flex;
	justify-content: space-between;
}

.search--airport--li:hover, .destination--airport--li:hover {
	cursor: pointer;
}

.datepicker {
	border: none;
}

.all--btn--class {
	background-color: white;
	color: black;
	border: 1px solid white;
	width: 200px;
	height: 100px;
	justify-content: space-between;
}

.search--btn--class {
	justify-content: space-between;
}

.modal--all--btn--div {
	display: flex;
	border: 1px solid #ebebeb;
	justify-content: space-between;
	align-items: center;
}

.inFlightSvSearch--header--wrap {
	border-bottom: 1px solid #ebebeb;
	padding-bottom: 10px;
}

.inFlightSvSearch--img--wrap {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 30px;
}

.inFlightSvSearch--description--wrap {
	margin-top: 30px;
	margin-bottom: 5px;
	font-size: 18px;
}

.ui-datepicker {
	font-size: 12px;
	width: 460px;
	height: 420px;
}

.ui-datepicker select.ui-datepicker-month, .ui-datepicker select.ui-datepicker-year
	{
	font-size: 20px;
}

.ui-datepicker td span, .ui-datepicker td a {
	font-size: 20px;
}

#datepicker {
	display: flex;
	flex-direction: column;
	border: none;
	font-size: 20px;
	z-index: 9999 !important;
}

.hasDatepicker {
	position: relative;
	z-index: 9999;
}

.ui-datepicker {
	z-index: 9999 !important;
}

.departure--airport--li:hover {
	cursor: pointer;
}

/* #modal--select--btn--id{
	width:200px;
	border:none;
	height:80px;
	background-color: #174481;
	border-radius: 15px;
} */
#destination--res--id {
	display: flex;
	flex-direction: column;
}

#destination--res--id img {
	width: 300px;
	height: 200px;
}

.autocomplete--list {
	width: 100%;
	background-color: #f3f3f3;
	min-height: 44px;
	max-height: 210px;
	margin: 0 0 15px;
	padding: 0px 10px;
	overflow: auto; /* max-height 넘으면 스크롤 생김 */
}

.autocomplete--list li {
	padding: 10px;
	border-bottom: 1px solid #ccc;
}

.departure--airport--li, .destination--airport--li {
	padding: 8px;
	border-bottom: 1px solid buttonhighlight;
}

.autocomplete--list li:last-of-type, .departure--airport--li:last-of-type,
	.destination--airport--li:last-of-type {
	border-bottom: hidden;
}

.departure--li:hover, .destination--li:hover, .departure--airport--li:hover,
	.destination--airport--li:hover {
	cursor: pointer;
	font-weight: 600;
	color: #3163aa;
}

.close--button {
	height: 24px;
	border: none;
	background: none;
	color: rgba(0, 0, 0, 0.7)
}

.modal--title {
	margin: 0;
}

.departure--region--li, .destination--region--li {
	padding: 10px;
	border-right: 1px solid white;
	border-bottom: 1px solid white;
	background-color: #f3f3f3;
	cursor: pointer;
}

.region--li--selected {
	background-color: #BCE3F6;
}

.departure--region--li--selected {
	background-color: #BCE3F6;
}

.destination--region--li--selected {
	background-color: #BCE3F6;
}

.airport--ul {
	margin: 0;
	max-height: 300px;
	overflow: auto;
}

.modal-body d-flex {
	display: flex;
	flex-direction: row;
}
</style>
<div>
	<main>
		<div class="inFlightSvSearch--header--wrap">
			<h2>기내 서비스 조회</h2>
		</div>
		<div class="inFlightSvSearch--img--wrap">
			<c:forEach var="inFlightServices" items="${inFlightServices}">
				<div class="inFlightService--image--name--wrap">
					<div class="inFlightService--wrap">
						<img alt="" src="/images/in_flight/${inFlightServices.iconImage}" width="50" height="50">
					</div>
					<div class="inFlightService--name--div">${inFlightServices.name}</div>
				</div>
			</c:forEach>
		</div>

		<div class="inFlightSvSearch--description--wrap">출/도착지를 입력하여 상세 정보를 확인해 보세요.</div>

		<div class="modal--all--btn--div">
			<button type="button" id="modal--departure--btn--id" class="all--btn--class" data-toggle="modal" data-target="#start">출발지</button>
			<button type="button" id="modal--destination--btn--id" class="all--btn--class" data-toggle="modal" data-target="#arrival">도착지</button>
			<button type="button" id="modal--select--btn--id" class="search--btn--class">조회</button>
		</div>
		<!-- The Modal -->
		<div class="modal fade" id="start" style="z-index: 1050;" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">

					<div class="modal-header">
						<h4 class="modal-title">출발지 검색</h4>
						<button type="button" class="close" data-dismiss="modal">×</button>
					</div>

					<div class="modal-body">
						<input type="text" autocomplete="off" id="departure" name="departure" placeholder="도시, 공항 검색">
						<div class="rel--search">
							<ul class="pop--rel--keyword">
							</ul>
						</div>
					</div>

					<!-- Modal footer -->
					<div class="modal-footer">
						<div class="modal--all--region">
							<a data-toggle="modal" href="#all--departure--airport--search" class="departure--button all--airport btn btn-primary">모든 지역 보기</a>
						</div>
						<div class="modal--cancel--btn">
							<button type="button" id="start--modal--btn" class="btn btn-primary" data-dismiss="modal">Submit</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 출발지 전체 공항 조회 모달 -->
		<div class="modal fade header--modal all--departure--airport--modal" id="all--departure--airport--search" style="z-index: 1060;">
			<div class="modal-dialog">
				<div class="modal-content" style="width: 498.4px; height: 640px;">
					<div class="modal--title--div" style="display: flex; justify-content: space-between; padding: 25px; border-bottom: 1px solid #ebebeb">
						<h4 class="modal--title">출발지 선택</h4>
						<button class="close--button close" data-dismiss="modal" aria-hidden="true">
							<span class="material-symbols-outlined">close</span>
						</button>
					</div>
					<div class="modal-body d-flex" style="flex-direction: row;">

						<!-- 지역 목록 -->
						<ul style="min-width: 210px; margin: 0 20px 0 0">
							<c:forEach var="r" items="${regionList}">
								<li class="departure--region--li">${r.region}</li>
							</c:forEach>
						</ul>

						<!-- 지역을 선택하면 취항지 불러오기 -->
						<div style="width: 100%;">
							<h5 style="margin: 0">취항지</h5>
							<hr style="margin: 10px 0 20px;">
							<ul class="departure--airport--ul">
							</ul>
						</div>

					</div>
					<div class="modal-footer">
						<div class="modal--cancel--btn">
							<button type="button" id="start--modal--btn" class="btn btn-primary" data-dismiss="modal">Submit</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="arrival" style="z-index: 1050;" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">

					<div class="modal-header">
						<h4 class="modal-title">도착지 검색</h4>
						<button type="button" class="close" data-dismiss="modal">×</button>
					</div>

					<div class="modal-body">
						<input type="text" autocomplete="off" name="destination" id="destination" placeholder="도시, 공항 검색">
						<div class="rel--search">
							<ul class="pop--rel--keyword">
							</ul>
						</div>
					</div>

					<div class="modal-footer">
						<div class="modal--all--region">
							<a data-toggle="modal" href="#all--destination--airport--search" class="destination--button all--airport btn btn-primary">모든 지역 보기</a>
						</div>
						<div class="modal--cancel--btn">
							<button type="button" id="arrival--modal--btn" class="btn btn-primary" data-dismiss="modal">Submit</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 도착지 전체 공항 조회 모달 -->
		<div class="modal fade header--modal all--destination--airport--modal" id="all--destination--airport--search" style="z-index: 1060;">
			<div class="modal-dialog">
				<div class="modal-content" style="width: 498.4px; height: 640px;">
					<div class="modal--title--div" style="display: flex; justify-content: space-between; padding: 25px; border-bottom: 1px solid #ebebeb">
						<h4 class="modal--title">도착지 선택</h4>
						<button class="close--button close" data-dismiss="modal" aria-hidden="true">
							<span class="material-symbols-outlined">close</span>
						</button>
					</div>
					<div class="modal-body d-flex" style="flex-direction: row;">

						<!-- 지역 목록 -->
						<ul style="min-width: 210px; margin: 0 20px 0 0">
							<c:forEach var="r" items="${regionList}">
								<li class="destination--region--li">${r.region}</li>
							</c:forEach>
						</ul>

						<!-- 지역을 선택하면 취항지 불러오기 -->
						<div style="width: 100%;">
							<h5 style="margin: 0">취항지</h5>
							<hr style="margin: 10px 0 20px;">
							<ul class="destination--airport--ul">
							</ul>
						</div>

					</div>
					<div class="modal-footer">
						<div class="modal--cancel--btn">
							<button type="button" id="arrival--modal--btn" class="btn btn-primary" data-dismiss="modal">Submit</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div id="destination--res--id"></div>




		<script src="/js/inFlightSvSearch.js"></script>
	</main>

</div>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
