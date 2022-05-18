<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="path" %>

<nav aria-label="page navigation example">
	<ul class="pagenation justify-content-center">
		<c:forEach begin="${pageInfo.left }" end="${pageInfo.right }" var="pageNum">
			<c:url value="${path }" var="link">
				<c:param name="page" value="${pageNum }"></c:param>
			</c:url>
			
			<li class="page-item ${pageInfo.current == pageNum ? 'active' : '' }">
				<a href="${link }" class="page-link">${pageNum }</a>
			</li>
		</c:forEach>
	</ul>
</nav>