<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시물 조회</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<style>
#modDiv {
	width: 300px;
	height: 100px;
	background-color: gray;
	position: absolute;
	top: 50%;
	left: 50%;
	margin-top: -50px;
	margin-left: -150px;
	padding: 10px;
	z-index: 1000;
}

.pagination {
	width: 100%;
}

.pagination li {
	list-style: none;
	float: left;
	padding: 3px;
	border: 1px solid blue;
	margin: 3px;
}

.pagination li a {
	margin: 3px;
	text-decoration: none;
}
</style>
</head>
<body>

	<div id="nav">
		<%@ include file="../include/RecipeNav.jsp"%>
	</div>

	<h1>레시피 정보</h1>
	<label>작성자</label> ${view.MEMBERID }
	<br />

	<label>제목</label> ${view.RECIPENAME }
	<br />

	<label>조리시간</label> ${view.COOKINGTIME }
	<br />

	<label>양</label> ${view.PORTION }
	<br />

	<label>수준</label> ${view.RANKNO }
	<br />
	
		<!-- 도구 -->
	<h2>사용도구</h2><br>
	<div id="view">
		<c:forEach items="${getUtensilList}" var="UtensilVO">
		${UtensilVO.utensilName } <br>
		</c:forEach>
	</div>
	
	
	
	
	<!-- 재료 -->
	<h2>재료</h2>
	
	<tr>
	<th>재료이름</th>
	<th>재료종류</th>
	<th>유통기한</th>
	<th>효능</th>
	<th>재료가격</th>
	</tr>
	
	<div id="view">
		<c:forEach items="${getIngredientList}" var="IngredientVO">
		<td>${IngredientVO.ingredientName }</td>
		<td>${IngredientVO.ingredientType }</td>
		<td>${IngredientVO.bestBefore }</td>
		<td>${IngredientVO.efficacy }</td>
		<td>${IngredientVO.price }</td>
		</c:forEach>
	</div>

	<!-- recipedetail -->
	<h2>레시피 세부내용</h2>
	<div id="recipedetailview">
		<c:forEach items="${list }" var="RecipeDetailVO">
		${RecipeDetailVO.RECIPEDETAILNO},${RecipeDetailVO.RECIPEDETAIL} <br>
		<img src="${RecipeDetailVO.PHOTO}"/>
		</c:forEach>
		
	</div>
	<!-- <button type="submit">작성</button> -->
	<div>
		<a href="/recipe/modify?RECIPENO=${view.RECIPENO}">레시피 정보 수정</a>
	</div>
	<div>
		<a href="/recipe/delete?RECIPENO=${view.RECIPENO}">레시피 삭제</a>
	</div>


	 <div id='modDiv' style="display: none;">
		<div class='modal-title'></div>
		<div>
			<input type='text' id='comments'>
		</div>
		<div>
			<button type="button" id="valuationModBtn">Modify</button>
			<button type="button" id="valuationDelBtn">DELETE</button>
			<button type="button" id='closeBtn'>Close</button>
		</div>
	</div>

	<h2> 후 기 </h2>

	<div>
		<div>
			<input type='hidden' name='recipeno' id='recipeno'
				value='${RecipeRequest.recipeno}'>
			<input type='hidden' id='curRecipeno'>
			<input type='hidden' id='curMemberid'>
		</div>
		<div>
			memberid <input type='text' name='memberid' id='newMemberId'
				value='${RecipeRequest.memberid}'>
		</div>
		<div>
			Comments
			<textarea row='8' cols='50' type='text' name='comments'
				id='newComments'></textarea>
		</div>
		<button id="valuationAddBtn">완료</button>

<!-- 	<div class="row">
	
		<div class="col-md-12">

			<div class="box box-success">
				<div class="box-header">
					<h3 class="box-title">ADD NEW REPLY</h3>
				</div>
				<div class="box-body">
					<label for="exampleInputEmail1">Writer</label> <input
						class="form-control" type="text" placeholder="USER ID"
						id="newMemberId"> <label for="exampleInputEmail1">Reply
						Text</label> <input class="form-control" type="text"
						placeholder="REPLY TEXT" id="newComments">

				</div>
				/.box-body
				<div class="box-footer">
					<button type="button" class="btn btn-primary" id="valuationAddBtn">ADD
						REPLY</button>
				</div>
			</div>

