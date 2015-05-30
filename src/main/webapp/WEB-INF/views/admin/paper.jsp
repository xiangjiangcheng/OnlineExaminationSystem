<%-- Created by rayn on 05/25 2015 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../template/header.jsp"%>
<link rel="stylesheet" href="<c:url value='/static/css/main-page.css' />" />
</head>
<body>
<%@ include file="../template/navbar.jsp" %>
<div class="container">
  <div class="page-header">
    <h1>
      试卷管理
      <button class="toNewPaper btn btn-primary pull-right" data-toggle="modal" data-target="#PaperModal">添加新试卷</button>
    </h1>
  </div>
  <div id="paperTable" class="row flowTable">
    <c:if test="${empty paperList}">
      <div class="col-md-12 emptyList">
        <div class="well">
          <h3>暂无试卷, 你可以点击上方 <span class="label label-primary">添加新题目</span> 来添加题目</h3>
        </div>
      </div>
    </c:if>
    <c:if test="${not empty paperList}">
      <c:forEach items="${paperList}" var="paper" >
        <div id="paper${paper.id}" class="col-md-4">
          <div class="thumbnail block">
            <div class="caption">
              <h3 class="subjectName">${paper.subjectName}</h3>
              <div class="extra" style="display: none;">
                <table class="table">
                  <tr>
                    <td><span class="label label-default">考试时间</span></td>
                    <td><span class="testTime">${paper.testTime}</span>分钟</td>
                  </tr>
                  <tr>
                    <td width="5%"><span class="label label-default">题目数量</span></td>
                    <td><span>${paper.problems.size()}</span> / <span class="singleCount">${paper.singleCount}</span></td>
                  </tr>
                  <tr>
                    <td><span class="label label-default">试卷总分</span></td>
                    <td>${paper.singleScore * paper.singleCount}</td>
                    <span class="sr-only singleScore">${paper.singleScore}</span>
                  </tr>
                  <tr>
                    <td width="5%"><span class="label label-default">试卷描述</span></td>
                    <td class="description">${paper.description}</td>
                  </tr>
                </table>
              </div>
            </div>
            <p class="operation">
              <a class="showExtra btn btn-default" role="button" name="${paper.id}">详情</a>
              <a class="btn btn-default" role="button" href="<c:url value='/admin/paper/${paper.id}' />">管理题目</a>
              <a class="toEditPaper btn btn-primary" role="button" data-toggle="modal" data-target="#PaperModal" name="${paper.id}">编辑</a>
              <a class="toDeletePaper btn btn-danger" role="button" data-toggle="modal" data-target="#otherModal" name="${paper.id}">删除</a>
            </p>
          </div>
        </div>
      </c:forEach>
    </c:if>
  </div>
</div>
<div id="PaperModal" class="modal fade" style="margin-top: 30px" role="dialog"
     aria-labelledby="gridSystemModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="gridSystemModalLabel">添加新试卷</h4>
      </div>
      <form id="new-paper-form">
        <div class="modal-body">
          <div class="container-fluid form-horizontal">
            <div class="form-group">
              <label class="col-md-2 control-label" for="InputSubjectName">试卷名</label>
              <div class="col-md-10">
                <input type="text" class="form-control" id="InputSubjectName" name="subjectName" placeholder="试卷名" required="required">
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-2 control-label" for="InputTestTime">考试时间</label>
              <div class="col-md-10">
                <div class="input-group">
                  <input type="text" class="form-control" id="InputTestTime" name="testTime" placeholder="考试时间" required="true">
                  <div class="input-group-addon">分钟</div>
                </div>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-2 control-label" for="InputSingleScore">单选分值</label>
              <div class="col-md-10">
                <input type="text" class="form-control" id="InputSingleScore" name="singleScore" placeholder="单选分值" required="true">
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-2 control-label" for="InputSingleCount">单选数量</label>
              <div class="col-md-10">
                <input type="text" class="form-control" id="InputSingleCount" name="singleCount" placeholder="单选数量" required="true">
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-2 control-label" for="InputDescription">试卷描述</label>
              <div class="col-md-10">
                <textarea rows="5" class="form-control" id="InputDescription" name="description" placeholder="试卷描述" required="required"></textarea>
              </div>
            </div>
            <p class="formError alert alert-warning" style="display: none;"></p>
          </div>
        </div>
        <div class="modal-footer">
          <button type="reset" class="btn btn-default resetForm">重置</button>
          <button type="button" id="newPaper" class="btn btn-primary" data-loading-text="提交中..." autocomplete="off">提交</button>
          <button type="button" id="editPaper" class="btn btn-primary" data-loading-text="提交中..." autocomplete="off">提交</button>
        </div>
      </form>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<div id="otherModal" class="modal fade" style="margin-top: 120px" role="dialog"
     aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <h3>是否确定删除选定试卷?</h3>
      </div>
      <div class="modal-footer">
        <button id="deletePaper" type="button" class="btn btn-danger">确认</button>
        <button type="button" class="btn btn-default closeIt" data-dismiss="modal">取消</button>
      </div>
    </div>
  </div>
