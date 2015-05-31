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
    <h1>
      题库管理
      <button class="toNewProblem btn btn-primary pull-right" data-toggle="modal" data-target="#ProblemModal">添加新题目</button>
    </h1>
  </div>
  <div id="problemTable" class="row flowTable">
    <c:if test="${empty problemList}">
      <div class="col-md-12 emptyList">
        <div class="well">
          <h3>暂无题目, 你可以点击上方 <span class="label label-primary">添加新题目</span> 来添加题目</h3>
        </div>
      </div>
    </c:if>
    <c:if test="${not empty problemList}">
      <c:forEach items="${problemList}" var="problem" >
        <div id="problem${problem.id}" class="col-md-4">
          <div class="thumbnail block problemBlock">
            <div class="caption">
              <h4 class="description">${problem.description}</h4>
              <div class="extra" style="display: none;">
                <table class="table">
                  <tr>
                    <td width="5%"><span class="label label-default">A</span></td>
                    <td class="chooseA">${problem.a}</td>
                  </tr>
                  <tr>
                    <td width="5%"><span class="label label-default">B</span></td>
                    <td class="chooseB">${problem.b}</td>
                  </tr>
                  <tr>
                    <td width="5%"><span class="label label-default">C</span></td>
                    <td class="chooseC">${problem.c}</td>
                  </tr>
                  <tr>
                    <td width="5%"><span class="label label-default">D</span></td>
                    <td class="chooseD">${problem.d}</td>
                  </tr>
                </table>
                <table class="table">
                  <tr>
                    <td width="50%">
                      <span class="label label-primary">正确答案</span>
                      <span style="margin-left: 15px;">${answerMap[problem.answer]}</span>
                      <span class="sr-only answer">${problem.answer}</span>
                    </td>
                    <td>
                      <span class="label label-default">难度</span>
                      <span style="margin-left: 15px;">${weightMap[problem.weight]}</span>
                      <span class="sr-only weight">${problem.weight}</span>
                    </td>
                  </tr>
                </table>
              </div>
            </div>
            <p class="operation">
              <a class="showExtra btn btn-default" role="button" name="${problem.id}">详情</a>
              <a class="toEditProblem btn btn-primary" role="button" data-toggle="modal" data-target="#ProblemModal" name="${problem.id}">编辑</a>
              <a class="toDeleteProblem btn btn-danger" role="button" data-toggle="modal" data-target="#otherModal" name="${problem.id}">删除</a>
            </p>
          </div>
        </div>
      </c:forEach>
    </c:if>
  </div>
</div>
<div id="ProblemModal" class="modal fade" style="margin-top: 30px" role="dialog"
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
              <label class="col-md-2 control-label" for="InputDescription">题目描述</label>
              <div class="col-md-10">
                <textarea rows="4" class="form-control" id="InputDescription" name="description" placeholder="题目描述" required="required"></textarea>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-2 control-label" for="InputChooseA">选项A</label>
              <div class="col-md-10">
                <input type="text" class="form-control" id="InputChooseA" name="A" placeholder="选项A" required="true">
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-2 control-label" for="InputChooseB">选项B</label>
              <div class="col-md-10">
                <input type="text" class="form-control" id="InputChooseB" name="B" placeholder="选项B" required="true">
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-2 control-label" for="InputChooseC">选项C</label>
              <div class="col-md-10">
                <input type="text" class="form-control" id="InputChooseC" name="C" placeholder="选项C" required="true">
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-2 control-label" for="InputChooseD">选项D</label>
              <div class="col-md-10">
                <input type="text" class="form-control" id="InputChooseD" name="D" placeholder="选项D" required="true">
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-2 control-label">正确答案</label>
              <div class="col-md-10 btn-group" data-toggle="buttons">
                <label class="btn btn-default">
                  <input type="radio" name="answer" id="answer1" value="0" autocomplete="off"> A
                </label>
                <label class="btn btn-default">
                  <input type="radio" name="answer" id="answer2" value="1" autocomplete="off"> B
                </label>
                <label class="btn btn-default">
                  <input type="radio" name="answer" id="answer3" value="2" autocomplete="off"> C
                </label>
                <label class="btn btn-default">
                  <input type="radio" name="answer" id="answer4" value="3" autocomplete="off"> D
                </label>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-2 control-label">题目难度</label>
              <div class="col-md-10 btn-group" data-toggle="buttons">
                <label class="btn btn-default">
                  <input type="radio" name="weight" id="weight1" value="0" autocomplete="off"> 简单
                </label>
                <label class="btn btn-default">
                  <input type="radio" name="weight" id="weight2" value="1" autocomplete="off"> 中等
                </label>
                <label class="btn btn-default">
                  <input type="radio" name="weight" id="weight3" value="2" autocomplete="off"> 难题
                </label>
              </div>
            </div>
            <p class="formError alert alert-warning" style="display: none;"></p>
          </div>
        </div>
        <div class="modal-footer">
          <button type="reset" class="btn btn-default resetForm">重置</button>
          <button type="button" id="newProblem" class="btn btn-primary" data-loading-text="提交中..." autocomplete="off">提交</button>
          <button type="button" id="editProblem" class="btn btn-primary" data-loading-text="提交中..." autocomplete="off">提交</button>
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
        <h3>是否确定删除选定题目?</h3>
      </div>
      <div class="modal-footer">
        <button id="deleteProblem" type="button" class="btn btn-danger">确认</button>
        <button type="button" class="btn btn-default closeIt" data-dismiss="modal">取消</button>
      </div>
    </div>
  </div>
