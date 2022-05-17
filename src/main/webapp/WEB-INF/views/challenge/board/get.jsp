<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>

<title>Insert title here</title>
</head>
<body>
	<h1>${board.id }번 게시물</h1>
	
	<br />
	<hr />
	<br />
	
	<form action="${appRoot }/challenge/board/modify" method="post">
	<input type="hidden" name="id" value="${board.id }" />
	
	제목 : <input type="text" name="title" value="${board.title }" /> <br />
	
	본문 : <textarea name="body" cols="30" rows="10">${board.body }</textarea> <br />
	
	작성일시 : <input type="datetime-local" value="${board.inserted }" readonly /> <br />
	
	<button><i class="fa-solid fa-pen-to-square"></i></button>	
	</form>
	
	<c:url value="/challenge/board/remove" var="removeLink" />
	<form action="${removeLink }" method="post">
		<input type="hidden" name="id" value="${board.id }" />
		<button><i class="fa-regular fa-trash-can"></i></button>	
	</form>
	
	<br />
	<hr />
	<br />
	
	<h3>댓글</h3>
	
	<c:url value="/challenge/reply/add" var="replyAddLink" />
	
	<form action="${replyAddLink }" method="post">
		<input type="hidden" name="boardId" value="${board.id }" />
		댓글 : <input type="text" name="content" size="50" />
		
		<button><i class="fa-solid fa-pen-fancy"></i></button>
	</form>
	
	<br />
	<hr />
	<br />
	
	<div>
		<c:forEach items="${replyList }" var="reply">
			<div style="border: 1px solid black; margin-bottom: 3px;">
				${reply.inserted }	:						
				<c:url value="/challenge/reply/modify" var="replyModifyLink" />
				<form action="${replyModifyLink }" method="post">
					<input type="hidden" name="id" value="${reply.id }" />
					<input type="hidden" name="boardId" value="${board.id }" />
					<input type="text" name="content" value="${reply.content }" />
					<button><i class="fa-solid fa-pen-clip"></i></button>
				</form>
				
				<c:url value="/challenge/reply/remove" var="replyRemoveLink" />
				<form action="${replyRemoveLink }" method="post">
					<input type="hidden" name="id" value="${reply.id }" />
					<input type="hidden" name="boardId" value="${board.id }" />
					<button><i class="fa-solid fa-eraser"></i></button>
				</form>
			</div>
		</c:forEach>	
	</div>
</body>
</html>