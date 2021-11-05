<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"">
<title>Insert title here</title>
</head>
<body>

	<div id="nav">
		<%@ include file="../include/RecipeNav.jsp"%>
	</div>

	<form method="post">
		<label>작성자</label> <input type="text" name="MEMBERID" /><br /> <label>제목</label>
		<input type="text" name="RECIPENAME" /><br /> <label>조리시간</label> <input
			type="text" name="COOKINGTIME" /><br /> <label>양</label> <input
			type="text" name="PORTION" /><br /> <label>수준</label> <input
			type="text" name="RANKNO" /><br /> 
			<input type='text' name='recipeDetail[0].RECIPEDETAIL'>
			<input type='text' name='recipeDetail[0].PHOTO'> <br> <input type='text'
			name='recipeDetail[1].RECIPEDETAIL'><input type='text'
			name='recipeDetail[1].PHOTO'>
		<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

		<script>
			/*
			const add_textbox = () => {
			    const box = document.getElementById("box");
			    const newP = document.createElement('p');
			    newP.innerHTML = "<input type='text'name='recipeDetailNO' placeholder='레시피순서'><input type='text'name='recipeDetail[0]'> <input type='button' value='삭제' onclick='remove(this)'>";
			    box.appendChild(newP);
			}
			const remove = (obj) => {
			    document.getElementById('box').removeChild(obj.parentNode);
			}*/
		</script>

		<div id="box">
			<input type="button" value="추가" onclick="add_textbox()">
		</div>


		<button type="submit">작성</button>
	</form>

</body>
</html>