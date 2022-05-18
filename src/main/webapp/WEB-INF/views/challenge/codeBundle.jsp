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
<!-- PageNation tag -->
<!-- pagination 이전 버튼 부분 -->
<!-- 
	<c:choose>
		<c:when test="${pageInfo.left }">
			<li class="page-item disabled">
				<a href="/challenge/board?page=${pageInfo.left - 1 }">이전</a>
			</li>
		</c:when>
		<c:otherwise>
			<li class="page-item">
				<a href="/challenge/board?page=${pageInfo.left - 1 }">이전</a>
			</li>			
		</c:otherwise>
	</c:choose>
-->

<!-- pagination 다음 버튼 부분 -->
<!-- 
	<c:choose>
		<c:when test="${pageInfo.right }">
			<li class="page-item disabled">
				<a href="/challenge/board?page=${pageInfo.right + 1 }">다음</a>
			</li>
		</c:when>
		<c:otherwise>
			<li class="page-item">
				<a href="/challenge/board?page=${pageInfo.right + 1 }">다음</a>
			</li>			
		</c:otherwise>
	</c:choose>
-->

</body>
</html>