<%@page language="java" import="java.sql.*" contentType="text/html; charset=utf-8"%>
<%@page pageEncoding="utf-8"%>
<%@page import="java.io.*,java.util.*,org.apache.commons.io.*"%>
<%@page import="org.apache.commons.fileupload.*"%>
<%@page import="org.apache.commons.fileupload.disk.*"%>
<%@page import="org.apache.commons.fileupload.servlet.*"%>

<%!String msg; Statement stmt;Connection con;ResultSet rs;String sql;String file_name;%>
<%! String username;%>
<%

    username= (String)session.getAttribute("uusername");

%>

<%
	String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    String dbURL = "jdbc:sqlserver://172.18.93.179:1433; DatabaseName=Test";
	Class.forName(driverName);
	con = DriverManager.getConnection(dbURL,"Tom", "123456");
	stmt = con.createStatement();

	sql ="select * from Users where username = '"+username+"';";

    rs=stmt.executeQuery(sql);

    while(rs.next())
    {
    	file_name = rs.getString("file_name");
    }

%>

<!DOCTYPE html>
<html>
<meta charset="utf-8">


<head>
	<title>主页</title>
	<link rel="stylesheet" type="text/css" href="home.css">
	<script type="text/javascript" src="http://cdn.webfont.youziku.com/wwwroot/js/wf/youziku.api.min.js"></script>
	<script type="text/javascript">
		$youziku.load("body", "5ccc3fcb7d0544039ca5b8a560c39288", "PingFangSCM");
		/*$youziku.load("#id1,.class1,h1", "5ccc3fcb7d0544039ca5b8a560c39288", "PingFangSCM");*/
		/*．．．*/
		$youziku.draw();
	</script>

	<style>

		#tou_wrapper{
      display: inline-block;
			width: 30px;
			height: 30px;
			border-radius: 30px;
			box-shadow: 0 0 5px black;
		}
     #user_wrapper{
       border: 0px solid red;
       height: 30px;
       float: right;
       padding-bottom: 5px;
       position: fixed;
       right: 144px;
       top:10px;
       z-index: 101;
     }
		#tou_wrapper img{
      display: inline-block;
		  width: 30px;
		  height: 30px;
		  object-fit: cover;
		  border-radius: 30px;
		}
    #menu {
      position: fixed;
      left: 0;
      top: 0;
      z-index: 100;
    }
    #xiaobiaoti{
      color:#e7e0cf;
    }
    #wrapper{
      margin-top: 60px;
    }
    #user{
      display:block;
      float:right;
      color: black;
      height: 30px;
      margin: 0;
      margin-left: 35px;
      color: black;
      text-decoration: none;
      padding-top: 3px;
    }
    #quit{
      display: block;
      float: right;
      margin: 0;
      margin-left: 30px;
      color: black;
      height: 30px;
      width: 30px;
      padding-top: 3px;
    }
    #user_wrapper a{
      color: black;
      text-decoration: none;
      font-size: 14px;
      font-weight: bold;
      color: #333;
    }
   </style>
</head>

