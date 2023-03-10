<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri ="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="../resources/assets/css/project.css">
<script src="../resources/assets/js/vendor/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://kit.fontawesome.com/90a612e2ef.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<style>
#rangeGraph{
    height:10px;
    background:#e9e9ee;
}

#rangeGraph span{
    height:100%;
    width:0%;
    background:#29f0b4;
}
.qna {
	rap: wrap;
	flex-wrap: wrap;
	margin-right: auto;
}
.comment-one__single_{
    position: relative;
    border-bottom: 1px solid #e4e4ee;
    padding-bottom: 30px;
    margin-bottom: 30px;
}
</style>
<script type="text/javascript">
function project(pro_no) {
	location.href="/prodetail/info?pro_no="+pro_no;
}

function deleteMyReply(reply_no, reply_category) {
	
	if(reply_category == 3) {
		Swal.fire({
			title : '공지는 삭제할 수 없습니다!',
			icon : 'error',
			confirmButtonText : '확인',
			confirmButtonColor: '#A4AC85'
		})
		return false;
	}
	
	Swal.fire({
		title: '해당 글을 삭제하시겠습니까?',
		text: '글 삭제 후 복구는 불가합니다.',
		icon: 'info',
		showCancelButton: true,
		confirmButtonColor: '#A4AC85',
		cancelButtonColor: 'grey',
		confirmButtonText: '삭제',
		cancelButtonText: '취소'
	}).then((result) => {
		if (result.isConfirmed) {   
			$.ajax({
				async : true,
			    type:'post',
			    url:"/mypage/myReply",
			    data: {
			    	reply_no:reply_no,
				},
			    dataType : "text",
			    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			    success : function(resp) { 
			    	Swal.fire({
						icon : 'success',
						title : '삭제되었습니다.',
						confirmButtonText : '확인',
						confirmButtonColor: '#A4AC85'
					})
		    		setTimeout(function () {
		    		 	$.ajax({
							url:"/mypage/myReply",
							type:"get",
							datatype:"html",
							success:function(data){
								$("#myReply").html(data);
							}	
						});
		    		}, 2000);
			    },
			    error: function(jqXHR, textStatus, errorThrown) {
			        alert("ERROR : " + textStatus + " : " + errorThrown);
			    }        
			});
		} 
	}) 
}
</script>

<div class="comment-one mt-50" style="padding-left: 15em; padding-right: 15em;">
	<h3 class="comment-one__block-title" style="color: #414934;">${cnt } 개의 글</h3>
	<c:if test="${empty reply }">
	<div style=" display: flex; align-items: center;">
		<i class="fa-solid fa-circle-info fa-3x" style="color: #6F7B63;"></i>
		<h3 style="padding-left: 0.5em; color: #838694;">등록된 글이 없습니다.</h3>
	</div>
	</c:if>
	<c:forEach var="reply" items="${reply }">
		<c:choose>
			<c:when test="${empty reply.rereply_content }">
				<div class="comment-one__single_">
					<div class="comment-one__content">
						<div class="qna">
						<c:choose>
							<c:when test="${reply.reply_category == 0 }">
								<span class="myBtn2">문의글</span>
							</c:when>
							<c:when test="${reply.reply_category == 1 }">
								<span class="myBtn">응원글</span>
							</c:when>
							<c:when test="${reply.reply_category == 2 }">
								<span class="myBtn2">후기</span>
							</c:when>
							<c:when test="${reply.reply_category == 3 }">
								<span class="myBtn3">공지</span>
							</c:when>
						</c:choose>
						<span class="comment-one__date" style="color: #414934;"><fmt:formatDate value="${reply.reply_date }" pattern="yyyy-MM-dd"/></span>
						<span style="float: right;" onclick="deleteMyReply(${reply.reply_no },${reply.reply_category });">삭제ㅤ</span>
						</div>
						<p onclick="project(${reply.pro_no});">${reply.pro_title }</p>
						<p>${reply.reply_content }</p>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="comment-one__single_">
					<div class="comment-one__content">
						<div class="qna">
						<c:choose>
							<c:when test="${reply.reply_category == 0 }">
								<span class="myBtn2">문의글</span>
							</c:when>
							<c:when test="${reply.reply_category == 1 }">
								<span class="myBtn">응원글</span>
							</c:when>
							<c:when test="${reply.reply_category == 2 }">
								<span class="myBtn2">후기</span>
							</c:when>
							<c:when test="${reply.reply_category == 3 }">
								<span class="myBtn3">공지</span>
							</c:when>
						</c:choose>
						<span class="comment-one__date" style="color: #414934;"><fmt:formatDate value="${reply.reply_date }" pattern="yyyy-MM-dd"/></span>
						<span style="float: right;" onclick="deleteMyReply(${reply.reply_no },${reply.reply_category });">삭제ㅤ</span>
						</div>
						<p onclick="project(${reply.pro_no});">${reply.pro_title }</p>
						<p>${reply.reply_content }</p>
					</div>
				</div>
				<div style="padding-left: 3em;">
				<div class="comment-one__single_">
					<div class="comment-one__content">
						<div class="qna">
							<span class="myBtn4">답변</span>
						<span class="comment-one__date" style="color: #414934;"><fmt:formatDate value="${reply.reply_date }" pattern="yyyy-MM-dd"/></span>
						</div>
						<p>${reply.pro_title }</p>
						<p>${reply.rereply_content }</p>
					</div>
				</div>
				</div>
			</c:otherwise>
		</c:choose>
	</c:forEach>
</div>