<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*, java.util.*,org.apache.commons.io.*"%> 
<%@ page import="org.apache.commons.fileupload.*"%> 
<%@ page import="org.apache.commons.fileupload.disk.*"%> 
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@page language="java" import="java.sql.*" %>

<%! 
    ResultSet rs;
    Connection con;
    Statement stmt;
    String sql ="";
	String msg ="";
	
	String uname = "";
	String country = "隐藏";
	String words;
	String time = "";
	String photo = "";
	String path ="";
	String ordertime;
	String placea;
	String img_src="";//yonghutouxiang
%>
<%
	int y,m,d,h,mi,s;      
	Calendar cal=Calendar.getInstance();      
	y=cal.get(Calendar.YEAR);      
	m=cal.get(Calendar.MONTH)+1;      
	d=cal.get(Calendar.DAY_OF_MONTH);      
	h=cal.get(Calendar.HOUR_OF_DAY);      
	mi=cal.get(Calendar.MINUTE);      
	s=cal.get(Calendar.SECOND);      
	time = String.format(y+"年"+m+"月"+d+"日"+h+"时"+mi+"分"+s+"秒");  
	ordertime = String.format(y+"-"+m+"-"+d+" "+h+":"+mi+":"+s+"");  
%>

 <html>
  <head>
   <title>Tell</title>
   <style>
		* {
			margin: 0;
			padding: 0;
		}
		body{
			
			background:linear-gradient(to bottom,rgb(166,164,156) 0%,rgb(207,205,195) 50%,rgb(235,232,221) 100%);
		}
		#all{
		    border:1px solid green;
			width:100%
		
			
			
		}
		
        #header{
			width:100%;
			display:block;
			position:fixed;top:-4px;left:-2px;
			z-index:100;
			border:0px solid red;
		}
		#headerinner{
			border:0px solid black;
			width:1240px;
			margin:0 auto;
		}

		#menu {
		/*	width: 910px;*/
			width: 100%;
			height: 39px;
			padding: 10px 0px;
			background: url(images/menu.png) repeat-x;
			/*border:2px solid red;*/
			
            z-index:100;
		}
		#menu ul {
			display:block;
			position:relative;left:10px;
			margin: 0;
			padding: 0;
			list-style: none;
			z-index:100;
		}

		#menu ul li {
			padding: 0px;
			margin: 0px;
			display: inline-block;
			z-index:100;
		}

		#menu ul li a {
			float: left;
			display: inline-block;
			width: 100px;
			height: 24px;
			padding: 3px 0 0 0;
			margin: 0 5px 0 0 ;
			font-size: 13px;
			text-align: center;
			text-decoration: none;
			color: #333;	
			font-weight: bold;
			outline: none;
			border: none;
			z-index:100;

		}

		#menu ul li a:hover, #menu ul li .current {
			background: url(images/menu_hover.png) no-repeat;
			z-index:100;
		}
		
		#userme{
			height:40px;
			box-radius:0px;
			float:right;
			position:relative;right:15px;top:-33px;	
		}
		#usernameshow{
			display:block;
			float:right;
			position:relative;top:5px;left:4px;
		}
		
		.contain{
			border:0px solid red;
			width:1240px;
			margin:0 auto;
			margin-top:56px;
			//background:linear-gradient(to bottom,rgb(166,164,156) 0%,rgb(207,205,195) 50%,rgb(235,232,221) 100%);
		}
			
	    #dayphoto{
			box-shadow:0px 0px 8px rgb(0,0,0);
			width:100%;
			border:0px solid blue;
			height:500px;
		    margin:0 auto;
			background-image:url("everydayphoto/everyday.jpg");
		}
		#dayphotowords{
			border-bottom: 1px solid #E4E4E4;
			width:1210px;
			height:30px;
			padding-bottom:14px;
			font-size: 30px;
			float:left;
			position:relative;left:20px;top:15px;
			color:white;
	    }			
		
		#photowall {
			box-shadow:0px 0px 8px rgb(0,0,0);
            background-image:url("everydayphoto/photowallback.jpg")
        }

        #wallcontain {
			border:0px solid green;
            width: 1240px;
            height: 275px;
            margin: 5px auto;
			padding-top:20px;
            position: relative;
        }

        .pic {
            width: 250px;
        }

        #wallcontain img:hover {
            box-shadow: 15px 15px 20px rgba(50, 50, 50, 0.4);
            transform: rotate(0deg) scale(1.20);
            -webkit-transform: rotate(0deg) scale(1.20);
            z-index: 2;
        }

        #wallcontain img {
            padding: 7px 7px 7px;
            background: rgb(33,31,27);
            border: 1px solid rgb(0,0,0);
            box-shadow: 0px 0px 15px rgb(0, 0, 0);
            -webkit-transition: all 0.5s ease-in;
            -moz-transition: all 0.5s ease-in;
            -ms-transition: all 0.5s ease-in;
            -o-transition: all 0.5s ease-in;
            transition: all 0.5s ease-in;
            position: absolute;
            z-index: 1;
			border-radius:3px 3px 3px 3px;
        }

        /*第一张图片*/
        .pic1 {
            left: 400px;
            top: 50px;
            transform: rotate(-5deg);
            -webkit-transform: rotate(-5deg);
            -moz-transform: rotate(-5deg);
            -o-transform: rotate(-5deg);
        }

        .pic2 {
            left: 200px;
            top: 50px;
            transform: rotate(-20deg);
            -webkit-transform: rotate(-20deg);
        }

        .pic3 {
            left: 40px;
            right: 0;
            transform: rotate(5deg);
            -webkit-transform: rotate(5deg);
        }

        .pic4 {
            bottom: 125px;
            left: 520px;
            transform: rotate(-5deg);
            -webkit-transform: rotate(-5deg);
        }

        .pic5 {
            right: 40px;
            top: 20px;
            transform: rotate(5deg);
            -webkit-transform: rotate(5deg);
        }

        .pic6 {
            left: 770px;
            top: 24px;
            transform: rotate(10deg);
            -webkit-transform: rotate(10deg);
        }
		
		#nav{
			border:0px solid red;
			width:1240px;
			margin:10px auto; 
			padding-top:20px;
			background-color:rgb(46,44,39);
		}
		
		#words{
			border:1px solid black;
			width:1200px;
			height:560px;
			border-radius:8px 8px 8px 8px;
			margin:0 auto; 
			padding:15px;
			
			
		}
		
		#saytitle{
			border-bottom:1px solid white;
			width:1200;
			height:100px;
			color:white;
			font-size:43px;
		}
		#saytitleinner{
			border:0px solid green;
			height:30px;
			color:white;
			font-size:28px;
		}
		
		#say{
			color:white;
			//border:1px solid blue ;
		}
		
		textarea{
			float:left;
			border:0px solid black;
			margin-top:30px;
			margin-left:20px;
		}
		
		#img_wrapper{
		  width: 400px;
		  height: 360px;
		  margin: 0 auto;
		  margin-top: 20px;
		  border-radius: 20px;
		  box-shadow: 0 0 6px black;
		  float:right;
		}
		#xmTanImg{
		  width: 100%;
		  height: 100%;
		  border-radius: 20px;
		  object-fit: cover;
		}
		
		#shangchuantu{
			border:0px solid green;
			width:500px;
			height:40px;
			position:relative;left:900px;top:60px;
		}

		
		
		#place{
			position:relative;left:30px;top:-50px;
		}
		
		.placeanniu{
			padding:4px 4px;
			width:100px;
			height:60px;
			border:0px solid red;
			border-radius:6px 6px 6px 6px;
			background-color:rgb(0,127,176);
			margin-top:4px;
		}
		#placeanniukuang{
			display:inline-block;
			margin-top:4px;
		}
		
		#main{
			border:0px solid green;
			width:1180px;
			border-radius:8px 8px 8px 8px;
			padding:20px 20px 15px 15px;
			margin:0 auto; 
			color:white;
		}
		#everyli{
			width:1100px;
			
			margin:20px auto;
			
		}
		
		#xian{
			display:block;
			width:100%
			height:1px;
			
			boder-bottom:1px solid white;
		}	
		
   </style>
  </head> 
  <%
    if(request.getParameter("param1")!=null){
       String strVar1=request.getParameter("param1");
	   country=strVar1;
    }
	;
	if(request.getParameter("username")!=null){
       uname=request.getParameter("username");
	   country="隐藏";
    }
  %>
  <%
    ResultSet rsa;
    Connection cona;
    Statement stmta;
    String sqla ="";

	String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    String dbURL = "jdbc:sqlserver://172.18.93.179:1433; DatabaseName=Test";
	Class.forName(driverName);
	cona = DriverManager.getConnection(dbURL,"Tom", "123456");
	stmta = cona.createStatement();

	sqla ="select * from Users where username = '"+uname+"';";

    rsa=stmta.executeQuery(sqla);

    while(rsa.next())
    {
    	img_src = rsa.getString("file_name");
    }
  %>