<!-- 			The time line 
			<ul class="timeline">
				timeline time label
				<li class="time-label" id="repliesDiv"><span class="bg-green">
						Replies List </span></li>
			</ul>

			<div class='text-center'>
				<ul id="pagination" class="pagination pagination-sm no-margin ">

				</ul>
			</div>

		</div>
		
	</div>
	
 -->

<!--           Modal
<div id="modifyModal" class="modal modal-primary fade" role="dialog">
  <div class="modal-dialog">
    Modal content
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"></h4>
      </div>
      <div class="modal-body" data-bno>
        <p><input type="text" id="comments" class="form-control"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-info" id="valuationModBtn">Modify</button>
        <button type="button" class="btn btn-danger" id="valuationDelBtn">DELETE</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>      
	
	
	</div>  -->
 

	<ul id="valuation">
	</ul>

	<ul class='pagination'>
	</ul>


	<!-- jQuery 2.1.4 -->
	<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
	
	 
	 <!-- 
		<script id="template" type="text/x-handlebars-template">
		{{#each .}}
		<li class="replyLi" data-bno={{bno}}>
		<i class="fa fa-comments bg-blue"></i>
		 <div class="timeline-item" >
		  <span class="time">
		    <i class="fa fa-clock-o"></i>{{prettifyDate regdate}}
		  </span>
		  <h3 class="timeline-header"><strong>{{bno}}</strong> -{{memberid}}</h3>
		  <div class="timeline-body">{{comments}} </div>
		    <div class="timeline-footer">
		     <a class="btn btn-primary btn-xs" 
			    data-toggle="modal" data-target="#modifyModal">수 정 하 기</a>
		    </div>
		  </div>			
		</li>
		{{/each}}
		</script>
	-->
	
	

	<script>
		/* var recipeno = 123239; */
		/* var recipeno = 55; */

		var recipeno = ${view.RECIPENO};
		//var bno = $(".modal-title").html(); 
		var bno = $("#curRecipeno").val();
		 getPageList(1); 
		function getAllList() {$.getJSON("/valuation/all/" + recipeno,
							function(data) {

								//console.log(data.length);

								var str = "";

								$(data).each(
												function() {
													str += "<li data-memberid='"+this.memberid+"' data-bno='"+this.recipeno+"' class='valuationLi'>"
															+ this.memberid
															+ ":"
															+ this.comments
															+ "<button>수정</button></li>";
												});

								$("#valuation").html(str);
							});
		}


		
		$("#valuationAddBtn").on("click", function() {

			alert("후기를 추가합니다.");
			var replyerObj = $("#newMemberId");
			var replytextObj = $("#newComments");
			var replyer = replyerObj.val();
			var replytext = replytextObj.val();

			$.ajax({
				type : 'post',
				url : '/valuation',
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'text',
				data : JSON.stringify({
					recipeno : recipeno,
					memberid : replyer,
					comments : replytext
				}),
				success : function(result) {

					if (result == 'SUCCESS') {
						getPage("/valuation/" + recipeno + "/" + replyPage);
						alert("등록 되었습니다.");
						getAllList();

					}
				}
			});
		});

		$("#valuation").on("click", ".valuationLi button", function() {

			var valuation = $(this).parent();
			//레시피번호 bno
			var recipeno = valuation.attr("data-recipeno");
			var memberid = valuation.attr("data-memberid");
			//멤버id
			//var memberid = valuation.attr("data-memberid");
			var comments = valuation.text();
			$('#curMemberid').val(memberid);
			$('#curRecipeno').val(recipeno);

			$(".modal-title").html(bno);
			$("#curMemberid").val(memberid);
			$("#curRecipeno").val(bno);
			$("#comments").val(comments);
			$("#modDiv").show("slow");

		});

		$("#valuationDelBtn").on("click", function() {
			var valuation = $('#valuation').parent();
			var bno = $("#curRecipeno").val();
			var comments = $("#comments").val();
			//멤버id
			var memberid =$("#curMemberid").val();
			$.ajax({
				type : 'delete',
				url : '/valuation/delete?recipeno=' + bno + '&memberid=' + memberid,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "DELETE"
				},
				dataType : 'text',
				success : function(result) {
					console.log("result: " + result);
					if (result == 'SUCCESS') {
						alert("삭제 되었습니다.");
						$("#modDiv").hide("slow");
						getAllList();
					}
				}
			});
		});

		$("#closeBtn").on("click",function(){
			$("#modDiv").hide("slow");
		});
		
		
		$("#valuationModBtn").on("click", function() {
			
			var bno = $("#curRecipeno").val();
			//var bno = $(".modal-title").html();
			console.log(this);
			var comments = $("#comments").val();
			var memberid =$("#curMemberid").val();

			$.ajax({
				type : 'put',
				url : '/valuation/' + recipeno + '/' + memberid,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PUT"
				},
				data : JSON.stringify({
					comments : comments
				}),
				dataType : 'text',
				success : function(result) {
					console.log("result: " + result);
					if (result == 'SUCCESS') {
						alert("수정 되었습니다.");
						$("#modDiv").hide("slow");
						getAllList();
						getPageList(valuationPage);
					}
				}
			});
		});

		function getPageList(page) {
			$.getJSON("/valuation/" + recipeno + "/" + page,
							function(data) {

								console.log(data.list.length);

								var str = "";

								$(data.list).each(
												function() {
													str += "<li data-recipeno='" + this.recipeno + "' data-memberid='" + this.memberid + "' class='valuationLi'>" 
															 + this.memberid
															+ ":"
															+ this.comments 
															+ "<button>수정하기</button></li>";
												});

								$("#valuation").html(str);

								printPaging(data.pageMaker);

							});
		}

		function printPaging(pageMaker) {

			var str = "";

			if (pageMaker.prev) {
				str += "<li><a href='" + (pageMaker.startPage - 1)
						+ "'> << </a></li>";
			}

			for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
				var strClass = pageMaker.cri.page == i ? 'class=active' : '';
				str += "<li "+strClass+"><a href='"+i+"'>" + i + "</a></li>";
			}

			if (pageMaker.next) {
				str += "<li><a href='" + (pageMaker.endPage + 1)
						+ "'> >> </a></li>";
			}
			$('.pagination').html(str);
		}

		var valuationPage = 1;

		$(".pagination").on("click", "li a", function(event) {

			event.preventDefault();

			valuationPage = $(this).attr("href");

			getPageList(valuationPage);

		});
		
		$(".timeline").on("click", ".replyLi", function(event){
			var reply = $(this);
				$("#comments").val(reply.find('.timeline-body').text());
				$(".modal-title").html(reply.attr("data-bno"));	
		}); 
		
		/* 추가분 */
		
	 		Handlebars.registerHelper("prettifyDate", function(timeValue) {
				var dateObj = new Date(timeValue);
				var year = dateObj.getFullYear();
				var month = dateObj.getMonth() + 1;
				var date = dateObj.getDate();
				return year + "/" + month + "/" + date;
			}); 
			
			var printData = function(replyArr, target, templateObject) {

				//var template = Handlebars.compile(templateObject.html());

				//var html = template(replyArr);
				$(".valuationLi").remove();
				target.after(html);

			}
			

			var bno = ${view.RECIPENO};
			
			var replyPage = 1;

  			function getPage(pageInfo) {
			  //data = {"list":List<ValuationVO> , "pageMaker":} 
				
				$.getJSON(pageInfo, function(data) {
					printData(data.list, $("#repliesDiv"), $('#template'));
					printPaging(data.pageMaker, $(".pagination"));

					$("#modifyModal").modal('hide');

				});
			} 
	</script>


</body>
</html>