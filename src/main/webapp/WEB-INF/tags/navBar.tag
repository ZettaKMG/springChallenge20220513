<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ attribute name="path"%>

<%-- 링크 연결 모음 --%>
<c:url value="/challenge/board/list" var="listLink"></c:url>
<c:url value="/challenge/board/write" var="writeLink"></c:url>
<c:url value="/challenge/board/remove" var="removeLink"></c:url>
<c:url value="/challenge/reply/add" var="replyAddLink"></c:url>
<c:url value="/challenge/reply/modify" var="replyModifyLink"></c:url>
<c:url value="/challenge/reply/remove" var="replyRemoveLink"></c:url>
<c:url value="/challenge/member/signup" var="signupLink"></c:url>
<c:url value="/challenge/member/list" var="memberListLink"></c:url>
<c:url value="/challenge/member/login" var="loginLink"></c:url>
<c:url value="/challenge/logout" var="logoutLink"></c:url>
<c:url value="/challenge/member/initpw" var="initPasswordLink"></c:url>

<%-- 회원 정보 링크 --%>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
	<c:url value="/challenge/member/get" var="memberInfoLink">
		<c:param name="id" value="${principal.username }" />
	</c:url>
</sec:authorize>

<%-- NavBar 메뉴 --%>
<nav class="navbar navbar-expand-lg navbar-light bg-light mb-3">
  <div class="container">
    <a class="navbar-brand" href="${listLink }"><i class="fa-solid fa-house"></i></a>
    
    <!-- button.navbar-toggler>span.navbar-toggler-icon -->
    <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
    	<span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link ${path == 'list' ? 'active' : '' }" href="${listLink }">게시글 목록</a>
        </li>
        
        <sec:authorize access="isAuthenticated()">
	        <li class="nav-item">
	          <a class="nav-link ${path == 'write' ? 'active' : '' }" href="${writeLink }">게시글 쓰기</a>
	        </li>
        </sec:authorize>
        
        
        <!-- li.nav-item>a.nav-link{회원가입} -->
        <sec:authorize access="not isAuthenticated()">
	        <li class="nav-item">
	        	<a href="${signupLink }" class="nav-link ${path == 'signup' ? 'active' : '' }">회원가입</a>
	        </li>
        </sec:authorize>
        
        <sec:authorize access="isAuthenticated()">
        	<li class="nav-item">
        		<a href="${memberInfoLink }" class="nav-link ${path == 'memberInfo' ? 'active' : '' }">회원정보</a>
        	</li>
        </sec:authorize>
        
        <sec:authorize access="hasRole('ADMIN')">
	        <li class="nav-item">
	        	<a href="${memberListLink }" class="nav-link ${path == 'memberList' ? 'active' : '' }">회원목록</a>
	        </li>
	        <div class="nav-item">
	        	<a href="${initPasswordLink }" class="nav-link">암호초기화</a>
	        </div>
        </sec:authorize>
        
        <!-- li.nav-item>a.nav-link{로그인} -->
        
        <sec:authorize access="not isAuthenticated()">
	        <li class="nav-item">
	        	<a href="${loginLink }" class="nav-link">로그인</a>
	        </li>
        </sec:authorize>
        
        <sec:authorize access="isAuthenticated()">
	        <li class="nav-item">
	        	<button class="btn btn-link nav-link" type="submit" form="logoutForm1">로그아웃</button>
	        </li>
        </sec:authorize>
      </ul>
      
      <div class="d-none">
      	<form action="${logoutLink }" id="logoutForm1" method="post"></form>
      </div>
      
      <!-- form.d-flex>input.form-control.me-2[type=search]+button.btn.btn-outline-success -->
      
      <form action="${listLink }" class="d-flex">
      	<div class="input-group">
	      	<!-- select.form-select>option*3 -->
	      	<select name="type" id="" class="form-select" style="flex:0 0 100px;">
	      		<option value="all" ${param.type != 'title' && param.type != 'body' ? 'selected' : '' }>전체</option>
	      		<option value="title" ${param.type == 'title' ? 'selected' : '' }>제목</option>
	      		<option value="body" ${param.type == 'body' ? 'selected' : ''}>본문</option>
	      	</select>
	      
	      	<input type="search" class="form-control" name="keyword"/>
	      	<button class="btn btn-outline-success"><i class="fa-solid fa-magnifying-glass"></i></button>
      	</div>
      </form>
    </div>
  </div>
</nav>

<!-- 
<nav class="navbar navbar-expand-lg" style="background-color: #e3f2fd;">
	<div class="container-fluid">
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link" href="${listLink }">게시글 목록</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="${writeLink }">게시글 쓰기</a>
				</li>
			</ul>
		</div>
	</div>
</nav>
-->

