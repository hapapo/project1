<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/upload.js"></script>
 <style>
.fileDrop {
  width: 80%;
  height: 100px;
  border: 1px dotted gray;
  background-color: lightslategrey;
  margin: auto;
  
}
</style>

</head>
<body>

	<div id="nav">
		<%@ include file="../include/RecipeNav.jsp"%>
	</div>

<!-- 레시피 기능 -->

	<form method="post">
		<label>작성자</label> <input type="text" name="MEMBERID" /><br /> <label>제목</label>
		<input type="text" name="RECIPENAME" /><br /> <label>조리시간</label> <input
			type="text" name="COOKINGTIME" /><br /> <label>양</label> <input
			type="text" name="PORTION" /><br /> <label>수준</label> <input
			type="text" name="RANKNO" /><br /> 
			
<!-- 레시피 디테일 text 작성기능 -->
<div id="dynamicCheck">
   <input type="button" value="Create Element" onclick="createNewElement();"/>
</div>

<div id="newElementId">내 용</div>

<!--  파일 업로드 -->
<div class="form-group">
 			<input type="hidden" name='recipeDetail[0].PHOTO'>
			<label for="exampleInputEmail1">File DROP Here</label>
			<div class="fileDrop">
			</div>
			
		</div>
		<div class="mailbox-attachments clearfix uploadedList"></div>
		
<!-- 파일 업로드 기능 -->		

<script id="template" type="text/x-handlebars-template">
 <li>
  <span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
  <div class="mailbox-attachment-info">
	<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
	<a href="{{fullName}}" 
     class="btn btn-default btn-xs pull-right delbtn"><i class="fa fa-fw fa-remove"></i></a>
	</span>
  </div>
   </li>                
</script>    


<script>
	 
	 
var template = Handlebars.compile($("#template").html());

$(".fileDrop").on("dragenter dragover", function(event){
	
	event.preventDefault();
});



 $(".fileDrop").on("drop", function(event){
	event.preventDefault();
	
	var files = event.originalEvent.dataTransfer.files;
	
	var file = files[0];

	var formData = new FormData();
	
	formData.append("file", file);	
	
	var $this = $(this);
	$.ajax({
		  url: '/upload/uploadAjax',
		  data: formData,
		  dataType:'text',
		  processData: false,
		  contentType: false,
		  type: 'POST',
		  success: function(data){
			
			  var fileInfo = getFileInfo(data);
			  console.log(fileInfo);
			  
			  var html = template(fileInfo);
			  
			  //console.log(fileInfo.imgsrc);
			  $($this).parent().children(":first").attr("value", fileInfo.imgsrc);
			  $(".uploadedList").append(html);
		  }
		});	 
});


 

$(".uploadedList").on("click", "small", function(event){
	
		 var that = $(this);
	
	   $.ajax({
		   url:"/upload/deleteFile",
		   type:"post",
		   data: {fileName:$(this).attr("data-src")},
		   dataType:"text",
		   success:function(result){
			   if(result == 'deleted'){
				   that.parent("div").remove();
			   }
		   }
	   });
});
</script>

<!-- 세부내용 인풋박스 추가기능 -->
<script>

function createNewElement() {
    // First create a DIV element.
	var txtNewInputBox = document.createElement('div');

    // Then add the content (a new input box) of the element.
    						
	txtNewInputBox.innerHTML = " 조리 방법 <input type='text' name='RECIPEDETAIL'> <input type='button'id='detailRemove' value='삭제' onclick='removeDetail(this)'>";

    // Finally put it where it is supposed to appear.
	document.getElementById("newElementId").appendChild(txtNewInputBox);
}
function removeDetail(createNewElement){
	document.getElementById("newElementId").removeChild(createNewElement.parentNode);
}




<!--작성 눌렀을때 인덱스 -->
function test() {
		$('#newElementId').children().each(function(index, item)	{
			$(this).children(":first").attr("name", "recipeDetail[" + index + "].RECIPEDETAIL" );
			$(this).children(":last").attr("name", "recipeDetail[" + index + "].PHOTO" );
			})
		$('#newUtensilId').children().each(function(index, item)	{
			$(this).children(":first").attr("name", "utensil[" + index + "].utensilName" );
			})
		$('#newIngredientId').children().each(function(index, item)	{
			
			$(this).children(":eq(0)").attr("name", "ingredient[" + index + "].ingredientName" );
			$(this).children(":eq(1)").attr("name", "ingredient[" + index + "].amount" );
			$(this).children(":eq(2)").attr("name", "ingredient[" + index + "].required" );
		})
}
</script>

<!-- 도구 -->
<h2>사용도구 작성</h2>
<div id="newUtensilId">New inputbox goes here:</div>
<div id="dynamicCheck">
   <input type="button" value="Create Utensil" onclick="createNewUtensil();"/>
</div>
<script>
function createNewUtensil() {
    // First create a DIV element.
	var NewInputBox = document.createElement('div');

    // Then add the content (a new input box) of the element.
	NewInputBox.innerHTML = " 요리도구 <input type='text' name='utensilName'><input type='button' value='삭제'onclick='remove(this)'>";

    // Finally put it where it is supposed to appear.
	document.getElementById("newUtensilId").appendChild(NewInputBox);
}
function remove(createNewUtensil){
	document.getElementById("newUtensilId").removeChild(createNewUtensil.parentNode);
}
</script>		
<!-- 조리도구 끝 -->
<!-- 재료 시작-->
<h2>재료 작성</h2>

<div id="newIngredientId">New inputbox goes here:</div>
<div id="dynamicCheck">
   <input type="button" value="Create Ingredient" onclick="createNewIngredient();"/>
</div>
<script>
function createNewIngredient() {
	var NewInputBox = document.createElement('div');

	NewInputBox.innerHTML = " 재료이름 <input type='text' name='ingredientName'> 양 <input type='text' name='amount'> 필수여부 <input type='text' name='required'> <input type='button' value='삭제'onclick='removeIngredient(this)'>";
	
	document.getElementById("newIngredientId").appendChild(NewInputBox);
}

function removeIngredient(createNewIngredient){
	document.getElementById("newIngredientId").removeChild(createNewIngredient.parentNode);
}

</script>




		<button type="submit" onclick=test()> 작성 </button>
	</form>

</body>
</html>