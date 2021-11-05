<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

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

.pagination li{
  list-style: none;
  float: left; 
  padding: 3px; 
  border: 1px solid blue;
  margin:3px;  
}

.pagination li a{
  margin: 3px;
  text-decoration: none;  
}

</style>
</head>

<body>


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

	<h2>Ajax Test Page</h2>

	<div>
		<div>
		<input type='hidden' name='recipeno' id='recipeno' value='${RecipeRequest.recipeno}'>
		</div>
		<div>
			<input type='hidden' name='memberid' id='bno' value='${RecipeRequest.bno}'>
		</div>
		<div>
			memberid <input type='text' name='memberid' id='newMemberId' value='${RecipeRequest.memberid}'>
		</div>
		<div>
			Comments <textarea row='8' cols='50' type='text' name='comments' id='newComments'></textarea>
		</div>
		<button id="valuationAddBtn">ADD valuation</button>
	</div>



	<ul id="valuation">
	</ul>
	
	<ul class='pagination'>
	</ul>	


	<!-- jQuery 2.1.4 -->
	<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>

	<script>
	
		/* var recipeno = 123239; */
		var recipeno = 55;
		getPageList(1);

		function getAllList() {

			$
					.getJSON(
							"/valuation/all/" + recipeno,
							function(data) {

								//console.log(data.length);

								var str = "";

								$(data)
										.each(
												function() {
													str += "<li data-bno='"+this.bno+"' class='valuationLi'>"
															+ this.bno
															+ ":"
															+ this.comments
															+ "<button>MOD</button></li>";
												});

								$("#valuation").html(str);
							});
		}

		$("#valuationAddBtn").on("click", function() {
	
			alert("후기를 추가합니다.");
			
			var bno=55;
			var memberid = $("#newMemberId").val();
			var comments = $("#newComments").val();

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
					bno : bno,
					memberid : memberid,
					comments : comments
				}),
				success : function(result) {

					if (result == 'SUCCESS') {

						alert("등록 되었습니다.");
						getAllList();

					}
				}
			});
		});

		$("#valuation").on("click", ".valuationLi button", function() {

			var valuation = $(this).parent();

			var bno = valuation.attr("data-bno");
			var comments = valuation.text();

			$(".modal-title").html(bno);
			$("#comments").val(comments);
			$("#modDiv").show("slow");

		});

		$("#valuationDelBtn").on("click", function() {

			var bno = $(".modal-title").html();
			var comments = $("#comments").val();

			$.ajax({
				type : 'delete',
				url : '/valuation/' + bno,
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
		
		$("#valuationModBtn").on("click",function(){
			  
			  var bno = $(".modal-title").html();
			  var comments = $("#comments").val();
			  
			  $.ajax({
					type:'put',
					url:'/valuation/'+bno,
					headers: { 
					      "Content-Type": "application/json",
					      "X-HTTP-Method-Override": "PUT" },
					data:JSON.stringify({comments:comments}), 
					dataType:'text', 
					success:function(result){
						console.log("result: " + result);
						if(result == 'SUCCESS'){
							alert("수정 되었습니다.");
							 $("#modDiv").hide("slow");
							//getAllList();
							 getPageList(valuationPage);
						}
				}});
		});		
		
		function getPageList(page){
			
		  $.getJSON("/valuation/"+recipeno+"/"+page , function(data){
			  
			  console.log(data.list.length);
			  
			  var str ="";
			  
			  $(data.list).each(function(){
				  str+= "<li data-bno='"+this.bno+"' class='valuationLi'>" 
				  +this.bno+":"+ this.comments+
				  "<button>MOD</button></li>";
			  });
			  
			  $("#valuation").html(str);
			  
			  printPaging(data.pageMaker);
			  
		  });
	  }		
		
		  
		function printPaging(pageMaker){
			
			var str = "";
			
			if(pageMaker.prev){
				str += "<li><a href='"+(pageMaker.startPage-1)+"'> << </a></li>";
			}
			
			for(var i=pageMaker.startPage, len = pageMaker.endPage; i <= len; i++){				
					var strClass= pageMaker.cri.page == i?'class=active':'';
				  str += "<li "+strClass+"><a href='"+i+"'>"+i+"</a></li>";
			}
			
			if(pageMaker.next){
				str += "<li><a href='"+(pageMaker.endPage + 1)+"'> >> </a></li>";
			}
			$('.pagination').html(str);				
		}
		
		var valuationPage = 1;
		
		$(".pagination").on("click", "li a", function(event){
			
			event.preventDefault();
			
			valuationPage = $(this).attr("href");
			
			getPageList(valuationPage);
			
		});
		
		
	  		
	  		
	</script>

</body>
</html>