<body>
  <div id="all">
  
    <%
	request.setCharacterEncoding("utf-8");
	String connectString = "jdbc:sqlserver://172.18.93.179:1433; DatabaseName=Test";  
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	con=DriverManager.getConnection(connectString,"Tom", "123456");
	
 
	if (request.getMethod().equalsIgnoreCase("post")){	
	    words="";
	    path="";
	    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	    String s1;
        if (isMultipart) { 
			FileItemFactory factory = new DiskFileItemFactory(); 
			ServletFileUpload upload = new ServletFileUpload(factory);
			List items = upload.parseRequest(request); 
			for(int i = 0; i < items.size(); i++) {
				FileItem fi = (FileItem) items.get(i);

				if(fi.isFormField()) {
					s1=fi.getFieldName();
					if(s1.equals("uname"))
					{
						uname=fi.getString("utf-8");
					} 
					else if(s1.equals("words"))
					{
					   words=fi.getString("utf-8");
					}
				}
				else{
					DiskFileItem dfi = (DiskFileItem) fi;
					if(!dfi.getName().trim().equals("")) {
						String fileName=application.getRealPath("temp/files/photo")
									  + System.getProperty("file.separator")
									  +uname+FilenameUtils.getName(dfi.getName());			  
						path=uname+FilenameUtils.getName(dfi.getName());
						dfi.write(new File(fileName));
					}
				} 
            }
        } 	
		try{
            Statement stmtn;
	        stmtn=con.createStatement(); 
         
		    String fmt="insert into user_Data(name,country,words,time,path,ordertime) values( '%s','%s','%s','%s','%s','%s')";
            sql = String.format(fmt,uname,country,words,time,path,ordertime);
		    int a=stmtn.executeUpdate(sql);
		    if(a>0){
			   msg="保存成功！";
			   stmtn.close();
		    }
		}
	    catch (Exception e){
			msg = e.getMessage();
		}
	}
	stmt=con.createStatement(); 
	sql=String.format("select * from user_Data order by ordertime desc");
	rs = stmt.executeQuery(sql);	
    %> 
	
	<div id="header">
	  
	   <div id="menu">
		<div id="headerinner">
			<ul>
				<li><a href="aaa.html">Home</a></li>
				<li><a href="aaa.html">Discover</a></li>
				<li><a href="aaa.html">Update</a></li>
				<li><a href="aaa.html" class="current">Tell</a></li>
			</ul>
			<div id="userme">
		    <img src="file/<%=img_src%>" style="object-fit: cover; width: 35px; height: 35px; border-radius: 35px;">
			<div id="usernameshow">
			    <%=uname%>
			</div>
		    </div>
		
	    </div>
		
	   </div>
   
	</div>
	
	<div class="contain">
	
		
		    <div id="dayphoto">
			    <div id="dayphotowords">Everyday Picture </div>
			</div>
			
			<div id="photowall">
				<div id="wallcontain">
					<img class="pic pic1" src="everydayphoto/everyday3.jpg">
					<img class="pic pic2" src="everydayphoto/everyday2.jpg">
					<img class="pic pic3" src="everydayphoto/everyday1.jpg">
					<img class="pic pic4" src="everydayphoto/everyday4.jpg">
					<img class="pic pic5" src="everydayphoto/everyday6.jpg">
					<img class="pic pic6" src="everydayphoto/everyday5.jpg">
				</div>
			</div>
			
		<div id="nav">
		
		
			<div id="words">
			
			    <div id="saytitle">
				    Say something：
					<div id="saytitleinner">
					about you and your place 
					</div>
				</div>
				
				<div id="say">
				
				
				    <div id="img_wrapper"><img id="xmTanImg" src="everydayphoto/everyday.jpg" /></div>
					
					<script type="text/javascript">
						//判断浏览器是否支持FileReader接口
						if (typeof FileReader == 'undefined') {
							document.getElementById("xmTanDiv").InnerHTML = "<h1>当前浏览器不支持FileReader接口</h1>";
							//使选择控件不可操作
							document.getElementById("xdaTanFileImg").setAttribute("disabled", "disabled");
						}
						//选择图片，马上预览
						function xmTanUploadImg(obj) {
							var file = obj.files[0];
							console.log(obj);console.log(file);
							console.log("file.size = " + file.size);  //file.size 单位为byte
							var reader = new FileReader();
							//读取文件过程方法
							reader.onloadstart = function (e) {
								console.log("开始读取....");
							}
							reader.onprogress = function (e) {
								console.log("正在读取中....");
							}
							reader.onabort = function (e) {
								console.log("中断读取....");
							}
							reader.onerror = function (e) {
								console.log("读取异常....");
							}
							reader.onload = function (e) {
								console.log("成功读取....");

								var img = document.getElementById("xmTanImg");
								img.src = e.target.result;
								//或者 img.src = this.result;  //e.target == this
							}
							reader.readAsDataURL(file)
						}
					</script>

				    
					<form name="user" action="user_tell.jsp" method="POST" enctype="multipart/form-data">
							    <input type="hidden" name="uname" value="<%=uname%>">	
                                <div id="saykuang">							
								<textarea name="words" rows="20" cols="100"> </textarea>
                                </div>
								<div id="shangchuantu">
								图片上传：<input type="file" name="file"  onchange="xmTanUploadImg(this)" accept="image/" ></input>
								</div>
								<input type="submit" name="submit" value="发表" style="position:relative;left:720px;top:10px;z-index:20;"></input>		   
					</form> <br></br>
					
					
					<div id="place">
						<p id="demo">当前坐标：<% out.print(country);%></p>
						
						<div id="placeanniukuang">
						  <label class="placeanniu" for="pla">点击获取</label> 
						  <button onclick="getLocation()" id="pla" style="margin:0; padding:0;display:none;position:absolute; clip:rect(0 0 0 0);">点击获取</button>
						</div>
						
						<script>
						var x=document.getElementById("demo");
						var placea;
						function getLocation()
						{
							if (navigator.geolocation)
							{
								navigator.geolocation.getCurrentPosition(showPosition,showError);
							}
							else
							{
								x.innerHTML="该浏览器不支持定位。";
							}
						}
						function showPosition(position)
						{
							x.innerHTML="纬度: " + position.coords.latitude + 
							"<br>经度: " + position.coords.longitude;	
							placea=position.coords.longitude + 
							"," + position.coords.latitude;
							window.location="user_tell.jsp?param1="+placea;
						}
						function showError(error)
						{
							switch(error.code) 
							{
								case error.PERMISSION_DENIED:
									x.innerHTML="用户拒绝对获取地理位置的请求。"
									break;
								case error.POSITION_UNAVAILABLE:
									x.innerHTML="位置信息是不可用的。"
									break;
								case error.TIMEOUT:
									x.innerHTML="请求用户地理位置超时。"
									break;
								case error.UNKNOWN_ERROR:
									x.innerHTML="未知错误。"
									break;
							}
						}	
						</script>
						
					</div>
					
				</div>
	
		    </div>
	
	        <div id="main">
				<%while(rs.next()){
						StringBuilder table_name=new StringBuilder("");
						StringBuilder table_country=new StringBuilder("");
						StringBuilder table_words=new StringBuilder("");
						StringBuilder table_time=new StringBuilder("");
						String table_path="";
						
						String srimage="";
						table_country.append(rs.getString("country").trim());
						table_name.append(rs.getString("name").trim());
						table_time.append(rs.getString("time").trim());
						table_words.append(rs.getString("words").trim());
						table_path=rs.getString("path").trim();%>
						
						<div id="everyli">
						
						    <%
								ResultSet rsnow;
								Connection connow;
								Statement stmtnow;
								String sqlnow ="";

								connow = DriverManager.getConnection(dbURL,"Tom", "123456");
								stmtnow = connow.createStatement();

								sqlnow ="select * from Users where username = '"+table_name+"';";

								rsnow=stmtnow.executeQuery(sqlnow);

								while(rsnow.next())
								{
									srimage = rsnow.getString("file_name");
								}
								
							%>
						    <div id="ll" style="display:block; margin-top:50px; position:relative;width:1100px;">
								
							    <div id="gudingxinxi" style="display:block;" >
							  
									<img src="file/<%=srimage%>" style="object-fit: cover; width: 65px; height: 65px; border-radius:65px;">
									
									<div id="namemmm" style="position:relative;top:-55px;left:83px;">
										<%=table_name%>
									</div>
							  
									<div id="timemmmm" style="position:relative;top:-50px;left:83px;">
										<%=table_time%>
									</div>						  
									
									<div id="plllll" style="display:block;position:relative;top:-40px;left:83px;">
								        <p>地点：<%=table_country%></p>
								    </div>
                                </div>
								
								<div id="buwendingneirong" style="display:block;width:1100px; background-color:rgb(51,51,51); padding-bottom:-300px;">
									<div id="neirong" style="display:block;position:relative;left:20px;top:10px;">
										<%=table_words%>
									</div>
									
									<div id="tu" style:"display:block;">
										<div id="kk" style="display:block">
										<% if(!table_path.equals("")){ %>
											<img src="photo/<%=table_path%>" height="200" width="330" style="position:relative; display:block; margin-top:30px;margin-bottom:20px;">
										<%}  %>
										</div>
										
										
										<div id="bb" style="display:block">
										<% if(!table_country.equals("隐藏")){ 
											String map="";
											map=map+"http://api.map.baidu.com/staticimage/v2?ak=MsvDBYspkVFwdjGysVx5kY2SijzKYNl4&mcode=666666&center="+table_country+"&width=300&height=200&zoom=11";
										%>
											<img src="<%=map%>" height="200" width="330" style="position:relative;left:350px;top:-230px; display:block; margin-top:30px;margin-bottom:20px;">
										<%}  %>
										</div>
										
										
										<div id="bv" style="display:block">
										<% if(!table_country.equals("隐藏")){ 
											String mapa="";
											mapa=mapa+"http://api.map.baidu.com/panorama/v2?ak=MsvDBYspkVFwdjGysVx5kY2SijzKYNl4&width=512&height=256&location="+table_country+"&fov=180";
										%>
											<img src="<%=mapa%>" height="200" width="330" style="position:relative;left:700px;top:-460px; display:block; margin-top:30px;margin-bottom:20px;">
										<%}  %>
										</div>
									</div>
									
                                </div>
								
								
							</div>  
	
						<div>
						<div id="xian" style="display:block;"><p>--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</p></div>						
				<% }%>
				<%rs.close(); stmt.close(); con.close();%>
			</div>
	    </div>
    </div>
	</div>
  </body>
</html>

 