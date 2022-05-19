<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="custom" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>

<title>Challenge List Page</title>
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
					<li class="nav-item">
					<c:url value="/challenge/board/write" var="writeLink" />
					<a class="nav-link" href="${writeLink }">게시글 쓰기</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	
	<hr />	
	<h1>게시글 목록</h1>	
	<hr />
	
	<table class="table table-secondary table-striped">
		<thead>
			<tr>
				<th>id</th>
				<th>title</th>
				<th>inserted</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${boardList }" var="board">
				<tr>
					<td>${board.id }</td>
					<td>
					<c:url value="/challenge/board/${board.id }" var="link" />
					<a href="${link }">${board.title }</a>
					<c:if test="${board.numOfReply > 0 }">
						[${board.numOfReply }]
					</c:if>
					</td>
					<td>${board.inserted }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<div class="mt-3">
		<custom:Pagination path="list" />
	</div>
</body>
</html>