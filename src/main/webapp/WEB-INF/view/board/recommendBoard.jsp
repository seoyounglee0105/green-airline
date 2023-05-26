<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<style>
.container {
	text-align: center;
	display: flex;
	flex-wrap: wrap;
	justify-content: flex-start;
}

.modal-dialog.modal-fullsize {
	width: 100%;
	height: 100%;
	margin: 0;
	padding: 0;
}

.modal-content.modal-fullsize {
	height: auto;
	min-height: 100%;
	border-radius: 0;
}

.img {
	width: 150px;
	height: 150px;
}

.td--img {
	padding: 5px 20px;
}

.td--board {
	padding: 10px 20px;
}
.board--table{
	flex-wrap: wrap;
	
}
</style>
<main>
	<h1>게시판 화면</h1>
	<div class="container">
		<c:choose>
			<c:when test="${boardList!=null}">
				<%-- 게시글이 있는 경우 --%>
				<div class="board--table d-flex">
					<c:forEach var="board" items="${boardList}">
						<div class="tr--boardList" data-toggle="modal"
							data-target="#modalDetail" id="boardDetail${board.id}"
							style="cursor: pointer;">
							<div class="td--img">
								<img src="<c:url value="${board.thumbnailImage()}"/>" alt=""
									class="img">
							</div>
							<div class="td--board d-flex justify-content-between">
								<div>${board.viewCount}</div>
								<div>${board.title}</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</c:when>
			<c:otherwise>
				<%-- 게시글이 없는 경우 --%>
				<p>게시물이 없습니다.</p>
			</c:otherwise>
		</c:choose>
	</div>
	<button type="button" class="btn btn-primary"
		onclick="location.href='/board/insert'">글 쓰기</button>
</main>
<%-- Modal --%>
<div class="modal fade" id="modalDetail" data-backdrop="static"
	data-keyboard="false" tabindex="-1"
	aria-labelledby="myFullsizeModalLabel" aria-hidden="true">
	<div
		class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
		<div class="modal-content modal-fullsize">
			<div class="modal-header">
				<h5 class="modal-title" id="staticBackdropLabel">그린에어 여행일지</h5>
				<button type="button" class="close" aria-label="Close"
					data-dismiss="modal">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<%-- 모달 내용 입력 --%>
				<div class="board--title"></div>
				<div class="board--content"></div>
				<div class="board--userId"></div>
				<div class="board--viewCount"></div>
				<!-- 게시물id 가져와서 경로에 넣어주기 -->
				<%
				String boardId = request.getParameter("boardId");
				%>
				<img src="/images/like/like.png" class="board--heartCount"
					id="boardDetail<%=boardId%>"
					style="cursor: pointer; width: 30px; height: 30px;"></img>
				<div class="board--heartCount" id="boardDetail<%=boardId%>"></div>
			</div>
		</div>
	</div>
</div>

<script src="/js/board.js"></script>

<!-- 
=== TODO ===
1. 페이징처리

2-1. 찜 + 조회수 / 게시물 = 높은 숫자 게시물 5개만
상위에 보여주기

2-2 회원만 찜 누를 수 있게하기
// principal이 null이 아닐때만 img태그가 보이게하기
// 비회원은 찜 누르면 로그인창으로

4. 추천순, 조회수 많은순 필터링 기능
-->

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
