<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
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



</body>
</html>