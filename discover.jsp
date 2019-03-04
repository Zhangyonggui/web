<%@ page language="java" import="java.util.*,java.sql.*"
         contentType="text/html; charset=utf-8"
%>
<%!
    ResultSet rs;
    Connection con;
    Statement stmt;
    String sql="";
    String data="*";
	String country="*";
	String year="*";
	String month="*";
%>
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
	String msg ="";
	String connectString = "jdbc:sqlserver://localhost:1433; DatabaseName=Test";
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	con=DriverManager.getConnection(connectString,"Tom", "123456");
	stmt=con.createStatement();
	sql=String.format("select * from Db");
    rs = stmt.executeQuery(sql);

    if (request.getMethod().equalsIgnoreCase("post")){
	    data=Arrays.toString(request.getParameterValues("data"));
	    country = request.getParameter("country");
        year = request.getParameter("year");
	    month = request.getParameter("month");

		if(country.equals("*")){
			if(year.equals("*")){
				if(month.equals("*")){
					try{
							sql=String.format("select * from Db;");
                            rs = stmt.executeQuery(sql);
	                    }
	                catch (Exception e){
	                        msg = e.getMessage();
	                    }
				}
				else {
					try{
							sql=String.format("select * from Db where month = '"+month+"';");
                            rs = stmt.executeQuery(sql);
	                    }
	                catch (Exception e){
	                        msg = e.getMessage();
	                    }
				}
			}
			else {
				if(month.equals("*")){
					try{

							sql=String.format("select * from Db where year = '"+year+"';");
                            rs = stmt.executeQuery(sql);
	                    }
	                catch (Exception e){
	                        msg = e.getMessage();
	                    }
				}
				else {
					try{

							sql=String.format("select * from Db where year = '"+year+"' and month = '"+month+"';");
                            rs = stmt.executeQuery(sql);
	                    }
	                catch (Exception e){
	                        msg = e.getMessage();
	                    }
				}
			}
		}
		else {
		    if(year.equals("*")){
				if(month.equals("*")){
					try{

							sql=String.format("select * from Db where country = '"+country+"';");
                            rs = stmt.executeQuery(sql);
	                    }
	                catch (Exception e){
	                        msg = e.getMessage();
	                    }
				}
				else {
					try{

							sql=String.format("select * from Db where country = '"+country+"' and month = '"+month+"';");
                            rs = stmt.executeQuery(sql);
	                    }
	                catch (Exception e){
	                        msg = e.getMessage();
	                    }
				}
			}
			else {
				if(month.equals("*")){
					try{

							sql=String.format("select * from Db where country = '"+country+"' and year = '"+year+"';");
                            rs = stmt.executeQuery(sql);
	                    }
	                catch (Exception e){
	                        msg = e.getMessage();
	                    }
				}
				else {
					try{

							sql=String.format("select * from Db where country = '"+country+"' and month = '"+month+"' and year = '"+year+"';");
                            rs = stmt.executeQuery(sql);
	                    }
	                catch (Exception e){
	                        msg = e.getMessage();
	                    }
				}
			}
		}
    }
%>

<!DOCTYPE HTML>
<html>
<head>
  <link rel="stylesheet" type="text/css" href="discover.css">
<script type="text/javascript" src="http://cdn.webfont.youziku.com/wwwroot/js/wf/youziku.api.min.js"></script>
<script type="text/javascript">
   $youziku.load("body", "5ccc3fcb7d0544039ca5b8a560c39288", "PingFangSCM");
   /*$youziku.load("#id1,.class1,h1", "5ccc3fcb7d0544039ca5b8a560c39288", "PingFangSCM");*/
   /*．．．*/
   $youziku.draw();
</script>