</div>
<%@ include file="../template/footer.jsp"%>
<script>
  function Masonry() {
    var $paper = $("#problemTable");
    $paper.masonry({
      itemSelector: '.col-md-4',
      isAnimated: true
    });
  }
  $(document).ready(function () {
    Masonry();
    $('.showExtra').click(function () {
      var id = $(this).attr('name');
      $('#problem' + id + ' .extra').slideToggle('fast', Masonry);
    });
  });
</script>
<script>
  function getFormData() {
    var data = {
      description: $('#InputDescription').val(),
      a: $('#InputChooseA').val(),
      b: $('#InputChooseB').val(),
      c: $('#InputChooseC').val(),
      d: $('#InputChooseD').val(),
      answer: $('input:radio[name="answer"]:checked').val(),
      weight: $('input:radio[name="weight"]:checked').val()
    };
    return data;
  }
  $(document).ready(function() {
    $('.toNewProblem').click(function() {
      $(".modal-title").html("添加新题目");
      $(".resetForm").click();
      $('label.active').removeClass("active");
      $("#editProblem").hide();
      $("#newProblem").show();
      $("p.formError").fadeOut(1);
    });
    $('.toEditProblem').click(function() {
      $(".modal-title").html("编辑选定题目");
      $("#editProblem").show().attr('name', $(this).attr('name'));
      $("#newProblem").hide();
      $("p.formError").fadeOut(1);
      var item = "#problem" + $(this).attr('name') + " ";
      $("#InputDescription").val($(item + ".description").text());
      $("#InputChooseA").val($(item + ".chooseA").text());
      $("#InputChooseB").val($(item + ".chooseB").text());
      $("#InputChooseC").val($(item + ".chooseC").text());
      $("#InputChooseD").val($(item + ".chooseD").text());
      $("input:radio[name='answer'][value='" + $(item + '.answer').text() + "']").click();
      $("input:radio[name='weight'][value='" + $(item + '.weight').text() + "']").click();
    });
    $('.toDeleteProblem').click(function() {
      $('#deleteProblem').attr('name', $(this).attr('name'));
    });
    $('#newProblem').click(function() {
      var btn = $(this).button('loading');
      var url = '<c:url value="/admin/problem" />';
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
    $('#editProblem').click(function () {
      var btn = $(this).button('loading');
      var id = $(this).attr('name');
      var url = '<c:url value="/admin/problem/update/" />' + id;
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
    $("#deleteProblem").click(function () {
      var id = $(this).attr('name');
      $.ajax({
        url: '<c:url value="/admin/problem/delete/" />' + id,
        type: 'GET',
        success: function(result) {
          $('.closeIt').click();
          if (result.success) {
            $('#problem' + id).fadeOut(1000).remove();
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
