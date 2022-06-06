<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>

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
	<my:navBar path="list"></my:navBar>
	
	<div class="container">
		<div class="row">
			<div class="col">
				<h1>게시글 목록</h1>
				<c:if test="${not empty message }">
					<div class="alert alert-primary">
						${message }
					</div>
				</c:if>
				
				<!-- table.table>thead>tr>th*3^^tbody -->
				<table class="table">
					<thead>
						<tr>
							<th><i class="fa-solid fa-hashtag"> Post Order Number</i></th>
							<th>Post Title</th>
							<th><i class="fa-solid fa-pen-fancy"> Writer</i></th>
							<th><i class="fa-regular fa-calendar"> Date of Writing</i></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${boardList }" var="board">
							<tr>
								<td>${board.id }</td>
								<td>													
									<c:url value="challenge/board/get" var="getUrl">
										<c:param name="id" value="${board.id }"></c:param>
									</c:url>
									
									<a href="${getUrl }">
										<c:out value="${board.title }" />
									</a>
									
									<c:if test="${board.hasFile }">
										<span class="badge rounded-pill bg-light text-dark">
											<i class="fa-solid fa-file"></i>
										</span>
									</c:if>
									
									<c:if test="${board.numOfReply > 0 }">
										<span class="badge rounded-pill bg-light text-dark">
											<i class="fa-solid fa-comment-dots"></i>
											${board.numOfReply }
										</span>
									</c:if>									
								</td>
								<td>${board.writerNickName }</td>
								<td>${board.prettyInserted }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	<div class="mt-3">
			<my:pagination></my:pagination>
	</div>
	
	<!-- 
	<div class="container">
		<div class="mt-3">
		</div>

		<hr />
		<h1>게시글 목록</h1>
		<hr />
		
		<c:if test="${not empty message }">
			<div class="alert alert-primary">
				${message }
			</div>
		</c:if>

		<div class="table-responsive">
		<table class="table table-bordered table-sm">
			<thead>
				<tr>
					<th><i class="fa-solid fa-hashtag"> Post Order Number</i></th>
					<th>Post Title</th>
					<th><i class="fa-solid fa-pen-fancy"> Writer</i></th>
					<th><i class="fa-regular fa-calendar"> Date of Writing</i></th>
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
						<td></td>
						<td>${board.prettyInserted }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>		
	</div>
	 -->

</body>
</html>