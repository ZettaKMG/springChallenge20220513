<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>

<script>
	$(document).ready(function() {
		$("#edit-button1").click(function() {
			$("#input1").removeAttr("readonly");
			$("#textarea1").removeAttr("readonly");
			$("#modify-submit1").removeClass("d-none");
			$("#delete-submit1").removeClass("d-none");
			$("#addFileInputContainer1").removeClass("d-none");
			$(".removeFileCheckbox").removeClass("d-none");
		});
		
		$("#delete-submit1").click(function(e) {
			e.preventDefault();
			if (confirm("삭제하시겠습니까?")) {
				let form1 = $("#form1");
				let actionAttr = "${appRoot}/challenge/board/remove";
				form1.attr("action", actionAttr);
				form1.submit();
			}
		});		
		
		// 페이지 로딩 후 댓글 목록 가져오는 ajax 요청
		const listReply = function() {
		const data = {boardId : ${board.id}};
		$.ajax({
			url : "${appRoot}/challenge/reply/list",
			type : "get",
			data : data,
			success : function(list) {
				// console.log("댓글 가져 오기 성공");
				console.log(list);
					
				const replyListElement = $("#replyList1");
				replyListElement.empty();
				
				// 댓글 수 표시
				$("#numOfReply1").text(list.length);
					
				for (let i = 0; i < list.length; i++) {
					const replyElement = $("<li class='list-group-item' />");
					replyElement.html(`						
							<div id="replyDisplayContainer\${list[i].id }">
								<div class="fw-bold">
									<i class="fa-regular fa-comments"></i>
									\${list[i].prettyInserted}
									<span id="modifyButtonWrapper\${list[i].id }"></span>									
								</div>
								<span class="badge bg-light text-dark">
									<i class="fa-regular fa-user"></i>
									\${list[i].writerNickName}
								</span>
								<span id="replyContent\${list[i].id }"><span>
							</div>
	
							<div id="replyEditFormContainer\${list[i].id }"	style="display: none;">
								<form action="${appRoot }/reply/modify" method="post">
									<div class="input-group">
										<input type="hidden" name="boardId" value="${board.id }" />
										<input type="hidden" name="id" value="\${list[i].id }" />
										<input class="form-control" value="\${list[i].content }" type="text" name="content" required />
										<button data-reply-id="\${list[i].id}" class="reply-modify-submit btn btn-outline-secondary">
											<i class="fa-regular fa-comment-dots"></i>
										</button>
									</div>
								</form>
							</div>								
							`);
					
						replyListElement.append(replyElement);
						$("#replyContent" + list[i].id).text(list[i].content);
						
						// own이 true일 때만 수정,삭제 버튼 보이기
						if (list[i].own) {
							$("#modifyButtonWrapper" + list[i].id).html(`
								<span class="reply-edit-toggle-button badge bg-info text-dark" id="replyEditToggleButton\${list[i].id }" data-reply-id="\${list[i].id }">
									<i class="fa-solid fa-pen-to-square"></i>
								</span>
								<span class="reply-delete-button badge bg-danger" data-reply-id="\${list[i].id }">
									<i class="fa-solid fa-trash-can"></i>
								</span>
							`);
						}
						
					} // end of for
					
					$(".reply-modify-submit").click(function(e) {
						e.preventDefault();
						
						const id = $(this).attr("data-reply-id");
						const formElem = $("#replyEditFormContainer" + id).find("form");
						const data = {
							boardId : formElem.find("[name=boardId]").val(),
							id : formElem.find("[name=id]").val(),
							content : formElem.find("[name=content]").val()
						};
						
						$.ajax({
							url : "${appRoot}/challenge/reply/modify",
							type : "put",
							data : JSON.stringify(data),
							contentType : "application/json",
							success : function(data) {
								console.log("수정 성공");
								
								// 메세지 보여주기
								$("#replyMessage1").show().text(data).fadeOut(3000);
								
								// 댓글 refresh
								listReply();
							},
							error : function() {
								$("#replyMessage1").show().text("댓글을 수정할 수 없습니다.").fadeOut(3000);
								console.log("수정 실패");
							},
							complete : function() {
								console.log("수정 종료");
							}
						});
					});
					
					// reply-edit-toggle 버튼 클릭시 댓글 보여주는 div 숨기고, 수정 form 보여주기
					$(".reply-edit-toggle-button").click(function() {
						console.log("버튼클릭");
						const replyId = $(this).attr("data-reply-id");
						const displayDivId = "#replyDisplayContainer" + replyId;
						const editFormId = "#replyEditFormContainer" + replyId;
						console.log(replyId);
						console.log(displayDivId);
						console.log(editFormId);
						$(displayDivId).hide();
						$(editFormId).show();
					});
					
					// 삭제 버튼 클릭 이벤트 메소드 등록
					// reply-delete-button 클릭시
					$(".reply-delete-button").click(function() {
						const replyId = $(this).attr("data-reply-id");
						const message = "댓글을 삭제하시겠습니까?";
						if (confirm(message)) {
							// $("#replyDeleteInput1").val(replyId);
							// $("#replyDeleteForm1").submit();
							
							$.ajax({
								url : "${appRoot}/challenge/reply/delete/" + replyId,
								type : "delete",
								success : function(data) {
									// console.log(replyId + "댓글 삭제됨");
									// 댓글 list refresh
									listReply();
									// 메세지 출력
									$("#replyMessage1").show().text(data).fadeOut(3000);
								},
								error : function() {
									$("#replyMessage1").show().text("댓글을 삭제할 수 없습니다.").fadeOut(3000);
									console.log(replyId + "댓글 삭제 중 문제 발생됨");
								},
								complete : function() {
									console.log(replyId + "댓글 삭제 요청 끝");
								}
							});
						}
					});
				},
				error : function() {
					console.log("댓글 가져오기 실패");
				}
			});
		}
		
		// 댓글 가져오는 함수 실행
		listReply();
		
		// addReplySubmitButton1 버튼 클릭시 ajax 댓글 추가 요청
		$("#addReplySubmitButton1").click(function(e) {
			e.preventDefault();
			
			const data = $("#insertReplyForm1").serialize();			
			$.ajax({
				url : "${appRoot }/challenge/reply/write",
				type : "post",
				data : data,
				success : function(data) {
					// 새 댓글 등록되었다는 메시지 출력
					$("#replyMessage1").show().text(data).fadeOut(3000);
					
					// text input 초기화 
					$("#insertReplyContentInput1").val("");
					
					// 모든 댓글 가져오는 ajax 요청 
					// 댓글 가져오는 함수 실행
					listReply();
					
					// console.log(data);
				},
				error : function() {
					$("#replyMessage1").show().text("댓글을 작성할 수 없습니다.").fadeOut(3000);
					console.log("문제 발생");
				},
				complete : function() {
					console.log("요청 완료");
				}
			});
		});
	});
