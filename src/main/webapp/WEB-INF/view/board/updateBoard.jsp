<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<style>
.form-control {
	width: 1110px;
	margin-left: 70px;
}
</style>
<main>
	<h5>여행일지</h5>

	<form action="/board/update/{id}" method="post"
		enctype="multipart/form-data">

		<table class="table">
			<tr>
				<td><input class="form-control" id="title" type="text"
					name="title" placeholder="제목"></td>
			</tr>
		</table>
		<div class="container">
			<textarea class="summernote" id="content" rows="10" name="content"></textarea>
		</div>
		<div class="custom-file">
			<input type="file" class="custom-file-input" id="customFile"
				accept=".jpg, .jpeg, .png" name="file"> <label
				class="custom-file-label" for="customFile">썸네일용 이미지</label>
		</div>
		<div class="modal-footer">
			<button type="submit" class="btn btn-primary" id="updateButton">작성하기</button>
		</div>
	</form>
</main>
<script>
	$('.summernote').summernote({
		placeholder : "내용을 입력 해주세요",
		tabsize : 2,
		height : 500,
		// 에디터 로딩후 포커스를 맞출지 여부
		focus : true,
		lang : 'ko-KR',
		// 크기 조절 기능 삭제
		disableResizeEditor : true,
		callbacks : {
			onInit : function(c) {
				c.editable.html('');
			}
		}
	});

	function sendImg(file, context) {
		// 폼 데이터 형태로 바꾸기
		var data = new FormData();
		data.append('file', file);

		$.ajax({
			data : data,
			type : "POST",
			url : "/uploadFileName",
			cache : false,
			contentType : false,
			processData : false,
			success : function(imgUrl) {
				$(context).summernote('editor.insertImage', imgUrl);
			}
		});
	}

	$(".custom-file-input").on(
			"change",
			function() {
				var fileName = $(this).val().split("\\").pop();
				$(this).siblings(".custom-file-label").addClass("selected")
						.html(fileName);
			});
</script>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
