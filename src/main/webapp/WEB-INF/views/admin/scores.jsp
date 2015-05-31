<%-- Created by rayn on 05/28 2015 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../template/header.jsp"%>
<link rel="stylesheet" href="<c:url value='/static/css/main-page.css' />" />
</head>
<body>
<%@ include file="../template/navbar.jsp" %>
<div class="container">
  <div class="page-header">
    <h1>成绩统计</h1>
  </div>
  <div id="scoreTable" class="row flowTable">
    <c:if test="${empty scoreList}">
      <div class="col-md-12 emptyList">
        <div class="well">
          <h3>暂无历史考试记录</h3>
        </div>
      </div>
    </c:if>
    <c:if test="${not empty scoreList}">
      <c:forEach items="${scoreList}" var="score" >
        <div id="score${score.id}" class="col-md-6">
          <div class="thumbnail block">
            <div class="caption">
              <h3 class="subjectName">${score.subject.subjectName}</h3>
              <table class="table">
                <tr class="strongRow">
                  <td width="5%"><span class="label label-default">考试学生</span></td>
                  <td><span class="yourName">${score.user.username}</span></td>
                </tr>
                <tr class="strongRow">
                  <td width="5%"><span class="label label-danger">你的得分</span></td>
                  <td><span class="yourScore">${score.score}</span></td>
                </tr>
                <tr class="strongRow">
                  <td><span class="label label-primary">考试时间</span></td>
                  <td><span class="endTime"><fmt:formatDate value="${score.endTime}" pattern="yyyy/MM/dd"/></span></td>
                </tr>
              </table>
              <div class="extra well well-sm" style="display: none;">
                <table class="table">
                  <tr>
                    <td width="5%"><span class="label label-default">考试时间</span></td>
                    <td width="45%"><span class="testTime">${score.subject.testTime}</span> 分钟</td>
                    <td width="5%"><span class="label label-default">试卷总分</span></td>
                    <td width="45%">${score.subject.singleCount * score.subject.singleScore}</td>
                  </tr>
                  <tr>
                    <td width="5%"><span class="label label-default">单选分值</span></td>
                    <td width="45%">${score.subject.singleCount}</td>
                    <td width="5%"><span class="label label-default">单选数目</span></td>
                    <td width="45%">${score.subject.singleCount}</td>
                  </tr>
                  <tr>
                    <td><span class="label label-default">试卷描述</span></td>
                    <td class="description" colspan="3">${score.subject.description}</td>
                  </tr>
                </table>
              </div>
            </div>
            <p class="operation">
              <a class="showExtra btn btn-default" role="button" name="${score.id}">试卷详情</a>
              <a class="toDelScore btn btn-danger" role="button" name="${score.id}"
                 data-toggle="modal" data-target="#otherModal">删除</a>
            </p>
          </div>
        </div>
      </c:forEach>
    </c:if>
  </div>
</div>
<div id="otherModal" class="modal fade" style="margin-top: 120px" role="dialog"
     aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <h3>是否确定删除选定成绩?</h3>
      </div>
      <div class="modal-footer">
        <button id="deleteScore" type="button" class="btn btn-danger">确认</button>
        <button type="button" class="btn btn-default closeIt" data-dismiss="modal">取消</button>
      </div>
    </div>
  </div>
</div>
<%@ include file="../template/footer.jsp"%>
<script>
  function Masonry() {
    var $paper = $("#scoreTable");
    $paper.masonry({
      itemSelector: '.col-md-6',
      isAnimated: true
    });
  }
  $(document).ready(function () {
    Masonry();
    $('.showExtra').click(function () {
      var id = $(this).attr('name');
      $('#score' + id + ' .extra').slideToggle('fast', Masonry);
    });
    $('.toDelScore').click(function() {
      $('#deleteScore').attr('name', $(this).attr('name'));
    });
    $('#deleteScore').click(function() {
      var score_id = $(this).attr('name');
      $.ajax({
        url: '<c:url value="/admin/score/del/"/>' + score_id,
        type: 'GET',
        success: function(ret) {
          if (ret.success) {
            $('.closeIt').click();
            $('#score' + score_id).fadeOut().remove();
          }
        },
        error: function() {}
      });
    });
  });
</script>
</body>
</html>
