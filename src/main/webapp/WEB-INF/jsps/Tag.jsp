<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>提示</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/websiteicon.ico" type="image/vnd.microsoft.icon">
    <style type="text/css">
        h3{
        	width: 90%;
          margin: 30px auto 0 auto;
          padding-left: 20px;
        	line-height: 60px;
        	border: 2px solid #ffc050;
          -webkit-border-radius: 10px;
          -moz-border-radius: 10px;
          border-radius: 10px;
          background-color: #e7ce60;
        	font-family: 'Microsoft Yahei';
        	font-size: 30px;
          color: #fff;
        }
    </style>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
    <script type="text/javascript">

        var totalSeconds = 5;

        window.setInterval(function(){
            totalSeconds--;
            if(totalSeconds == 0){
                window.location.href = "${pageContext.request.contextPath}/";
            }
            $("#countDown").html(totalSeconds+"秒后自动跳转");
        }, 1000);

    </script>

</head>
<body>
<h3>${error}${success}（<span id="countDown">5秒后自动跳转</span>）</h3>
</body>
</html>
