<%-- Created by rayn on 05/25 2015 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../template/header.jsp"%>
<link rel="stylesheet" href="<c:url value='/static/css/main-page.css' />" />
</head>
<body>
<%@ include file="../template/navbar.jsp" %>
<div class="container">
  <div class="page-header">
    <h1>学生管理</h1>
  </div>
  <div id="problemTable" class="row flowTable">
    <c:if test="${empty userSet}">
      <div class="col-md-12 emptyList">
        <div class="well">
          <h3>暂无学生信息存在</h3>
        </div>
      </div>
    </c:if>
    <c:if test="${not empty userSet}">
      <c:forEach items="${userSet}" var="user" >
        <div id="user${user.id}" class="col-md-4">
          <div class="thumbnail block">
            <div class="caption">
              <h1 class="username">
                <span class="glyphicon glyphicon-user" aria-hidden="true"></span> <b>${user.username}</b>
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
              <!--<a class="btn btn-primary" role="button" name="${user.id}">成绩查询</a>-->
              <a class="btn btn-danger toDeleteUser" role="button" name="${user.id}" data-toggle="modal" data-target="#otherModal">删除</a>
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
        <h3>是否确定删除选定用户?</h3>
      </div>
      <div class="modal-footer">
        <button id="deleteUser" type="button" class="btn btn-danger">确认</button>
        <button type="button" class="btn btn-default closeIt" data-dismiss="modal">取消</button>
      </div>
    </div>
  </div>
</div>
<%@ include file="../template/footer.jsp"%>
<script>
  function Masonry() {
    var $paper = $("#userTable");
    $paper.masonry({
      itemSelector: '.col-md-4',
      isAnimated: true
    });
  }
  $(document).ready(function () {
    Masonry();
    $('.toDeleteUser').click(function() {
      $('#deleteUser').attr('name', $(this).attr('name'));
    });
    $('#deleteUser').click(function() {
      var id =  $(this).attr('name');
      var url = '<c:url value="/admin/users/del/"/>' + id;
      $.ajax({
        url: url,
        type: 'GET',
        success: function(ret) {
          $('.closeIt').click();
          if (ret.success) {
            $('#user' + id).fadeOut(1000).remove();
            Masonry();
          }
        }
      });
    });
  });
</script>
</body>
</html>