</script>

<style>
	.delete-checkbox:checked {
		background-color: #dc3545;
		border-color: #dc3545;
	}
</style>

<title>Challenge Get Page</title>
</head>
<body>	

	<my:navBar></my:navBar>
	
	<!-- .container>.row>.col>h1{글 본문} -->
	<div class="container">
		<div class="row">
			<div class="col">
				<h1>
					글 본문					
					<sec:authorize access="isAuthenticated()">
						<sec:authentication property="principal" var="principal"/>

						<c:if test="${principal.username == board.memberId }">
							<button id="edit-button1" class="btn btn-secondary">
								<i class="fa-solid fa-pen-to-square"></i>
							</button>
						</c:if>
					</sec:authorize>
				</h1>

				<c:if test="${not empty message }">
					<div class="alert alert-primary">${message }</div>
				</c:if>

				<form id="form1" action="${appRoot }/challenge/board/modify" method="post" enctype="multipart/form-data">
					<input type="hidden" name="id" value="${board.id }" />

					<div>
						<label class="form-label" for="input1">제목</label>
						<input class="form-control mb-3" type="text" name="title" required id="input1" value="${board.title }" readonly />
					</div>

					<div>
						<label class="form-label" for="textarea1">본문</label>
						<textarea class="form-control mb-3" name="body" id="textarea1" cols="30" rows="10" readonly>${board.body }</textarea>
					</div>
					
					<c:forEach items="${board.fileName }" var="file">
						<%
						String file = (String) pageContext.getAttribute("file");
						String encodedFileName = java.net.URLEncoder.encode(file, "utf-8");
						pageContext.setAttribute("encodedFileName", encodedFileName);
						%>
						<div class="row">
							<div class="col-lg-1 col-12 d-flex align-items-center">
								<div class="d-none removeFileCheckbox">
									<div class="form-check form-switch">
										<label class="form-check-label text-danger">
											<input class="form-check-input delete-checkbox" type="checkbox" name="removeFileList" value="${file }"/>
											<i class="fa-solid fa-trash-can"></i>
										</label>
									</div>
								</div>
							</div>
							<div class="col-lg-11 col-12">
								<div>
									<img class="img-fluid img-thumbnail" src="${imageUrl }/challenge/board/${board.id }/${encodedFileName }" alt="" />
								</div>
							</div>
						</div>
					</c:forEach>
					
					<div id="addFileInputContainer1" class="my-3 d-none">
						<label for="fileInput1" class="form-label"></label>
						파일 추가
						<input id="fileInput1" class="form-control mb-3" type="file" accept="image/*" multiple="multiple" name="addFileList" />
					</div>
					
					<div>
						<label for="input3" class="form-label">작성자</label>
						<input id="input3" class="form-control mb-3" type="text" value="${board.writerNickName }" readonly />
					</div>

					<div>
						<label for="input2" class="form-label">작성일시</label>
						<input class="form-control mb-3" type="datetime-local"
							value="${board.inserted }" readonly />
					</div>

					<button id="modify-submit1" class="btn btn-primary d-none">수정</button>
					<button id="delete-submit1" class="btn btn-danger d-none">삭제</button>
				</form>

			</div>
		</div>
	</div>

	<%-- 댓글 추가 --%>
	<!-- .container.mt-3>.row>.col>form -->
	<div class="container mt-3">
		<div class="row">
			<div class="col">
				<form id="insertReplyForm1">
					<div class="input-group">
						<input type="hidden" name="boardId" value="${board.id }" />
						<input id="insertReplyContentInput1" class="form-control" type="text" name="content" required />
						<button id="addReplySubmitButton1" class="btn btn-outline-secondary">
							<i class="fa-solid fa-comment-dots"></i>
						</button>
					</div>
				</form>
			</div>
		</div>
		<div class="row">
			<div class="alert alert-primary" style="display:none; " id="replyMessage1"></div>
		</div>
	</div>

	<%-- 댓글 목록 --%>
	<!-- .container.mt-3>.row>.col -->
	<div class="container mt-3">
		<div class="row">
			<div class="col">
				<h3>댓글 <span id="numOfReply1"></span> 개</h3>

				<ul id="replyList1" class="list-group">
					<%-- 
					<c:forEach items="${replyList }" var="reply">
						<li class="list-group-item">
							<div id="replyDisplayContainer${reply.id }">
								<div class="fw-bold">
									<i class="fa-solid fa-comment"></i>
									${reply.prettyInserted}
									<span class="reply-edit-toggle-button badge bg-info text-dark"
										id="replyEditToggleButton${reply.id }"
										data-reply-id="${reply.id }">
										<i class="fa-solid fa-pen-to-square"></i>
									</span>
									<span class="reply-delete-button badge bg-danger"
										data-reply-id="${reply.id }">
										<i class="fa-solid fa-trash-can"></i>
									</span>
								</div>
								<c:out value="${reply.content }" />
							</div>
							<div id="replyEditFormContainer${reply.id }"
								style="display: none;">
								<form action="${appRoot }/reply/modify" method="post">
									<div class="input-group">
										<input type="hidden" name="boardId" value="${board.id }" />
										<input type="hidden" name="id" value="${reply.id }" />
										<input class="form-control" value="${reply.content }"
											type="text" name="content" required />
										<button class="btn btn-outline-secondary">
											<i class="fa-solid fa-comment-dots"></i>
										</button>
									</div>
								</form>
							</div>
						</li>
					</c:forEach>
					--%>
				</ul>
			</div>
		</div>
	</div>

	<%-- 댓글 삭제 --%>
	<div class="d-none">
		<form id="replyDeleteForm1" action="${appRoot }/reply/delete"
			method="post">
			<input id="replyDeleteInput1" type="text" name="id" />
			<input type="text" name="boardId" value="${board.id }" />
		</form>
	</div>

