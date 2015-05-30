<%-- Created by rayn on 05/09 2015 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../template/header.jsp"%>
<link rel="stylesheet" href="<c:url value='/static/css/main-page.css' />" />
</head>
<body>
<%@ include file="../template/navbar.jsp" %>
<div class="container">
  <div class="row">
    <div id="curPaper" class="col-md-3 col-xs-6 sidebar">
      <div class="thumbnail block" style="margin: auto">
        <div class="caption">
          <h2 class="subjectName">${paper.subjectName}</h2>
          <table class="table">
            <tr>
              <td><span class="label label-default">考试时间</span></td>
              <td><span class="testTime">${paper.testTime}</span>分钟</td>
            </tr>
            <tr>
              <td width="5%"><span class="label label-default">题目数量</span></td>
              <td class="singleCount">${paper.singleCount}</td>
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
        <p class="operation">当前试卷</p>
      </div>
    </div>
    <div class="col-md-9 col-xs-12 panel panel-default">
      <h2>
        管理试卷题目
        <button class="hideAdd btn btn-primary pull-right">只显示已添加题目  <span class="badge pro_count">${paper.problems.size()}</span></button>
        <button class="showAdd btn btn-primary pull-right" style="display: none;">显示所有题目</button>
      </h2>
      <hr>
      <div class="alert alert-danger upper-alert" style="display:none;">
        <p>当前试卷题目数量已达上限</p>
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
            <c:if test="${problem.subject == null or problem.subject == paper}">
            <c:if test="${problem.subject == null}">
            <div id="problem${problem.id}" class="col-md-6 notAdd">
            </c:if>
            <c:if test="${problem.subject == paper}">
            <div id="problem${problem.id}" class="col-md-6">
            </c:if>
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
                          <span class="label label-default">题目难度</span>
                          <span style="margin-left: 15px;">${weightMap[problem.weight]}</span>
                          <span class="sr-only weight">${problem.weight}</span>
                        </td>
                      </tr>
                    </table>
                  </div>
                </div>
                <p class="operation">
                  <a class="showExtra btn btn-default" role="button" name="${problem.id}">题目详情</a>
                  <c:if test="${problem.subject == paper}">
                    <a class="addThis btn btn-primary" role="button" name="${problem.id}" style="display: none">添加该题目</a>
                    <a class="delThis btn btn-danger" role="button" name="${problem.id}">移除</a>

                  </c:if>
                  <c:if test="${problem.subject == null}">
                    <a class="addThis btn btn-primary" role="button" name="${problem.id}">添加该题目</a>
                    <a class="delThis btn btn-danger" role="button" name="${problem.id}" style="display: none">移除</a>
                  </c:if>
                </p>
              </div>
            </div>
            </c:if>
          </c:forEach>
        </c:if>
      </div>
    </div>
  </div>
</div>
<%@ include file="../template/footer.jsp"%>
<script>
  function Masonry() {
    var $paper = $("#problemTable");
    $paper.masonry({
      itemSelector: '.col-md-6',
      isAnimated: true
    });
  }
  $(document).ready(function () {
    Masonry();
    $('.showExtra').click(function () {
      var id = $(this).attr('name');
      $('#problem' + id + ' .extra').slideToggle("fast", Masonry);
    });
    $('.showAdd').click(function() {
      $(this).hide();
      $('.hideAdd').show();
      $('.notAdd').fadeIn("fast", Masonry);
    });
    $('.hideAdd').click(function() {
      $(this).hide();
      $('.showAdd').show();
      $('.notAdd').fadeOut("fast", Masonry);
    });
  });
</script>
<script>
  $(document).ready(function () {
    var pro_count = $('.pro_count');
    $('.addThis').click(function() {
      var btn = $(this).button("loading");
      var pro_id = btn.attr('name');
      var url = '<c:url value="/admin/paper/${paper.id}/add/"/>' + pro_id;
      $.ajax({
        url: url,
        type: 'GET',
        success: function(ret) {
          if (ret.upper) {
            $(".upper-alert").fadeIn();
          } else if (ret.success) {
            btn.hide().parent().find(".delThis").show();
            $('#problem' + pro_id).removeClass("notAdd");
            pro_count.html(parseInt(pro_count.html()) + 1);
          }
        },
        error: function() {
        }
      });
      btn.button('reset');
    });
    $('.delThis').click(function() {
      var btn = $(this).button("loading");
      var pro_id = btn.attr('name');
      var url = '<c:url value="/admin/paper/del/"/>' + pro_id;
      $.ajax({
        url: url,
        type: 'GET',
        success: function(ret) {
          if (ret.success) {
            $(".upper-alert").fadeOut();
            btn.hide().parent().find(".addThis").show();
            $('#problem' + pro_id).addClass("notAdd");
            pro_count.html(parseInt(pro_count.html()) - 1);
          }
        },
        error: function() {
        }
      });
      btn.button('reset');
    });
  });
</script>
</body>
</html>
