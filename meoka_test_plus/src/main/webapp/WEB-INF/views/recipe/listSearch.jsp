<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
<meta charset="UTF-8">
<title>게시물 목록</title>
</head>
<body>

	<div id="nav">
		<%@ include file="../include/RecipeNav.jsp"%>
	</div>

	<table>
		<thead>
			<tr>
				<th>레시피번호</th>
				<th>레시피이름</th>
				<th>작성자</th>
				<th>음식번호</th>
				<th>작성일</th>
				<th>조리시간</th>
				<th>양</th>
				<th>수준</th>
			</tr>
		</thead>

		<tbody>

			<c:forEach items="${list}" var="list">
				<tr>
					<td>${list.RECIPENO}</td>
					<td><a href="/recipe/view?RECIPENO=${list.RECIPENO}">${list.RECIPENAME}</a>
					</td>
					<td>${list.MEMBERID}</td>
					<td>${list.FOODNO}</td>
					<td><fmt:formatDate value="${list.REGDATE}"
							pattern="yyyy-MM-dd" /></td>
					<td>${list.COOKINGTIME}</td>
					<td>${list.PORTION}</td>
					<td>${list.RANKNO}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<div class="search">
		<select name="searchType">
			<option value="n"
				<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>-----</option>
			<option value="t"
				<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
			<option value="c"
				<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>수준</option>
			<option value="w"
				<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
			<option value="tc"
				<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+수준</option>
		</select> <input type="text" name="keyword" id="keywordInput"
			value="${scri.keyword}" />

		<button id="searchBtn">검색</button>

		<script>
			$(function() {
				$('#searchBtn').click(
						function() {
							self.location = "listSearch"
									+ '${pageMaker.makeQuery(1)}'
									+ "&searchType="
									+ $("select option:selected").val()
									+ "&keyword="
									+ encodeURIComponent($('#keywordInput')
											.val());
						});
			});
		</script>
	</div>

	<div>
		<ul>
			<c:if test="${pageMaker.prev}">
				<li><a
					href="listPage${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
			</c:if>

			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}"
				var="idx">
				<li><a href="listPage${pageMaker.makeSearch(idx)}">${idx}</a></li>
			</c:forEach>

			<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				<li><a
					href="listPage${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
			</c:if>
		</ul>
	</div>



</body>
</html>