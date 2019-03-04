<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*,java.util.*,org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page language="java" import="java.sql.*,java.util.Random"%>

<%!String msg; Statement stmt;Connection con;ResultSet rs;String sql;String checknum;String code="";%>

<%
	 request.setCharacterEncoding("utf-8");
 	 msg = "";
    Random rnd= new Random();
    checknum="";
    for(int i = 0 ; i < 4 ; i++)
    {

        int n= rnd.nextInt(10);
        checknum = checknum +n;
    }

    code = "";
    code=code+checknum;

    String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    String dbURL = "jdbc:sqlserver://172.18.93.179:1433; DatabaseName=Test";
	Class.forName(driverName);
	con = DriverManager.getConnection(dbURL,"Tom", "123456");
	stmt = con.createStatement();
	if (request.getMethod().equalsIgnoreCase("post")){
  		String Name = request.getParameter("username").trim();
        String Password = request.getParameter("password").trim();
        String captcha = request.getParameter("captcha").trim();
        String op = request.getParameter("code").trim();


        sql ="select * from Users where username = '"+Name+"';";

        try
        {
        	rs=stmt.executeQuery(sql);
        	if(!rs.next())
        	{
        		%>
	   		   	   <script language="javascript"> //JavaScript脚本标注
                        alert("登录失败:该用户不存在～");//在页面上弹出上联
                   </script>
	   		   <%
        	}
            else
            {
            	String pass = rs.getString("password").trim();

	   		   if (Password.equals(pass)) {
	   		   	   if(captcha.equals(op))
	   		   	   {
								 	session.setAttribute("uusername", Name);
	   		   	   	   response.sendRedirect("home.jsp");

	   		   	   }
	   		   	   else
	   		   	   {

	   		   	   	%>
	   		   	   		<script language="javascript">
                           alert("登录失败:验证码错误～");
                        </script>
	   		   	   <%
	   		   	    }

	  		   }
	  		   else {

	  		      %>
	  		       <script language="javascript">
                      alert("登录失败:用户名或密码不正确～");
                  </script>
		   	      <%
		   	   }
            }
        }
        catch(Exception e){
           msg = e.getMessage();
           out.print(msg);
       }

	}
%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<title>登录</title>
	<meta name="description" content="">
	<meta name="keywords" content="">
	<link rel="stylesheet" href="font-awesome/css/font-awesome.css">
	<link rel="stylesheet" type="text/css" href="index.css">
	<script type="text/javascript" src="http://cdn.webfont.youziku.com/wwwroot/js/wf/youziku.api.min.js"></script>
	<script type="text/javascript">
		$youziku.load("body", "5ccc3fcb7d0544039ca5b8a560c39288", "PingFangSCM");
		/*$youziku.load("#id1,.class1,h1", "5ccc3fcb7d0544039ca5b8a560c39288", "PingFangSCM");*/
		/*．．．*/
		$youziku.draw();
	</script>
	<style>
	#windows{
		position:fixed;
		margin:0 auto;
		right:0;
		left:0;
	}
	</style>
</head>

<body>
	<section class="slider-contaner">
		<div id="windows" style="height:350px; width: 360px; padding:20px;padding-right: 20px; padding-left:20px;background-color:#ffffff; border-radius:4px; overflow-x: hidden;position: absolute;top:150px;z-index: 13;">
			<form method="post" action="index.jsp">
				<div style="text-align: center;font-size:35px;height: 50px;">用户登陆</div>
				<hr class="hr15" />
				<input name="username" type="text" placeholder="UserName" required="required" autofocus/>
				<hr class="hr15" />
				<input name="password" type="password" placeholder="Password" required="required">
				<hr class="hr15" />
				<div style="width=65%;">请输入图中验证码：</div>
				<hr class="hr15" />
				<div class="captcha">
					<input type="text" name="captcha" autocomplete="captcha" required="required">
					<div>
						<%out.print(checknum);%>
							<input type="hidden" value="<%=code%>" name="code">
					</div>
				</div>
				<hr style="height:20px;" class="hr15" />
				<div style="clear: both;"></div>
				<input type="submit" value="Login" style="width:360px;height: 36px;" />
				<hr class="hr15" />
				<div id="gozhuce" style="font-size:16px;"> 没有账号？点这里<a href="register.jsp">注册</a></div>
			</form>
		</div>

		<ul class="slider">
			<li class="slider-item slider-item1">
				<div id="wrapper"></div>
			</li>
			<li class="slider-item slider-item2">
				<div id="wrapper"></div>
			</li>
			<li class="slider-item slider-item3">
				<div id="wrapper"></div>
			</li>
			<li class="slider-item slider-item4">
				<div id="wrapper"></div>
			</li>
			<li class="slider-item slider-item5">
				<div id="wrapper"></div>
			</li>
		</ul>

	</section>
</body>

</html>
