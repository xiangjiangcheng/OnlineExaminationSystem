<%-- Created by rayn on 05/09 2015 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="template/header.jsp" %>
<link rel="stylesheet" href="<c:url value='/static/css/main-page.css' />"/>
</head>
<body>
<%@ include file="template/navbar.jsp" %>
<div class="container">
  <div class="row">
    <div class="col-md-4">
      <div class="thumbnail block pined">
        <div class="caption">
          <h2 class="subjectName">${paper.subjectName}</h2>
          <table class="table">
            <tr>
              <td width="5%"><span class="label label-default">单选分值</span></td>
              <td class="singleScore">${paper.singleScore}</td>
            </tr>
            <tr>
              <td width="5%"><span class="label label-default">题目数量</span></td>
              <td>${paper.singleCount}</td>
            </tr>
            <tr>
              <td width="5%"><span class="label label-default">试卷总分</span></td>
              <td>${paper.singleCount * paper.singleScore}</td>
            </tr>
            <tr class="beforeExam afterExam">
              <td width="5%"><span class="label label-default">考试时间</span></td>
              <td><span class="testTime">${paper.testTime}</span> 分钟</td>
            </tr>
            <tr class="onExam timerRow" style="display: none;">
              <td width="5%"><span class="label label-danger">倒计时</span></td>
              <td>
                <p class="timer-item">
                <strong id="hour_show">0时</strong>
                <strong id="minute_show">0分</strong>
                <strong id="second_show">0秒</strong>
                </p>
              </td>
            </tr>
            <tr class="afterExam scoreRow" style="display: none;">
              <td width="5%"><span class="label label-danger">你的得分</span></td>
              <td><span class="yourScore"> 0 </span></td>
            </tr>
          </table>
        </div>
        <p class="operation">
          <span class="beforeExam">当前试卷</span>
          <span class="afterExam" style="display: none;">考试结束</span>
          <a class="btn btn-primary onExam toSubmitExam" role="button" name="${paper.id}" style="display: none;"
             data-toggle="modal" data-target="#otherModal">提交试卷</a>
        </p>
      </div>
    </div>
    <div class="col-md-8 panel panel-default beforeExam">
      <h2 class="page-header">题目</h2>
      <div class="row flowTable">
        <div class="col-md-12">
          <div class="well">
            <h2>考试尚未开始，题目不可见</h2>
            <h2>点击以 <a class="btn btn-primary btn-lg beginExam" role="button">开始考试</a> </h2>
          </div>
        </div>
      </div>
    </div>
    <div id="examTable" class="col-md-8 panel panel-default" style="display:none;">
      <h2 class="page-header">题目</h2>
      <div id="problemTable" class="row flowTable">
        <c:forEach items="${problemList}" var="problem" varStatus="status">
          <div id="problem${status.count}" class="col-md-12 problem-item" title="${problem.id}">
            <div class="thumbnail block">
              <div class="caption">
                <p>
                  <span class="label label-primary index"> ${status.count} </span>
                  <b class="description">
                      ${problem.description}
                  </b>
                </p>
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
                <table class="table afterExam" style="display: none;">
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
              <div class="operation choose-items">
                <div class="btn-group radio-group onExam" data-toggle="buttons">
                  <label class="btn btn-primary">
                    <input type="radio" name="${problem.id}" autocomplete="off" value="0"> A
                  </label>
                  <label class="btn btn-primary">
                    <input type="radio" name="${problem.id}" autocomplete="off" value="1"> B
                  </label>
                  <label class="btn btn-primary">
                    <input type="radio" name="${problem.id}" autocomplete="off" value="2"> C
                  </label>
                  <label class="btn btn-primary">
                    <input type="radio" name="${problem.id}" autocomplete="off" value="3"> D
                  </label>
                </div>
                <span class="afterExam">
                  <span class="label label-primary">你的选择</span>
                  <span class="yourChoose"> 未选择 </span>
                  <span class="judgeOk glyphicon glyphicon-ok" aria-hidden="true"></span>
                  <span class="judgeWrong glyphicon glyphicon-remove" aria-hidden="true"></span>
                </span>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </div>
  </div>
