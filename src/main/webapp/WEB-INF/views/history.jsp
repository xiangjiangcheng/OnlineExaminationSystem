<%-- Created by rayn on 05/28 2015 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
            <span class="glyphicon glyphicon-user" aria-hidden="true"></span> <b class="Username">${user.username}</b>
            <a class="btn btn-link pull-right toEditUser">
              <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> 编辑
            </a>
          </h1>
          <table class="table">
            <tr>
              <td width="5%"><span class="label label-default">邮箱</span></td>
              <td class="email">${user.email}</td>
            </tr>
            <tr>
              <td width="5%"><span class="label label-default">电话</span></td>
              <td class="phone">${user.phone}</td>
            </tr>
            <tr>
              <td width="5%"><span class="label label-default">地址</span></td>
              <td class="address">${user.address}</td>
              <td class="password sr-only">${user.password}</td>
            </tr>
          </table>
        </div>
        <p class="operation"><span >用户信息</span></p>
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
                </p>
              </div>
            </div>
          </c:forEach>
        </c:if>
      </div>
    </div>
    <div id="userForm" class="col-md-8" style="display: none;margin-top: 10px;">
      <div class="col-md-12">
        <div class="panel panel-default">
          <div class="page-header" >
            <h2 class="text-center">修改用户信息
              <button class='backScoreBlock btn btn-default btn-sm pull-right'>
                <span class="glyphicon glyphicon-share-alt" aria-hidden="true"></span> 返回
              </button>
            </h2>
          </div>
          <div class="panel-body" style="padding-top: 30px">
            <form class="form-horizontal" method="post">
              <div class="form-group">
                <label class="col-md-2 control-label" for="InputUsername">用户名</label>
                <div class="col-md-8">
                  <input type="text" class="form-control" id="InputUsername" name="username" placeholder="用户名">
                </div>
              </div>
              <div class="form-group">
                <label class="col-md-2 control-label" for="InputOldPassword">旧密码</label>
                <div class="col-md-8">
                  <input type="password" class="form-control" id="InputOldPassword" name="oldPassword" placeholder="旧密码">
                </div>
              </div>
              <div class="form-group">
                <label class="col-md-2 control-label" for="InputPassword">新密码</label>
                <div class="col-md-8">
                  <input type="password" class="form-control" id="InputPassword" name="password" placeholder="新密码">
                </div>
              </div>
              <div class="form-group">
                <label class="col-md-2 control-label" for="InputEmail">邮箱</label>
                <div class="col-md-8">
                  <input type="email" class="form-control" id="InputEmail" name="email" placeholder="邮箱">
                </div>
              </div>
              <div class="form-group">
                <label class="col-md-2 control-label" for="InputPhone">电话</label>
                <div class="col-md-8">
                  <input type="text" class="form-control" id="InputPhone" name="phone" placeholder="电话">
                </div>
              </div>
              <div class="form-group">
                <label class="col-md-2 control-label" for="InputAddress">地址</label>
                <div class="col-md-8">
						      <textarea rows="5" maxlength="128" class="form-control" id="InputAddress"
                      name="address" placeholder="地址" ></textarea>
                </div>
              </div>
              <p class="formError alert alert-warning col-md-offset-2 col-md-8" style="display: none;"></p>
              <div class="form-group">
                <div class="col-md-offset-3 col-md-6">
                  <div class="col-md-6">
                    <button type="reset" class="btn btn-default btn-block" >重置</button>
                  </div>
                  <div class="col-md-6">
                    <button type="submit" class="btn btn-primary btn-block" id="editUser" name="${user.id}">提交</button>
                  </div>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<%@ include file="template/footer.jsp"%>
<script src="<c:url value='/static/scripts/jquery.pin.min.js' />"></script>
<script>
  function getFormData() {
    var data = {
      username: $('#InputUsername').val(),
      password: $('#InputPassword').val(),
      email: $('#InputEmail').val(),
      phone: $('#InputPhone').val(),
      address: $('#InputAddress').val()
    };
    return data;
  }
  $(document).ready(function () {
    $('.showExtra').click(function () {
      var id = $(this).attr('name');
      $('#score' + id + ' .extra').slideToggle('fast');
    });
    $('.toEditUser').click(function() {
      $("#scoreBlock").hide();
      $('#InputUsername').val($('.Username').html());
      $('#InputEmail').val($('.email').html());
      $('#InputPhone').val($('.phone').html());
      $('#InputAddress').val($('.address').html());
      $("#userForm").fadeIn();
    });
    $(".backScoreBlock").click(function() {
      $("#userForm").hide();
      $("#scoreBlock").fadeIn();
    });
    $('#editUser').click(function() {
      var id = $(this).attr('name');
      var url = '<c:url value="/user/edit/" />' + id;
      var data = getFormData();
      var $InputPwd = $('#InputOldPassword');
      var $InputNewPwd = $('#InputPassword');
      if ($InputPwd.val().length == 0) {
        $('.formError').html("请输入原密码进行验证后才能提交.").fadeIn();
        return false;
      }
      if ($InputPwd.val() != $('.password').html()) {
        $('.formError').html("原密码输入错误.").fadeIn();
        return false;
      }
      data.password = $InputPwd.val();
      if ($InputNewPwd.val().length > 0) {
        data.password = $InputNewPwd.val();
      }
      $.ajax({
        url: url,
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function(ret) {
          if (ret.success) {
            window.location.reload();
          } else {
            $('.formError').html("修改失败, 请核对填写数据的正确性.").fadeIn();
          }
        },
        error: function () {
          $('.formError').html("修改失败, 请核对填写数据的正确性.").fadeIn();
        }
      });
      return false;
    });
  });
</script>
</body>
</html>