<!-- 
	<div class="container">
		<div class="mt-3">
			<my:navBar></my:navBar>
		</div>
	
	<hr />
	<h1>${board.id }번 게시물</h1>	
	<hr />	
	
	<form action="${appRoot }/challenge/board/modify" method="post">
	<input type="hidden" name="id" value="${board.id }" />
		
	제목 : <input type="text" name="title" value="${board.title }" /> <br />
	
	본문 : <textarea name="body" cols="50" rows="5">${board.body }</textarea> <br />
	
	작성일시 : <input type="datetime-local" value="${board.inserted }" readonly /> <br /> <br />
	
	<button type="submit" class="btn btn-outline-warning">수정</button>	
	</form>
	

	<form action="${removeLink }" method="post">
		<input type="hidden" name="id" value="${board.id }" />
		<button type="submit" class="btn btn-outline-danger">삭제</button>	
	</form>
	
	<hr />
		
	<h3>댓글</h3>
	
	
	
	<form action="${replyAddLink }" method="post">
		<input type="hidden" name="boardId" value="${board.id }" />
		<input type="text" name="content" size="50" />
		
		<button type="submit" class="btn btn-outline-primary">추가</button>
	</form>
	
	<hr />
	
	<div>
		<c:forEach items="${replyList }" var="reply">
			<div style="border: 1px solid black; margin-bottom: 3px;">						
				
				<form action="${replyModifyLink }" method="post">
					<input type="hidden" name="id" value="${reply.id }" />
					<input type="hidden" name="boardId" value="${board.id }" />
					<input type="text" name="content" value="${reply.content }" /> ${reply.inserted }				
					<button type="submit" class="btn btn-outline-warning">수정</button>
				</form>				
				
				
				<form action="${replyRemoveLink }" method="post">
					<input type="hidden" name="id" value="${reply.id }" />
					<input type="hidden" name="boardId" value="${board.id }" />
					<button type="submit" class="btn btn-outline-danger">삭제</button>
				</form>
			</div>
		</c:forEach>			
	</div>	
	</div>
 -->
	
</body>
</html>