</div>
<div id="otherModal" class="modal fade" style="margin-top: 120px" role="dialog"
     aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-body">
        <h3>考试尚未结束, 是否确定提交当前考试</h3>
        <p>系统将会为你自动批改试卷并返回成绩.</p>
      </div>
      <div class="modal-footer">
        <button id="submitExam" type="button" class="btn btn-danger">确认提交</button>
        <button type="button" class="btn btn-default closeModal" data-dismiss="modal">取消</button>
      </div>
    </div>
  </div>
</div>
<%@ include file="template/footer.jsp" %>
<script src="<c:url value='/static/scripts/jquery.pin.min.js' />"></script>
<script>
  function Pin() {
    $('.pined').pin({
      containerSelector: ".container",
      minWidth: 1000,
      padding: {top: 65, bottom: 15}
    });
  }
  function Timer(time) {
    window.setInterval(function() {
      var day = 0, hour = 0, minute = 0, second = 0;
      if (time > 0) {
        hour = Math.floor(time / (60 * 60)) - day * 24;
        minute = Math.floor(time / 60) - (day * 24 * 60) - (hour * 60);
        second = Math.floor(time) - (day * 24 * 60 * 60) - (hour * 60 * 60) - (minute * 60);
      } else if (time == 0) {
        endNotice();
      }
      if (minute <= 9) minute = '0' + minute;
      if (second <= 9) second = '0' + second;
      $('#hour_show').html(hour+'时');
      $('#minute_show').html('<s></s>'+minute+'分');
      $('#second_show').html('<s></s>'+second+'秒');
      time--;
    }, 1000);
  }
  function saveToDB(score) {
    var url = '<c:url value="/exam/${paper.id}/" />' + score;
    $.ajax({
      url: url,
      type: 'GET',
      success: function(ret) {
      },
      error: function () {
        alert("Error");
      }
    });
  }
  function beginExam() {
    $(window).bind('beforeunload',function(){ return '考试尚未结束，确定离开此页面吗？'; });
    $('.beforeExam').hide();
    $('.afterExam').hide();
    $('.onExam').show();
    Timer(parseInt($('.testTime').html()) * 60);
  }
  function endExam() {
    $('.onExam').hide();
    $('.afterExam').show();
    var okCount = 0;
    var singleScore = $('.singleScore').html();
    var answerMap = { '0': 'A', '1': 'B', '2': 'C', '3': 'D' };
    $('.problem-item').each(function() {
      var cur_id = $(this).attr('title');
      var choose = $(this).find('input:radio[name="' + cur_id + '"]:checked');
      if (choose.length > 0) {
        var yourChoose = choose.first().val();
        $(this).find('.yourChoose').first().html(answerMap[choose.first().val()]);
        if (choose.first().val() == $(this).find('span.answer').first().html()) {
          $(this).find('.judgeWrong').hide();
          okCount++;
        } else {
          $(this).find('.judgeOk').hide();
        }
      } else {
        $(this).find('.judgeOk').hide();
      }
    });
    var totalScore = okCount * singleScore;
    $('.yourScore').html(totalScore);
    saveToDB(totalScore);
    $(window).unbind('beforeunload');
  }
  function endNotice() {
    $('#otherModal h3').html("考试已结束, 将提交当前考试");
    $('.closeModal').hide();
    $('.toSubmitExam').click();
  }
  $(document).ready(function () {
    $('.onExam').hide();
    $('.afterExam').hide();
    $('.beforeExam').show();
    $('.beginExam').click(function(){
      beginExam();
      $('#examTable').fadeIn('slow', Pin);
    });
    $('#submitExam').click(function() {
      $('.closeModal').click();
      endExam();
    });

  });
</script>
</body>
</html>