<title>发现</title>
<style>
    body{
			background:linear-gradient(to bottom,rgb(166,164,156) 0%,rgb(207,205,195) 50%,rgb(235,232,221) 100%);
		}




		.nav{
		   width:1240px;
		   height:500px;
		   margin:0px auto;
		   background-image:url("images/navbeijing.jpg");
       box-shadow: #666 0px 0px 10px;
       text-shadow: 2px 1px 0 black;
		}
		.nav_inner{

		   width:1240px;
		   height:500px;
		   padding-top:50px;
		   margin:0px auto;

		   background-color:rgba(0,0,0,0.3);
		}
		.titleb{
		   font-size:30px;
		   width:800px;
		   height:100px;
		   margin:0px auto;
		   margin-bottom:40px;
		   margin-top:50px;
		   color:white;
		}
		.main{
			width:1240px;
			margin:0 auto;
			margin-top:60px;
      box-shadow: #666 0px 0px 10px;
		}

		.postlist{
		   color:white;
		}
		.tableback{
			padding:40px 0px;
			width:1240px;
			margin:0 auto;
			background-image:url("images/chaxunzhubeijing.jpg");
			background-repeat: repeat-y;
      box-shadow: #666 0px 0px 15px;
      text-shadow: 2px 1px 0 black;
	    }

        table {
            border-collapse: collapse;
            border: none;
            width: 1000px;
			margin:0 auto;
        }
        td,th {
			color:white;
            border: 1px solid grey;
            margin: 0 0 0 0;
            padding: 5px 5px 5px 5px;
        }
        a:link,a:visited {
            color: white;
        }
		#footer {
		  width: 1180px;
		  padding: 20px 30px;
		  text-align: center;
		  color: #26231c;
		  /*border: 2px solid red;*/
		  background: #757062 url(images/footer.png) top center no-repeat;
		}

		#footer a {
		  color: #26231c;
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
      box-shadow: #666 0px 0px 15px;
    }
    h1{
      position: relative;
      font-size:70px;
      margin: 0 auto;
      padding: 0;
      width: 650px;
      top:50px;
    }
    form{
      margin: 0 auto;
      width:470px;
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
      <li id="choose"><a href="discover.jsp"  class="current">Discover</a></li>
      <li id="choose"><a href="tell.jsp">Tell</a></li>
      <li id="choose"><a href="upload.jsp">Upload</a></li>
      <li id="choose"><a href="search.jsp">Search</a></li>
    </ul>
  </div>

	 <div class="main">
	  <div class="nav">
	  <div class="nav_inner">
	  <div class="titleb">
		<h1>Discover The World</h1>
	  </div>

	  <div class="postlist">
		  <form action="discover.jsp" method="post">
				输入查询：
				国家：
					<select name="country">
						<option value="*"<%=country.equals("*")?"selected":""%>>全部</option>
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
				时间：
					<select name="year">
						<option value="*"<%=year.equals("*")?"selected":""%>>全部</option>
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
						<option value="*"<%=month.equals("*")?"selected":""%>>全部</option>
						<option value="Jan"<%=month.equals("Jan")?"selected":""%>>一月</option>
						<option value="Feb"<%=month.equals("Feb")?"selected":""%>>二月</option>
						<option value="Mar"<%=month.equals("Mar")?"selected":""%>>三月</option>
						<option value="Apr"<%=month.equals("Apr")?"selected":""%>>四月</option>
						<option value="May"<%=month.equals("May")?"selected":""%>>五月</option>
						<option value="June"<%=month.equals("June")?"selected":""%>>六月</option>
						<option value="July"<%=month.equals("July")?"selected":""%>>七月</option>
						<option value="Aug"<%=month.equals("Aug")?"selected":""%>>八月</option>
						<option value="Sept"<%=month.equals("Sept")?"selected":""%>>九月</option>
						<option value="Oct"<%=month.equals("Oct")?"selected":""%>>十月</option>
						<option value="Nov"<%=month.equals("Nov")?"selected":""%>>十一月</option>
						<option value="Dec"<%=month.equals("Dec")?"selected":""%>>十二月</option>
					</select><br>
				项目：
					全选<input name="data" type="checkbox" value="*" <%=data.indexOf("*")>=0?"checked":""%>>
					温度<input name="data" type="checkbox" value="temp"<%=data.indexOf("temp")>=0?"checked":""%>>
					湿度<input name="data" type="checkbox" value="humi"<%=data.indexOf("humi")>=0?"checked":""%>>
					光照强度<input name="data" type="checkbox" value="illu"<%=data.indexOf("illu")>=0?"checked":""%>>
					空气质量<input name="data" type="checkbox" value="aircondition"<%=data.indexOf("aircondition")>=0?"checked":""%>>
					大气压强<input name="data" type="checkbox" value="atompre"<%=data.indexOf("atompre")>=0?"checked":""%>>
					风速<input name="data" type="checkbox" value="windspeed"<%=data.indexOf("windspeed")>=0?"checked":""%>>
				<br>
				<input type="submit" name="submit" value="查询"></input>
		  </form>  <br></br>
	  </div>
	  </div>
	  </div>
	  <div class="tableback">
	  <table>
	    <tr>
		    <td>数据ID</td>
		    <td>地点</td>
			<td>年份</td>
			<td>月份</td>
			<td>温度</td>
			<td>湿度</td>
			<td>光照强度</td>
			<td>空气质量</td>
			<td>大气压强</td>
			<td>风速</td>
		</tr>
		<%while(rs.next()){
		        StringBuilder table_id=new StringBuilder("");
		        StringBuilder table_country=new StringBuilder("");
				StringBuilder table_year=new StringBuilder("");
				StringBuilder table_month=new StringBuilder("");
				StringBuilder table_temp=new StringBuilder("");
				StringBuilder table_humi=new StringBuilder("");
				StringBuilder table_illu=new StringBuilder("");
				StringBuilder table_aircondition=new StringBuilder("");
				StringBuilder table_atompre=new StringBuilder("");
				StringBuilder table_windspeed=new StringBuilder("");

			    table_id.append(rs.getString("id"));
				table_country.append(rs.getString("country"));
			    table_year.append(rs.getString("year"));
				table_month.append(rs.getString("month"));
				table_temp.append(rs.getString("temp"));
				table_humi.append(rs.getString("humi"));
				table_illu.append(rs.getString("illu"));
				table_aircondition.append(rs.getString("aircondition"));
				table_atompre.append(rs.getString("atompre"));
				table_windspeed.append(rs.getString("windspeed"));%>

                <tr>
		        <td><%=table_id%></td>
			    <td><%=table_country%></td>
			    <td><%=table_year%></td>
				<td><%=table_month%></td>
				<td><%=table_temp%></td>
				<td><%=table_humi%></td>
				<td><%=table_illu%></td>
				<td><%=table_aircondition%></td>
				<td><%=table_atompre%></td>
				<td><%=table_windspeed%></td>
		        </tr>
	    <% }%>
		<%rs.close(); stmt.close(); con.close();%>
	  </table>
	  </div>
	  <div id="footer">Copyright © 2017&nbsp;东苑宾馆B717荣耀出品&nbsp;&nbsp;&nbsp;<span id=sTime><script>setInterval("document.all.sTime.innerText=new Date().toLocaleString()",1000)</script> </span></div>
	 </div>
</body>
</html>
