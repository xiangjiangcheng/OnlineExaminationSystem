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
  <div class="page-header">
    <h1>选择试卷进行考试</h1>
  </div>
  <div id="paperTable" class="row flowTable">
    <c:if test="${empty paperList}">
      <div class="col-md-12 emptyList">
        <div class="well">
          <h3>暂无可以选择的考试</h3>
        </div>
      </div>
    </c:if>
    <c:if test="${not empty paperList}">
      <c:forEach items="${paperList}" var="paper" >
        <c:set var="enable" value="${paper.problems.size() >= paper.singleCount}"/>
        <div id="paper${paper.id}" class="col-md-4">
          <div class="thumbnail block">
            <div class="caption">
              <h3 class="subjectName">${paper.subjectName}</h3>
              <c:if test="${not enable}">
              <p><span class="label label-danger">题目不足，无法开始考试</span></p>
              </c:if>
              <table class="table">
                <tr>
                  <td width="5%"><span class="label label-default">题目数量</span></td>
                  <td><span>${paper.problems.size()}</span> / <span class="singleCount">${paper.singleCount}</span></td>
                </tr>
                <tr>
                  <td><span class="label label-default">考试时间</span></td>
                  <td><span class="testTime">${paper.testTime}</span> 分钟</td>
                </tr>
                <tr>
                  <td><span class="label label-default">试卷总分</span></td>
                  <td>${paper.singleScore * paper.singleCount}</td>
                </tr>
              </table>
              <div class="extra" style="display: none;">
                <table class="table">
                  <tr>
                    <td width="5%"><span class="label label-default">试卷描述</span></td>
                    <td class="description">${paper.description}</td>
                  </tr>
                </table>
              </div>
            </div>
            <p class="operation">
              <a class="showExtra btn btn-default" role="button" name="${paper.id}">详情</a>
              <c:if test="${enable}">
                <a class="btn btn-primary" role="button" href="<c:url value='/exam/${paper.id}' />">开始考试</a>
              </c:if>
              <c:if test="${not enable}">
                <a class="btn btn-primary disabled" role="button">开始考试</a>
              </c:if>
            </p>
          </div>
        </div>
      </c:forEach>
    </c:if>
  </div>
</div>
<%@ include file="template/footer.jsp"%>
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
</body>
</html>