</div>
<%@ include file="../template/footer.jsp"%>
<script>
  function Masonry() {
    var $paper = $("#paperTable");
    $paper.masonry({
      itemSelector: '.col-md-4',
      isAnimated: true
    });
  }
  $(document).ready(function () {
    Masonry();
    $('.showExtra').click(function () {
      var id = $(this).attr('name');
      $('#paper' + id + ' .extra').slideToggle('fast', Masonry);
    });
  });
</script>
<script>
  function getFormData() {
    var data = {
      subjectName: $("#InputSubjectName").val(),
      testTime: $("#InputTestTime").val(),
      singleScore: $('#InputSingleScore').val(),
      singleCount: $('#InputSingleCount').val(),
      description: $('#InputDescription').val()
    };
    return data;
  }
  $(document).ready(function() {
    $('.toNewPaper').click(function() {
      $(".modal-title").html("添加新试卷");
      $(".resetForm").click();
      $("#editPaper").hide();
      $("#newPaper").show();
      $("p.formError").fadeOut(1);
    });
    $('.toEditPaper').click(function() {
      $(".modal-title").html("编辑选定试卷");
      $("#editPaper").show().attr('name', $(this).attr('name'));
      $("#newPaper").hide();
      $("p.formError").fadeOut(1);
      var item = "#paper" + $(this).attr('name') + " ";
      $("#InputSubjectName").val($(item + ".subjectName").text());
      $("#InputTestTime").val($(item + ".testTime").text());
      $("#InputSingleScore").val($(item + ".singleScore").text());
      $("#InputSingleCount").val($(item + ".singleCount").text());
      $("#InputDescription").val($(item + ".description").text());

    });
    $('.toDeletePaper').click(function() {
      $('#deletePaper').attr('name', $(this).attr('name'));
    });
    $('#newPaper').click(function() {
      var btn = $(this).button('loading');
      var url = '<c:url value="/admin/paper" />';
      var data = getFormData();
      $.ajax({
        url: url,
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function(result) {
          if (result.success) {
            location.reload();
          } else {
            $("p.formError").text("添加失败，请重新填写数据").fadeIn();
          }
        },
        error: function() {
          $("p.formError").text("添加失败，请重新填写数据").fadeIn();
        }
      });
      btn.button('reset');
    });
    $('#editPaper').click(function () {
      var btn = $(this).button('loading');
      var id = $(this).attr('name');
      var url = '<c:url value="/admin/paper/update/" />' + id;
      var data = getFormData();
      $.ajax({
        url: url,
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function (result) {
          $('.close').click();
          if (result.success) {
            location.reload();
          } else {
            $("p.formError").text("修改失败，请核对数据正确性后提交.").fadeIn();
          }
        },
        error: function () {
          $("p.formError").text("修改失败，请核对数据正确性后提交.").fadeIn();
        }
      });
      btn.button('reset');
    });
    $("#deletePaper").click(function () {
      var id = $(this).attr('name');
      $.ajax({
        url: '<c:url value="/admin/paper/delete/" />' + id,
        type: 'GET',
        success: function(result) {
          $('.closeIt').click();
          if (result.success) {
            $('#paper' + id).fadeOut(1000).remove();
            Masonry();
          }
        },
        error: function() { alert("Error"); }
      });
    });
  });
</script>
</body>
</html>