<body>

  <div id="user_wrapper">

    <div id="tou_wrapper"><a href='edit.jsp'> <img src="file/<%=file_name%>"></a>
    <%session.setAttribute("username2", username);%></a> </div>
    <div id="quit" ><a href="index.jsp">Quit</a></div>
    <div id="user"><a href="edit.jsp"><%=username%></a></div>
  </div>
	<div id="menu">
		<ul>
			<li id="choose"><a href="home.jsp" class="current">Home</a></li>
			<li id="choose"><a href="discover.jsp">Discover</a></li>
			<li id="choose"><a href="tell.jsp">Tell</a></li>
			<li id="choose"><a href="upload.jsp">Upload</a></li>
			<li id="choose"><a href="search.jsp">Search</a></li>
		</ul>
	</div>



	<div id="wrapper">
		<div id="header">
			<div id="site_title">
				<h1><a href="#"><span id="share">Share</span> <strong>Feelings & Data</strong><span id="about">About the world</span></a></h1>
			</div>
			<div id="slideMain">
				<div class="slides">
					<img class="slide" src="images/world1.jpg">
					<img class="slide" src="images/world1.jpg">
				</div>
			</div>
		</div>

		<div id="main">

			<div class="three_column margin_r35 vertical_divider">
				<h2 id="xiaobiaoti">Discover</h2>


				<div class="image_wrapper">
					<div class="tile">
						<div class="text">
							<a href="#"><img src="images/discover.jpg" alt="About" /></a>
							<h2 class="animate-text">发现全世界的感觉</h2>
						</div>
					</div>
				</div>
				<p id="small_tit">发现全世界的感觉</p>
				<p id="content">世界的每一个角落都在发生着瞬息万变的变化，或是万里晴空，或是狂风骤雨，或是秋风萧瑟，或是冰天雪地。</p>
				<p id="content">让我们一起探索这个宽广美妙的世界吧！</p>
				<div class="button float_r"><a href="discover.jsp">现在出发</a></div>

			</div>
			<div class="three_column margin_r35 vertical_divider">
				<h2 id="xiaobiaoti">Tell</h2>
				<div class="image_wrapper">
					<div class="tile">
						<div class="text">
							<a href="#"><img src="images/update.jpg" alt="Web Templates" /></a>
							<h2 class="animate-text">向全世界诉说您此刻的感受</h2>
						</div>
					</div>
				</div>
				<p id="small_tit">向全世界诉说您此刻的感受</p>
				<p id="content">在重要的瞬间，不管是喜悦感动，亦或是悲伤痛苦，人们记录下此时此刻此地此情此景，心中铭记。</p>
				<p id="content">您是否愿意探索，品味某一个重要的瞬间呢？</p>
				<p id="content">沟通是人与人之间交往的桥梁，我们随时随刻乐于与您沟通，倾听您内心的至真想法。人生得一知己足矣，希望我们就是您的知己。</p>
				<p id="content">大胆迈出这一步，加入我们吧！尽情同享此刻！</p>
				<div class="button float_r"><a href="tell.jsp">现在诉说</a></div>
			</div>

			<div class="three_column margin_r35 vertical_divider">
				<h2 id="xiaobiaoti">Upload</h2>
				<div class="image_wrapper">
					<div class="tile">
						<div class="text">
							<a href="#"><img src="images/tell.jpg" alt="Free Templates" /></a>
							<h2 class="animate-text">上传分享您的文件</h2>
						</div>
					</div>
				</div>
				<p id="small_tit">上传分享您的文件</p>
				<p id="content">我们搭建资源共享的平台，拥有极速上传，安全存储的特性，您所想的数据就在云端静候您的安排吩咐。</p>
				<li>音乐</li>
				<li>视频</li>
				<li>文档</li>
				<p></p>
				<p id="content">一切文件均可支持。</p>
				<div class="button float_r"><a href="upload.jsp">现在上传</a></div>



			</div>
			<div class="three_column">
				<h2 id="xiaobiaoti">Search</h2>
				<div class="image_wrapper">
					<div class="tile">
						<div class="text">
							<a href="#"><img src="images/search.jpg" alt="Web Templates" /></a>
							<h2 class="animate-text">搜索下载大家的文件</h2>
						</div>
					</div>
				</div>
				<p id="small_tit">搜索下载大家的文件</p>
				<p id="content">悦耳的音乐，精彩的电影，好玩的游戏，稀缺的素材，就在这里。</p>
				<p id="content">您可以想象到的，想象不到的，应有尽有。</p>
				<div class="button float_r"><a href="search.jsp">现在搜索</a></div>
				<div class="cleaner"></div>
			</div>
		</div>
		<div id="footer">Copyright © 2017&nbsp;东苑宾馆B717荣耀出品&nbsp;&nbsp;&nbsp;<span id=sTime><script>setInterval("document.all.sTime.innerText=new Date().toLocaleString()",1000)</script> </span></div>
	</div>
	<iframe id="music" frameborder="no" border="0" marginwidth="0" marginheight="0" width=280 height=86 src="http://music.163.com/outchain/player?type=2&id=1345032&auto=0&height=66"></iframe>

</body>

</html>
