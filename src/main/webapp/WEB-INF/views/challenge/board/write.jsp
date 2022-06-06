<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"	referrerpolicy="no-referrer"></script>

<title>Challenge Write Page</title>
</head>
<body>
	<my:navBar></my:navBar>
	
	<!-- .container>.row>.col>h1{글 작성} -->
	<div class="container">
		<div class="row">
			<div class="col">
				<h1>게시글 쓰기</h1>
				
				<form action="${appRoot }/challenge/board/write" method="post" enctype="multipart/form-data">
					<div>
						<label class="form-label" for="input1">게시글 제목</label>
						<input class="form-control mb-3" type="text" name="title" required id="input1" />
					</div>
					
					<div>
						<label class="form-label" for="textarea1">게시글 본문 내용</label>
						<textarea class="form-control mb-3" name="body" id="textarea1" cols="30" rows="10"></textarea>
					</div>
					<div>
						<label for="fileInput1" class="form-label">
						첨부파일
						</label>
						<input class="form-control mb-3" multiple="multiple" type="file" name="file" accept="image/*"/>
					</div>
					
					<button class="btn btn-primary">게시글 등록</button>
				</form>
			</div>
		</div>
	</div>

	<!-- 
	<div class="container">
		<div class="mt-3">
		</div>

		<hr />
		<h1>게시글 작성하기</h1>
		<hr />

		<form action="${appRoot }/challenge/board/write" method="post">
			<div>
				<label for="input1" class="form-label">제목</label>
				<input class="form-control mb-3" type="text" name="title" required id="input1" />
			</div>
			<div>
				<label for="textarea1" class="form-label">본문</label>
				<textarea class="form-control mb-3" id="textarea1" name="body" cols="30" rows="10"></textarea>
			</div>
			<div>
				<label for="fileInput1" class="form-label">파일 첨부</label>
				<input class="form-control mb-3" type="file" name="file" multiple="multiple" accept="image/*" />
			</div>
			<div class="d-grid gap-2 col-6 d-md-flex justify-content-md-end">
				<button type="submit" class="btn btn-outline-primary">게시글 등록</button>
			</div>
		</form>
	</div>
	 -->

</body>
</html>