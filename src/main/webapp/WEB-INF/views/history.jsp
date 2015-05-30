<%-- Created by rayn on 05/28 2015 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="template/header.jsp"%>
<link rel="stylesheet" href="<c:url value='/static/css/main-page.css' />" />
</head>
<body>
<%@ include file="template/navbar.jsp" %>
<div class="container">
  <div class="row">
    <div class="col-md-4">
      <div class="thumbnail block pined">
        <div class="caption">
          <h1 class="username">
            <span class="glyphicon glyphicon-user" aria-hidden="true"></span> <b>${user.username}</b>
            <a class="btn btn-link pull-right toEditUser">
              <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> 编辑
            </a>
          </h1>
          <table class="table">
            <tr>
              <td width="5%"><span class="label label-default">邮箱</span></td>
              <td>${user.email}</td>
            </tr>
            <tr>
              <td width="5%"><span class="label label-default">电话</span></td>
              <td>${user.phone}</td>
            </tr>
            <tr>
              <td width="5%"><span class="label label-default">地址</span></td>
              <td>${user.address}</td>
            </tr>
          </table>
        </div>
        <p class="operation">
          <span >用户信息</span>
          <span class="afterExam" style="display: none;">考试结束</span>
          <a class="btn btn-primary onExam toSubmitExam" role="button" name="${paper.id}" style="display: none;"
             data-toggle="modal" data-target="#otherModal">提交试卷</a>
        </p>
      </div>
    </div>
    <div id="scoreBlock" class="col-md-8">
      <div class="page-header">
        <h2>你的历史成绩</h2>
      </div>
      <div id="scoreTable" class="row flowTable">
        <c:if test="${empty scoreSet}">
          <div class="col-md-12 emptyList">
            <div class="well">
              <h3>暂无历史考试记录</h3>
            </div>
          </div>
        </c:if>
        <c:if test="${not empty scoreSet}">
          <c:forEach items="${scoreSet}" var="score" >
            <div id="score${score.id}" class="col-md-12">
              <div class="thumbnail block">
                <div class="caption">
                  <h3 class="subjectName">${score.subject.subjectName}</h3>
                  <table class="table">
                    <tr class="scoreRow">
                      <td width="5%"><span class="label label-danger">你的得分</span></td>
                      <td><span class="yourScore">${score.score}</span></td>
                    </tr>
                    <tr class="timeRow">
                      <td><span class="label label-primary">考试时间</span></td>
                      <td><span class="endTime">${score.endTime}</span></td>
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
    <div id="userForm" class="col-md-8" style="display: none;">
      <div class="col-md-12">
        <div class="panel panel-default">
          <div class="panel-title">
            <h3 class="panel-heading">修改用户信息
              <button class='backScoreBlock btn btn-primary pull-right'>返回历史成绩</button>
            </h3>
          </div>
          <div class="panel-body">
            <from class="form-horizontal">
              <div class="form-group">
                <label class="col-md-2 control-label" for="InputUsername">用户名</label>
                <div class="col-md-8">
                  <input type="text" class="form-control" id="InputUsername" name="username" placeholder="用户名" required="required">
                </div>
              </div>
              <div class="form-group">
                <label class="col-md-2 control-label" for="InputPassword">密码</label>
                <div class="col-md-8">
                  <input type="text" class="form-control" id="InputPassword" name="password" placeholder="密码" required="required">
                </div>
              </div>
            </from>
          </div>
        </div>
      </div>
    </div>
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
<%@ include file="template/footer.jsp"%>
<script src="<c:url value='/static/scripts/jquery.pin.min.js' />"></script>
<script>
  $(document).ready(function () {
    $('.showExtra').click(function () {
      var id = $(this).attr('name');
      $('#score' + id + ' .extra').slideToggle('fast');
    });
    $('.toDelScore').click(function() {
      $('#deleteScore').attr('name', $(this).attr('name'));
    });
    $('.toEditUser').click(function() {
      $("#scoreBlock").hide();
      $("#userForm").fadeIn();
    });
    $(".backScoreBlock").click(function() {
      $("#userForm").hide();
      $("#scoreBlock").fadeIn();
    });
    $('#deleteScore').click(function() {
      var score_id = $(this).attr('name');
      $.ajax({
        url: '<c:url value="/score/del/"/>' + score_id,
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
