<%-- Created by rayn on 05/23 2015 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<nav class="navbar navbar-inverse navbar-fixed-top" >
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="<c:url value='/' />">在线考试系统</a>
    </div>
    <div id="navbar" class="collapse navbar-collapse">
      <ul class="nav navbar-nav">
        <sec:authorize access="hasRole('STU')">
          <li><a href="<c:url value='/home' />">考试</a></li>
          <li><a href="<c:url value='/history' />">历史成绩查询</a></li>
        </sec:authorize>
        <sec:authorize access="hasRole('ADMIN')">
          <li><a href="<c:url value='/admin/paper' />">试卷管理</a></li>
          <li><a href="<c:url value='/admin/problem' />">题库管理</a></li>
          <li><a href="<c:url value='/admin/student' />">学生管理</a></li>
          <li><a href="<c:url value='/admin/scores' />">成绩统计</a></li>
        </sec:authorize>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
            <span class="glyphicon glyphicon-user" aria-hidden="true" style="margin-right: 7px;"></span>
            <sec:authentication property="principal.username"/> <span class="caret"></span>
          </a>
          <ul class="dropdown-menu" role="menu">
            <sec:authorize access="hasRole('STU')">
            <li><a href="<c:url value='/history' />">个人主页</a></li>
            </sec:authorize>
            <sec:authorize access="hasRole('ADMIN')">
              <li><a href="<c:url value='/info' />">个人主页</a></li>
            </sec:authorize>
            <li class="divider"></li>
            <li><a href="<c:url value='/logout' />">注销</a></li>
          </ul>
        </li>
      </ul>
    </div><!--/.nav-collapse -->
  </div>
</nav>