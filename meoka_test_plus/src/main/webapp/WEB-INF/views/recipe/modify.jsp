<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 수정</title>
</head>
<body>

<div id="nav">
 <%@ include file="../include/RecipeNav.jsp" %>
</div>

<form method="post">
<label>작성자</label>
<input type="text" name="MEMBERID"  value="${view.MEMBERID }" readonly/><br />

<label>제목</label>
<input type="text" name="RECIPENAME"  value="${view.RECIPENAME}" /><br />

<label>조리시간</label>
<input type="text" name="COOKINGTIME"  value="${view.COOKINGTIME}"/><br />

<label>양</label>
<input type="text"  name="PORTION"  value="${view.PORTION }" /><br />

<label>수준</label>
<input type="text" name="RANKNO"  value="${view.RANKNO }"/><br />

<div id = "recipedetailview">
<c:forEach items="${list}" var="RecipeDetailVO" varStatus="status">
<input type='hidden' value="${RecipeDetailVO.RECIPENO}" name="recipeDetail[${status.index}].RECIPENO">
<input type='text' value="${RecipeDetailVO.RECIPEDETAILNO}" name="recipeDetail[${status.index}].RECIPEDETAILNO"/> 
<input type='text' name="recipeDetail[${status.index}].RECIPEDETAIL" value="${RecipeDetailVO.RECIPEDETAIL}"/>
<input type='text' name="recipeDetail[${status.index}].PHOTO" value="00" style="display:none"/> <br>
</c:forEach>
</div> 

			<%-- <label>레시피 세부내용</label><br />
			<input type='text' name='recipeDetail[0].RECIPEDETAIL' value = "${list.RECIPEDETAIL}"/> 
			<label>사진 첨부</label><br />
			<input type='text' name='recipeDetail[0].PHOTO' value = "${list.PHOTO}"/> <br> 
			<input type='text'
			name='recipeDetail[1].RECIPEDETAIL'/>
			<input type='text'
			name='recipeDetail[1].PHOTO'/>
 --%>
<button type="submit">완료</button>
</form>

</body>
</html>