<%-- Created by rayn on 05/14 2015 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="template/header.jsp"%>
<link rel="stylesheet" href="<c:url value='/static/css/login-screen.css' />" />
</head>
<body>
<div class="container">
  <div class="row innner-wapper">
    <div id="header" class="col-md-6">
      <p><span class="glyphicon glyphicon-console small" aria-hidden="true"></span> Hello </p>
      <p>在线考试系统</p>
    </div>
    <div id="loginForm" class="mform col-md-6">
      <form class="form-horizontal col-md-12" method="post" action="<c:url value='/login' />">
        <div class="form-heading">
          <div class="title">用户登录</div>
          <a class="btn btn-link pull-right" id="toRegisterForm">
            注册 <span class="glyphicon glyphicon-circle-arrow-right" aria-hidden="true"></span>
          </a>
        </div>
        <div class="form-group">
          <div class="col-md-12">
            <input type="text" class="form-control inputUsername" name="username" placeholder="用户名" required="true">
          </div>
        </div>
        <div class="form-group">
          <div class="col-md-12">
            <input type="password" class="form-control inputPassword" name="password" placeholder="密码" required="true">
          </div>
        </div>
        <div class="form-group">
          <div class="col-md-12">
            <button type="submit" class="button button-primary button-rounded btn-block" id="toLogin">登录</button>
          </div>
        </div>
        <div class="form-group">
          <div class="col-md-6">
            <div class="checkbox">
              <label><input type="checkbox" name="remember-me" value="true"> 记住我</label>
            </div>
          </div>
        </div>
        <c:if test="${param.logout != null}">
          <div class="alert alert-info col-md-12" role="alert">
            <span class="glyphicon glyphicon-info-sign" aria-hidden="true"> </span>
            注销成功
          </div>
        </c:if>
        <c:if test="${param.login != null}">
          <div class="alert alert-info col-md-12" role="alert">
            <span class="glyphicon glyphicon-info-sign" aria-hidden="true"> </span>
            注册成功，请登录.
          </div>
        </c:if>
        <c:if test="${param.error != null}">
          <div class="alert alert-info col-md-12" role="alert">
            <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
            用户名或者密码不合法.
          </div>
        </c:if>
      </form>
    </div>
    <div id="registerForm" class="mform col-md-6" style="display: none">
      <form class="form-horizontal col-md-12" method="post" action="<c:url value='/register' />">
        <div class="form-heading">
          <div class="title">用户注册</div>
          <a class="btn btn-link pull-right" id="toLoginForm">
            登录 <span class="glyphicon glyphicon-circle-arrow-right" aria-hidden="true"></span>
          </a>
        </div>
        <div class="form-group">
          <div class="col-md-12">
            <input type="text" class="form-control inputUsername" name="username" placeholder="用户名" required="true">
          </div>
        </div>
        <div class="form-group">
          <div class="col-md-12">
            <input type="password" class="form-control inputPassword" name="password" placeholder="密码" required="true">
          </div>
        </div>
        <div class="form-group">
          <div class="col-md-12">
            <input type="password" class="form-control inputPassword2" name="password2" placeholder="重复密码" required="true">
          </div>
        </div>
        <div class="form-group">
          <div class="col-md-12">
            <input type="email" class="form-control inputEmail" name="email" placeholder="邮箱" required="true">
          </div>
        </div>
        <div class="form-group">
          <div class="col-md-12">
            <input type="text" class="form-control inputPhone" name="phone" placeholder="电话" required="true">
          </div>
        </div>
        <div class="form-group">
          <div class="col-md-12">
						<textarea rows="3" maxlength="128" class="form-control inputAddress"
                      name="address" placeholder="地址"></textarea>
          </div>
        </div>
        <div class="form-group">
          <div class="col-md-12">
            <button type="submit" class="button button-primary button-rounded btn-block" id="toRegister">注册</button>
          </div>
        </div>
        <c:if test="${exist != null}">
          <div class="alert alert-danger col-md-12" role="alert">
            <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
            用户名已存在.
          </div>
        </c:if>
        <c:if test="${reg_error == true}">
          <div class="alert alert-danger col-md-12" role="alert">
            <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
            注册信息有误，请仔细核对后再提交.
          </div>
        </c:if>
        <div class="alert alert-danger col-md-12 pwd-alert" role="alert" style="display: none;">
          <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
          确认密码输入不一致，请仔细核对后再提交.
        </div>
      </form>
    </div>
  </div>
</div>
<script src="<c:url value='/static/scripts/jquery.min.js' />" ></script>
<script src="<c:url value='/static/scripts/bootstrap.min.js' />" ></script>
<script>
  $(document).ready(function() {
    window.setTimeout(function() {
      $('.alert').fadeOut();
    }, 3000);
    $("#toRegisterForm").click(function() {
      $("#loginForm").hide();
      $("#registerForm").fadeIn();
    });
    $("#toLoginForm").click(function() {
      $("#registerForm").hide();
      $("#loginForm").fadeIn();
    });
    $("#toRegister").click(function() {
      var block = "#registerForm ";
      var pwd1 = $(block + ".inputPassword").val();
      var pwd2 = $(block + ".inputPassword2").val();
      if (pwd1 != pwd2) {
        $(block + ".inputPassword2").focus();
        $('.pwd-alert').fadeIn();
        window.setTimeout(function() {
          $('.pwd-alert').fadeOut();
        }, 3000);
        return false;
      }
    });
  });
</script>
<c:if test="${reg == true}">
<script>
  $(document).ready(function() {
    $("#loginForm").hide();
    $("#registerForm").show();
  });
</script>
</c:if>
</body>
</html>