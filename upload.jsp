<%@page language="java" import="java.sql.*" contentType="text/html; charset=utf-8"%>
<%@page pageEncoding="utf-8"%>
<%@page import="java.io.*,java.util.*,org.apache.commons.io.*"%>
<%@page import="org.apache.commons.fileupload.*"%>
<%@page import="org.apache.commons.fileupload.disk.*"%>
<%@page import="org.apache.commons.fileupload.servlet.*"%>

<%! Statement stmt1;Statement stmt;Statement stmt2;ResultSet rs;Connection con; String msg ="";%>
<%! String s1="",id="",country="",year="",month="",name="",sql="",file_name="",path="",file_type="",type_name=""; %>
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
    request.setCharacterEncoding("utf-8");%>

<%boolean isMultipart= ServletFileUpload.isMultipartContent(request);
    if(isMultipart) {
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List items = upload.parseRequest(request);
        for(int i = 0; i < items.size(); i++) {
            FileItem fi = (FileItem) items.get(i);

            if(fi.isFormField()) {
                s1=fi.getFieldName();
                if(s1.equals("id1"))
                {
                    id=fi.getString("utf-8");
                }
                else if(s1.equals("country"))
                {
                    country=fi.getString("utf-8");
                }
                else if(s1.equals("year"))
                {
                    year=fi.getString("utf-8");
                }
                else if(s1.equals("month"))
                {
                    month=fi.getString("utf-8");
                }
            }
            else{
                DiskFileItem dfi = (DiskFileItem) fi;
                if(!dfi.getName().trim().equals("")) {
                    String fileName=application.getRealPath("temp/files/file")
                                  + System.getProperty("file.separator")
                                  +FilenameUtils.getName(dfi.getName());
                    file_name=FilenameUtils.getName(dfi.getName());
                    path=new File(fileName).getAbsolutePath();
                    dfi.write(new File(fileName));
                }
            }
        }
    }

    int length=file_name.length();
    int pos1 = file_name.indexOf(".");

   // out.print(length+" "+pos1);
    //out.print(" ");

    String sub=file_name.substring(pos1+1,length);
    //out.print(sub);
    file_type=sub;

    if(file_type.equals("rar")) type_name ="压缩文件";
    else if(file_type.equals("html")) type_name="网页";
    else if(file_type.equals("zip"))  type_name="压缩文件";
    else if(file_type.equals("exe"))  type_name="可执行文件";
    else if(file_type.equals("pdf"))  type_name="文档";
    else if(file_type.equals("doc"))  type_name="文档";
    else if(file_type.equals("png"))  type_name="图片";
    else if(file_type.equals("jpg"))  type_name="图片";
    else if(file_type.equals("ppt"))  type_name="演示文稿";
    else if(file_type.equals("tbl"))  type_name="批量插入数据文件";
    else if(file_type.equals("mp3"))  type_name="音乐";
    else if(file_type.equals("mp4"))  type_name="视频";
    else if(file_type.equals("avi"))  type_name="视频";
    else if(file_type.equals("mkv"))  type_name="视频";
    else                              type_name="未知";

    //out.print(file_type);

%>

