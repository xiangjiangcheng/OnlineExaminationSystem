<%-- Created by rayn on 05/22 2015 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../template/header.jsp"%>
<link rel="stylesheet" href="<c:url value='/static/css/main-page.css' />" />
</head>
<body>
<%@ include file="../template/navbar.jsp" %>
<div class="container">
  <div class="jumbotron">
    <h1>你的当前访问受限</h1>
  </div>
</div>
<script src="<c:url value='/static/scripts/jquery.min.js' />" ></script>
<script src="<c:url value='/static/scripts/bootstrap.min.js' />" ></script>
</body>
</html>