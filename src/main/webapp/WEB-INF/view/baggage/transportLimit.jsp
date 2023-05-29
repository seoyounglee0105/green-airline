<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<style>
table {
	border: 1px solid black;
}

table td {
	padding: 30px;
}

.transportLimit--ul>li {
	list-style: disc;
}

.transportLimit--ul--li>li {
	margin-left: 20px;
}

main {
	width: 1200px;
}
</style>
<main>
	<div>
		<div>
			<h1>운송 제한 물품 페이지</h1>
		</div>

		<div>
			<p>
				아시아나항공은 기내 안전을 위해 반입이 제한되거나 엄격히 금지되어 있는<br> 물품들이 있습니다. 항공 여행 전 아래 내용을 반드시 확인해 주시기 바랍니다.
			</p>
		</div>

		<div>
			<h3>항공 운송 금지 품목</h3>

			<div>
				<h5>리튬배터리로 구동되는 일체의 탈 것류, 160Wh 초과하는 리튬배터리</h5>
				<p>에어휠, 솔로휠, 호버보드, 미니 세그웨이, 전기자전거(전동스쿠터), 전동 킥보드 등 (장애인, 노약자용 전동휠체어 제외)</p>
			</div>
			<div>
				<h5>폭발성, 인화성, 유독성 물질</h5>
				<p>수류탄, 다이너마이트, 폭죽, 표백제, 수은, 산화제, 독극물, 도수 70%이상 알코올성 음료, 소화기, 최루가스 등</p>
			</div>
			<div>
				<h5>인화성 고압가스가 들어있는 용기</h5>
				<p>부탄가스, 개인용 산소통 등 * 개인용 산소통은 사전예약을 통해 당사에서 제공하는 산소통을 이용하시기 바랍니다.</p>
			</div>
		</div>

		<div>
			<h3>제한적으로 운송 가능한 품목</h3>
			<div>
				<ul class="transportLimit--ul transportLimit--ul--li">
					<li>여분의 리튬배터리(보조배터리), 전자담배, 라이터는 부치는 짐으로 운송 불가, 휴대하여 객실 반입만 허용 (단,충전식 전기라이터는 전 노선 위탁,객실 반입 불가)</li>
					<li>1인당 2.5kg 이내의 드라이아이스</li>
					<li>용기당(미국행) 또는 인당(호주발) 350ml 미만의 분말류(파우더류) 물품 ('18.6.30 부, 미국행/호주발 국제선 항공편에 한함)</li>
				</ul>
			</div>

			<div>
				<table border="1">
					<tr>
						<th>위탁 수하물 운송 (객실 휴대 불가)</th>
						<th>휴대 수하물 운송 (부치는 짐 불가)</th>
					</tr>

					<tr>
						<td>
							<ul class="transportLimit--ul">
								<li>도검, 칼 등 도검류</li>
								<li>야구배트, 골프채, 아령 등 스포츠용품류</li>
								<li>권총, 소총, 전자충격기, 총알 등 총기류</li>
								<li>망치, 못, 드릴 등 공구류</li>
								<li>쌍절곤, 격투무기, 수갑 등 무술호신용품</li>
								<li>100ml 초과하는 액체류 (국제선 노선 대상)</li>
								<li>에어로졸을 포함한 세면용품은 인당 최대 2L, 용기당 최대 500ml 까지 허용</li>
							</ul>
						</td>
						<td>
							<ul class="transportLimit--ul">
								<li>도검, 칼 등 도검류</li>
								<li>야구배트, 골프채, 아령 등 스포츠용품류</li>
								<li>권총, 소총, 전자충격기, 총알 등 총기류</li>
								<li>망치, 못, 드릴 등 공구류</li>
								<li>쌍절곤, 격투무기, 수갑 등 무술호신용품</li>
								<li>100ml 초과하는 액체류 (국제선 노선 대상)</li>
								<li>에어로졸을 포함한 세면용품은 인당 최대 2L, 용기당 최대 500ml 까지 허용</li>
							</ul>
						</td>
					</tr>
				</table>
			</div>
		</div>

		<div>
			<h3>휴대용 일반 전자기기의 리튬배터리 운송 규정 안내</h3>
			<p>
				항공 위험물 운송기술기준에 의해 위험물로 분류되는 리튬 배터리는 기내 휴대나 위탁수하물 반입이 금지되어 있으나,<br> 국제항공 운송협회 위험물 규정(IATA Dangerous Goods Regulations)에 의거하여 손님이 여행 중 개인 사용 목적으로 인정될 수 있는 소량에 한하여 운송을 허가하고 있습니다.
			</p>

			<table border="1">
				<tr>
					<th scope="col" rowspan="2">리튬 배터리 용량</th>
					<th scope="col" colspan="2">휴대수하물</th>
					<th scope="col" colspan="2">위탁수하물(부치는짐)</th>
				</tr>

				<tr>
					<th scope="col">기기장착 상태</th>
					<th scope="col">여분(보조)배터리</th>
					<th scope="col">기기장착 상태</th>
					<th scope="col">여분(보조)배터리</th>
				</tr>

				<tr>
					<th scope="row">100Wh 이하, 리튬 함량 2g 이하</th>
					<td>5개 가능</td>
					<td>5개 가능</td>
					<td>5개 가능</td>
					<td><span>운송불가</span></td>
				</tr>

				<tr>
					<th scope="row">100Wh 초과~160Wh 이하 <br> 리튬 함량 8g 이하 <br> (항공사 승인 필요)
					</th>

					<td>휴대, 위탁 합하여 1개</td>
					<td>2개 가능</td>
					<td>휴대, 위탁 합하여 1개</td>
					<td><span>운송불가</span></td>
				</tr>

				<tr>
					<th scope="row">160Wh 초과</th>
					<td colspan="4"><span>운송불가</span></td>
				</tr>
			</table>

			* 배터리 용량 구하는 법 : 용량(Wh) = 전압(V) X 전류(Ah), 1Ah= 1,000mAh
			<ul class="transportLimit--ul transportLimit--ul--li">
				<li>여분의 리튬배터리 및 보조 배터리는 위탁수하물로 운송이 불가하며, 휴대용 전자기기를 위탁수하물로 운송하는 경우 반드시 전원을 꺼주시기 바랍니다.</li>
				<li>광저우, 베이징 등 중국 출발 항공편에는 리튬배터리(기기 장착, 여분 포함)의 위탁 수하물 반입이 엄격히 제한됩니다. 또한 용량이 표시되지 않았거나 확인 불가시 운송이 거절될 수 있습니다.</li>
				<li>리튬배터리로 구동되는 일체의 탈 것류(장애인, 노약자용 전동 휠체어 제외)는 배터리 용량에 관계없이 기내반입/수하물 위탁 모두 불가합니다.</li>
				<li>* 대상 품목 : 에어휠, 솔로휠, 호버보드, 미니 세그웨이, 전기 자전거(전동 스쿠터), 전동 킥보드, 전동 스케이트 보드 등</li>
				<li>객실 내 사용을 위한 POC, CPAP 등의 휴대용 전자 의료기기에는 별도의 규정이 적용됩니다.</li>
				<li>일본 출발 항공편의 경우 리튬배터리 분리불가형 헤어컬(고데기)은 기내반입/수하물 위탁 모두 불가합니다.</li>
			</ul>
		</div>

		<div>
			<h3>전동휠체어 및 전동스쿠터(장애인/노약자용, 非레저용) 배터리 운송 규정 안내</h3>
			<table border="1">
				<tr>
					<th scope="col" class="NamoSE_border_show">종류</th>
					<th scope="col" class="NamoSE_border_show">배터리 용량</th>
					<th scope="col" class="NamoSE_border_show">비고</th>
				</tr>

				<tr>
					<th>건식 배터리 <br> 습식 배터리
					</th>
					<td>제한 없음</td>
					<td>
						<ul class="transportLimit--ul">
							<li>배터리 분리 가능 여부 확인 필요</li>
							<li>예약 시 배터리 건식/습식 확인</li>
							<li>습식의 경우 누출형/비누출형 정보 제공 요망
							<li>건식 배터리 종류 : Ni-Mh, Ni-Cd 등</li>
							<li>비누출형 배터리 종류 : SLA, VRLA, AGM 등</li>
						</ul>
					</td>
				</tr>
			</table>
		</div>

		<div>
			<select id="carryOnLiquids--select--box">
				<c:forEach var="carryOnLiquids" items="${carryOnLiquids}">
					<option id="carryOnLiquids--category" value="${carryOnLiquids.name}">${carryOnLiquids.name}</option>
				</c:forEach>
			</select>
		</div>
		<div>
			<div>
				<h2 id="carryOnLiquids--name--id">${carryOnLiquids.get(0).name}의조회 결과입니다.</h2>
			</div>

			<div>
				<table border="1">
					<tr>
						<td>대상</td>
						<td id="carryOnLiquids--target--id">${carryOnLiquids.get(0).target}</td>
					</tr>
					<tr>
						<td>제한 지침</td>
						<td id="carryOnLiquids--limitGuide--id">${carryOnLiquids.get(0).limitGuide}</td>
					</tr>
					<tr>
						<td>면세품 지침</td>
						<td id="carryOnLiquids--taxFreeGuide--id">${carryOnLiquids.get(0).taxFreeGuide}</td>
					</tr>

				</table>
			</div>
		</div>

		<div>
			<h3>유의사항</h3>
			<ul class="transportLimit--ul transportLimit--ul--li">
				<li>의사가 처방한 의약품에 대하여는 의약 상품명 또는 의사소견서를 소지하고 물품의 출처를 증명하는 서류 (처방전, 약 봉투, 진단서 등)를 제시하여야 합니다.</li>
				<li>보안 검색요원에 의해 물품 샘플 채취 또는 진위 여부를 확인 받을 수 있습니다.</li>
				<li>의심의 여지가 있는 경우 물품 포기 또는 압수될 수 있습니다.</li>
				<li>각 국가/지역 사정에 따라 해외 도착지 또는 환승 검색 시 압수될 수도 있습니다.</li>
				<li>비행 여정은 출발 공항부터 최종 목적지 공항 도착까지의 총 비행시간 및 지연운항, 회항, 공항 터미널 대기 시간 등을&nbsp;고려하여 합한 총 시간을 의미합니다.</li>
				<li>예외 대상품목은 1리터 투명개폐가능봉투에 담겨져 있지 않아도 허용됩니다.</li>
				<li>액체류 면세품을 구매한 승객이 환승 검색대를 통과할 때 STEB에 물품과 영수증이 들어있지 않으면 물품이 폐기 또는 압류 처분 됩니다. (인천-부산 내항기 환승시에도 해당)</li>
			</ul>
		</div>

		<script src="/js/baggage.js"></script>
	</div>
</main>


<%@ include file="/WEB-INF/view/layout/footer.jsp"%>