<%

    String num = request.getParameter("num");
    boolean flag1=file_name.equals(""),flag2=id.equals("");


    if(request.getMethod().equalsIgnoreCase("post")&&flag1!=true&&flag2!=true){
        try{
            Class.forName(driverName);
        	con=DriverManager.getConnection(dbURL,"Tom", "123456");
        	stmt1=con.createStatement();
        	stmt2=con.createStatement();


        	String fmt="insert into Files(files_id,name,country,year,month,file_name,file_type) values('%s', '%s','%s','%s','%s','%s','%s')";
        	sql = String.format(fmt,id,username,country,year,month,file_name,type_name);

        	int cnt = stmt1.executeUpdate(sql);
        	if(cnt>0){
            %>
              <script language="javascript"> //JavaScript脚本标注
              alert("文件上传成功！");//在页面上弹出上联
              </script>
            <%
          }
           // msg = "保存成功!";
           //  else      msg = "保存失败!";


            if(file_type.equals("tbl"))
            {
                String sql1 = "BULK INSERT Db FROM '"+path+"' WITH (TABLOCK, DATAFILETYPE='char', CODEPAGE='raw', FIELDTERMINATOR = '|') ";

                int cnt1 = stmt2.executeUpdate(sql1);


                if(cnt1>0) msg = "插入成功!";
                else       msg = "插入失败!";
            }

    	}
    	catch (Exception e){
      		msg = e.getMessage();
      		out.print(msg);
    	}
    }
    else if(request.getMethod().equalsIgnoreCase("post")&&(flag1==true||flag2==true))  out.print("未选择文件或文件id为空！不允许上传!");
%>

