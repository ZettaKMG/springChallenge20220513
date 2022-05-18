<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>

<title>Challenge Write Page</title>
</head>
<body>
	<nav class="navbar navbar-expand-lg" style="background-color: #e3f2fd;">
		<div class="container-fluid">
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav">
					<li class="nav-item">
					<c:url value="/challenge/board/list" var="listLink"></c:url>
					<a class="nav-link" href="${listLink }">게시글 목록</a>
					</li>					
				</ul>
			</div>
		</div>
	</nav>
	
	<hr />
	<h1>게시글 작성하기</h1>
	<hr />
	
	<c:url value="/challenge/board/write" var="writeLink" />
	
	<form action="${writeLink }" method="post">
		제목 : <input type="text" name="title" value="새 제목" /> <br /> <br />
		본문 : <textarea name="body" id="" cols="50" rows="5">새 본문</textarea> <br /> <br />
		<button type="button" class="btn btn-outline-primary">등록</button> <br />
	</form>
	
</body>
</html>