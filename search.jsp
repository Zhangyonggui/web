<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*,java.util.*,org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page language="java" import="java.sql.*"%>

<%!String msg; Statement stmt;Connection con;ResultSet rs;%>

<%! String country="";String year="";String month="";String sql="";%>
<%! String username;%>
<%
    username= (String)session.getAttribute("username");
%>
<%
  String img_src="";
	String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
  String dbURL = "jdbc:sqlserver://172.18.93.179:1433; DatabaseName=Test";
	Class.forName(driverName);
	con = DriverManager.getConnection(dbURL,"Tom", "123456");
	stmt = con.createStatement();

	sql ="select * from Users where username = '"+username+"';";

    rs=stmt.executeQuery(sql);

    while(rs.next())
    {
    	img_src = rs.getString("file_name");
    }

%>
<%
  request.setCharacterEncoding("utf-8");
  msg = "";


  Class.forName(driverName);
  con = DriverManager.getConnection(dbURL,"Tom", "123456");
  stmt = con.createStatement();

  String sql1 = "select * from Files;";
  rs=stmt.executeQuery(sql1);

  if (request.getMethod().equalsIgnoreCase("post")){
      country=request.getParameter("country");
      year=request.getParameter("year");
      month=request.getParameter("month");

      boolean flag1,flag2,flag3;

      if(country.equals("")) flag1=true;
      else              flag1=false;
      if(year.equals(""))    flag2=true;
      else              flag2=false;
      if(month.equals(""))    flag3=true;
      else              flag3=false;

      if(flag1==true&&flag2==true&&flag3==true)
      {
          sql = "select * from Files ;";
      }
      else if(flag1==true&&flag2==true&&flag3==false)
      {
          sql = "select * from Files where month = '"+month+"';";
      }
      else if(flag1==true&&flag2==false&&flag3==true)
      {
          sql = "select * from Files where year = '"+year+"';";
      }
      else if(flag1==false&&flag2==true&&flag3==true)
      {
          sql = "select * from Files where country = '"+country+"';";
      }
      else if(flag1==true&&flag2==false&&flag3==false)
      {
          sql = "select * from Files where month = '"+month+"' and year = '"+year+"';";
      }
      else if(flag1==false&&flag2==true&&flag3==false)
      {
          sql = "select * from Files where month = '"+month+"' and country = '"+country+"';";
      }
      else if(flag1==false&&flag2==false&&flag3==true)
      {
          sql = "select * from Files where country = '"+country+"' and year = '"+year+"';";
      }
      else if(flag1==false&&flag2==false&&flag3==false)
      {
          sql = "select * from Files where country = '"+country+"' and month = '"+month+"' and year = '"+year+"';";
      }

      try{
           rs=stmt.executeQuery(sql);
      }
      catch(Exception e){
           msg = e.getMessage();
      }

}

%>

<html>
<head>
<title>搜索</title>
<link rel="stylesheet" type="text/css" href="search.css">
  <script type="text/javascript" src="http://cdn.webfont.youziku.com/wwwroot/js/wf/youziku.api.min.js "></script>
  <script type="text/javascript">
    $youziku.load("body", "5ccc3fcb7d0544039ca5b8a560c39288", "PingFangSCM");
    /*$youziku.load("#id1,.class1,h1", "5ccc3fcb7d0544039ca5b8a560c39288", "PingFangSCM");*/
    /*．．．*/
    $youziku.draw();
  </script>
<style>
  a:link,a:visited{color:white;}
  #table{background-image:url("images/chaxunzhubeijing.jpg");background-repeat:repeat-y;width:1240px;margin:0px auto;padding:40px 0;}
  table{margin:0 auto;width:1050px;text-shadow: 2px 1px 0 black;}
  * {margin:0;padding:0;font-size:16px;}
  h1{text-align: center;font-size: 70px;color:white;position: relative;top:100px;}
  td{color:white;text-align: center;width: 120px;height:30px; overflow:hidden;white-space:nowrap; }
  span{color: white;}
  #nav{background-image:url("images/file.jpg");width:1240px;height:500px;margin:0 auto;margin-top: 60px;text-shadow: 2px 1px 0 black;}
  form{width:420px;margin:0 auto;margin-top: 200px;}
  #nav_inner{
       width:1240px;
       height:500px;
       padding-top:50px;
       margin:0px auto;

       background-color:rgba(0,0,0,0.3);
       z-index:10;
    }

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
    #footer{
      margin: 0 auto;
      box-shadow: #666 0px 0px 10px;
    }
    #nav{
      box-shadow: #666 0px 0px 10px;
    }
    #table{
      box-shadow: #666 0px 0px 10px;
    }
