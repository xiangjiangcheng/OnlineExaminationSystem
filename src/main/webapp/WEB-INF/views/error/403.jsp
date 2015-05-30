<%-- Created by rayn on 05/22 2015 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../template/header.jsp"%>
<link rel="stylesheet" href="<c:url value='/static/css/login-screen.css' />" />
</head>
<body>
<%@ include file="../template/navbar.jsp" %>
<div class="container">
  <div class="row innner-wapper">
    <div id="header" class="col-sm-10">
      <p><span class="glyphicon glyphicon-info-sign small" aria-hidden="true"></span> HTTP 403 </p>
      <p>你的访问受限</p>
    </div>
  </div>
</div>
<script src="<c:url value='/static/scripts/jquery.min.js' />" ></script>
<script src="<c:url value='/static/scripts/bootstrap.min.js' />" ></script>
</body>
</html>