<!DOCTYPE html>
<html>
  <meta charset="utf-8">
    <head>
      <title>上传</title>
      <link rel="stylesheet" type="text/css" href="upload.css">
        <link href='http://cdn.webfont.youziku.com/webfonts/nomal/111726/47387/5a3094aef629d91478c5d858.css' rel='stylesheet' type='text/css'/>
        <style>
        h1 {
          font-size: 30px;
          padding: 0 0 10px 20px;
          display: block;
          border-bottom: 1px solid #E4E4E4;
          margin: -10px -15px 30px -10px;
          color: white;
          width: 1200px;
        }
        #header h1 {
          width: 1200px;
          position: relative;
          left: 20px;
        }
        h1 > span {
          display: block;
          font-size: 20px;
        }
        label {
          display: block;
          margin: 0;
        }
        label > span {
          float: left;
          width: 100px;
          text-align: right;
          padding-right: 10px;
          margin-top: 10px;
          color: white;
          // margin-left: -135px;
        }
        input[type="file"],
        input[type="text"],
        select{
          border: 1px solid #DADADA;
          color: #888;
          height: 33px;
          margin-bottom: 16px;
          margin-top: 2px;
          outline: 0 none;
          padding: 3px 0px 3px 5px;
          width: 300px;
          font-size: 13px;
          line-height: 33px;
          box-shadow: inset 0 1px 4px #ECECEC;
        }
        input[type="file"],
        input[type="text"]{
          width:293px;
          padding: 3px 0px 3px 5px;
          height:25px;
          // padding-left:15px;
        }
        select {
          background: #FFF url('down-arrow.png') no-repeat right;
          background: #FFF url('down-arrow.png') no-repeat right);
          appearance: none;
          text-indent: 0.01px;
          text-overflow: '';
        }
        .button {
          background: #B22222;
          border: none;
          padding: 10px 25px;
          color: #FFF;
          box-shadow: 1px 1px 3px #000000;
          border-radius: 3px;
          text-shadow: 1px 1px 1px #000000;
          display:block;
          cursor: pointer;
          position: relative;
          left: 200px;
          top: 7px;
        }
        .button:hover {
          background: #FF4500;
        }
        #main {
          height: 60%;
          position: relative;
        }
        #video_play{
          position: absolute;
          top: 80px;
          left: 625px;
          box-shadow: #000000 0px 0px 15px;
        }
        #wrapper {
          margin-top: 70px;
        }
        #header {
          background-image: url("images/upload.jpg");
          width: 1240px;
          height: 400px;
        }
        #header div h1 {
          position: relative;
          top: 25px;
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
        h1{
          text-shadow: 1px 1px 1px black;
        }
        </style>
        <script type="text/javascript" src="http://cdn.webfont.youziku.com/wwwroot/js/wf/youziku.api.min.js "></script>
        <script type="text/javascript">
          $youziku.load("body", "5ccc3fcb7d0544039ca5b8a560c39288", "PingFangSCM");
          /*$youziku.load("#id1,.class1,h1", "5ccc3fcb7d0544039ca5b8a560c39288", "PingFangSCM");*/
          /*．．．*/
          $youziku.draw();
        </script>

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
            <li id="choose"><a href="upload.jsp" class="current">Upload</a></li>
            <li id="choose"><a href="search.jsp">Search</a></li>
          </ul>
        </div>

        <div id="wrapper">
          <div id="header">
            <div>
              <h1>Build The World</h1>
            </div>
          </div>

          <div id="main">
            <%-- <video id="video_play" controls="controls" autoplay="autoplay">
              <source src="follow.mp4" type="video/mp4"/>
              Your browser does not support the video tag.
            </video> --%>
          <iframe id="video_play" height=240 width=427 src='http://player.youku.com/embed/XODg0MTI2NDM2' frameborder=0 'allowfullscreen'></iframe>
            <form name="fileupload" action="upload.jsp" method="POST" enctype="multipart/form-data">
              <h1>
                <span>请填写所上传文件的相关信息</span>
              </h1>
              <label>
                <span>文件ID：</span>
                <input type="text" name="id1">
              </label>

                <label>
                  <span>文件上传地点：</span>
                  <select name="country">
                    <option value="AFG">阿富汗</option>
                    <option value="ALB">阿尔巴尼亚</option>
                    <option value="ALG">阿尔及利亚</option>
                    <option value="AND">安道尔</option>
                    <option value="ANG">安哥拉</option>
                    <option value="ARG">阿根廷</option>
                    <option value="ARM">亚美尼亚</option>
                    <option value="AUS">澳大利亚</option>
                    <option value="AUT">奥地利</option>
                    <option value="AZE">阿塞拜疆</option>

                    <option value="BAH">巴哈马</option>
                    <option value="BAN">孟加拉国</option>
                    <option value="BEL">比利时</option>
                    <option value="BHU">不丹</option>
                    <option value="BLR">白俄罗斯</option>
                    <option value="BOL">玻利维亚</option>
                    <option value="BRA">巴西</option>
                    <option value="BRU">文莱</option>

                    <option value="CAN">加拿大</option>
                    <option value="CGO">刚果</option>
                    <option value="CHN">中国</option>
                    <option value="CUB">克罗地亚</option>
                    <option value="DEN">丹麦</option>
                  </select>
                </label>
                <label>
                  <span>文件上传年份：</span>
                  <select name="year">
                    <option value="2017">2017年</option>
                    <option value="2016">2016年</option>
                    <option value="2015">2015年</option>
                    <option value="2014">2014年</option>
                    <option value="2013">2013年</option>
                    <option value="2012">2012年</option>
                    <option value="2011">2011年</option>
                    <option value="2010">2010年</option>
                    <option value="2009">2009年</option>
                    <option value="2008">2008年</option>
                    <option value="2007">2007年</option>
                    <option value="2006">2006年</option>
                  </select>
                </label>
                <label>
                  <span>文件上传月份：</span>
                  <select name="month">
                    <option value="1">一月</option>
                    <option value="2">二月</option>
                    <option value="3">三月</option>
                    <option value="4">四月</option>
                    <option value="5">五月</option>
                    <option value="6">六月</option>
                    <option value="7">七月</option>
                    <option value="8">八月</option>
                    <option value="9">九月</option>
                    <option value="10">十月</option>
                    <option value="11">十一月</option>
                    <option value="12">十二月</option>
                  </select>
                </label>
                  <label>
                    <span>文件：</span>
                      <input type="file" name="file">
                  </label>

                  <input type="submit" name="submit" value="提交" class="button">
                  </form>

                </div>
                <div id="footer">Copyright © 2017&nbsp;东苑宾馆B717荣耀出品&nbsp;&nbsp;&nbsp;<span id=sTime><script>setInterval("document.all.sTime.innerText=new Date().toLocaleString()",1000)</script> </span></div>
              </div>
            </body>
          </html>