</style>
</head>
<body>

    <div id="user_wrapper">
      <div id="tou_wrapper"><a href='edit.jsp'> <img src="file/<%=img_src%>"></a>
      <%session.setAttribute("username2", username);%></a> </div>
      <div id="quit"><a href="index.jsp">Quit</a></div>
      <div id="user"><a href="edit.jsp"><%=username%></a></div>
    </div>

    <div id="menu">
      <ul>
        <li id="choose"><a href="home.jsp">Home</a></li>
        <li id="choose"><a href="discover.jsp">Discover</a></li>
        <li id="choose"><a href="tell.jsp">Tell</a></li>
        <li id="choose"><a href="upload.jsp">Upload</a></li>
        <li id="choose"><a href="search.jsp" class="current">Search</a></li>
      </ul>
    </div>

    <div id="nav">
    <div id="nav_inner">
        <div>
            <h1>Search The world</h1>
        </div>
        <form action="search.jsp" method="post">
        <span>国家：</span>
            <select name="country">
                <option value=""<%=country.equals("")?"selected":""%>>全部</option>
                <option value="AFG"<%=country.equals("AFG")?"selected":""%>>阿富汗</option>
                <option value="ALB"<%=country.equals("ALB")?"selected":""%>>阿尔巴尼亚</option>
                <option value="ALG"<%=country.equals("ALG")?"selected":""%>>阿尔及利亚</option>
                <option value="AND"<%=country.equals("AND")?"selected":""%>>安道尔</option>
                <option value="ANG"<%=country.equals("ANG")?"selected":""%>>安哥拉</option>
                <option value="ARG"<%=country.equals("ARG")?"selected":""%>>阿根廷</option>
                <option value="ARM"<%=country.equals("ARM")?"selected":""%>>亚美尼亚</option>
                <option value="AUS"<%=country.equals("AUS")?"selected":""%>>澳大利亚</option>
                <option value="AUT"<%=country.equals("AUT")?"selected":""%>>奥地利</option>
                <option value="AZE"<%=country.equals("AZE")?"selected":""%>>阿塞拜疆</option>

                <option value="BAH"<%=country.equals("BAH")?"selected":""%>>巴哈马</option>
                <option value="BAN"<%=country.equals("BAN")?"selected":""%>>孟加拉国</option>
                <option value="BEL"<%=country.equals("BEL")?"selected":""%>>比利时</option>
                <option value="BHU"<%=country.equals("BHU")?"selected":""%>>不丹</option>
                <option value="BLR"<%=country.equals("BLR")?"selected":""%>>白俄罗斯</option>
                <option value="BOL"<%=country.equals("BOL")?"selected":""%>>玻利维亚</option>
                <option value="BRA"<%=country.equals("BRA")?"selected":""%>>巴西</option>
                <option value="BRU"<%=country.equals("BRU")?"selected":""%>>文莱</option>

                <option value="CAN"<%=country.equals("CAN")?"selected":""%>>加拿大</option>
                <option value="CGO"<%=country.equals("CGO")?"selected":""%>>刚果</option>
                <option value="CHN"<%=country.equals("CHN")?"selected":""%>>中国</option>
                <option value="CUB"<%=country.equals("CUB")?"selected":""%>>克罗地亚</option>
                <option value="DEN"<%=country.equals("DEN")?"selected":""%>>丹麦</option>
            </select>
        <span>时间：</span>
            <select name="year">
                <option value=""<%=year.equals("")?"selected":""%>>全部</option>
                <option value="2017"<%=year.equals("2017")?"selected":""%>>2017年</option>
                <option value="2016"<%=year.equals("2016")?"selected":""%>>2016年</option>
                <option value="2015"<%=year.equals("2015")?"selected":""%>>2015年</option>
                <option value="2014"<%=year.equals("2014")?"selected":""%>>2014年</option>
                <option value="2013"<%=year.equals("2013")?"selected":""%>>2013年</option>
                <option value="2012"<%=year.equals("2012")?"selected":""%>>2012年</option>
                <option value="2011"<%=year.equals("2011")?"selected":""%>>2011年</option>
                <option value="2010"<%=year.equals("2010")?"selected":""%>>2010年</option>
                <option value="2009"<%=year.equals("2009")?"selected":""%>>2009年</option>
                <option value="2008"<%=year.equals("2008")?"selected":""%>>2008年</option>
                <option value="2007"<%=year.equals("2007")?"selected":""%>>2007年</option>
                <option value="2006"<%=year.equals("2006")?"selected":""%>>2006年</option>
            </select>
            <select name="month">
                <option value=""<%=month.equals("")?"selected":""%>>全部</option>
                <option value="1"<%=month.equals("1")?"selected":""%>>一月</option>
                <option value="2"<%=month.equals("2")?"selected":""%>>二月</option>
                <option value="3"<%=month.equals("3")?"selected":""%>>三月</option>
                <option value="4"<%=month.equals("4")?"selected":""%>>四月</option>
                <option value="5"<%=month.equals("5")?"selected":""%>>五月</option>
                <option value="6"<%=month.equals("6")?"selected":""%>>六月</option>
                <option value="7"<%=month.equals("7")?"selected":""%>>七月</option>
                <option value="8"<%=month.equals("8")?"selected":""%>>八月</option>
                <option value="9"<%=month.equals("9")?"selected":""%>>九月</option>
                <option value="10"<%=month.equals("10")?"selected":""%>>十月</option>
                <option value="11"<%=month.equals("11")?"selected":""%>>十一月</option>
                <option value="12"<%=month.equals("12")?"selected":""%>>十二月</option>
            </select>
            <input type="submit" name="sub" value="查询">
        </form>
      </div>
      </div>
      <div id="table">
        <table border="1" cellspacing="0">
            <tr>
                <td>文件ID</td>
                <td>上传者</td>
                <td>上传国家</td>
                <td>上传年份</td>
                <td>上传月份</td>
                <td>文件名</td>
                <td>文件类型</td>
                <td>查看/下载</td>
            </tr>
            <% while(rs.next())
            {
                StringBuilder table_id=new StringBuilder("");
                StringBuilder table_name=new StringBuilder("");
                StringBuilder table_country=new StringBuilder("");
                StringBuilder table_year=new StringBuilder("");
                StringBuilder table_month=new StringBuilder("");
                StringBuilder table_file=new StringBuilder("");
                StringBuilder table_type=new StringBuilder("");

                table_id.append(rs.getString("files_id"));
                table_name.append(rs.getString("name"));
                table_country.append(rs.getString("country"));
                table_year.append(rs.getString("year"));
                table_month.append(rs.getString("month"));
                table_file.append(rs.getString("file_name"));
                table_type.append(rs.getString("file_type"));
                %>
            <tr>
                <td><%=table_id%></td>
                <td><%=table_name%></td>
                <td><%=table_country%></td>
                <td><%=table_year%></td>
                <td><%=table_month%></td>
                <td><%=table_file%></td>
                <td><%=table_type%></td>
                <td><a href="file/<%=table_file%>"><%=table_file%></a></td>
           </tr>
      <%}%>
        </table>
    </div>
    <div id="footer" style="font-size:13px;">Copyright © 2017&nbsp;东苑宾馆B717荣耀出品&nbsp;&nbsp;&nbsp;<span id=sTime style="color:black;font-size:13px;" ><script>setInterval("document.all.sTime.innerText=new Date().toLocaleString()",1000)</script> </span></div>

</body>
</html>
