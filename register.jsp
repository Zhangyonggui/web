<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*,java.util.*,org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page language="java" import="java.sql.*"%>

<%!String msg=""; Statement stmt;Connection con;ResultSet rs;String sql;%>
<%! String s1="",username="",password1="",password2="",file_name="",path=""; %>

<%
   request.setCharacterEncoding("utf-8");
   boolean isMultipart= ServletFileUpload.isMultipartContent(request);
  if(isMultipart) {

        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List items = upload.parseRequest(request);
        for(int i = 0; i < items.size(); i++) {
            FileItem fi = (FileItem) items.get(i);

            if(fi.isFormField()) {
                s1=fi.getFieldName();
                if(s1.equals("username"))
                {
                    username=fi.getString("utf-8");
                }
                else if(s1.equals("password1"))
                {
                    password1=fi.getString("utf-8").trim();
                }
                else if(s1.equals("password2"))
                {
                    password2=fi.getString("utf-8").trim();
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

%>

<%

  String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
  String dbURL = "jdbc:sqlserver://172.18.93.179:1433; DatabaseName=Test";
  Class.forName(driverName);
  con = DriverManager.getConnection(dbURL,"Tom", "123456");
  stmt = con.createStatement();

  sql ="select * from Users where username = '"+username+"';";
  rs=stmt.executeQuery(sql);
  boolean flag=false;

  if(rs.next()&&!username.equals(""))
  {
    // out.print(username);
      flag=false;
      %>
      <script language="javascript"> //JavaScript脚本标注
            alert("注册失败:该用户已存在～");//在页面上弹出上联
      </script>
     <%
  }
  else
  {
      if(!password1.equals(password2))
      {
          %>
            <script language="javascript"> //JavaScript脚本标注
               alert("注册失败:两次输入密码不一致～");//在页面上弹出上联
            </script>
          <%
          flag=false;
      }
      else
      {
            flag=true;
      }
  }



  if (request.getMethod().equalsIgnoreCase("post")&&flag==true){
        String fmt="insert into Users(username,password,file_name,file_path) values('%s', '%s','%s','%s')";
        sql = String.format(fmt,username,password1,file_name,path);

        try
        {
          int cnt = stmt.executeUpdate(sql);
          if(cnt>0)
          {
              %>
                <script language="javascript"> //JavaScript脚本标注
                alert("注册成功！");//在页面上弹出上联
                </script>
              <%
          }
          else
          {
              %>
                <script language="javascript"> //JavaScript脚本标注
                alert("注册失败！");//在页面上弹出上联
                </script>
              <%
          }
        }
        catch(Exception e){
           msg = e.getMessage();

       }

  }
%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>注册</title>
    <meta name="description" content="">
    <meta name="keywords" content="">
    <link rel="stylesheet" type="text/css" href="register.css">
    <script type="text/javascript" src="http://cdn.webfont.youziku.com/wwwroot/js/wf/youziku.api.min.js"></script>
    <script type="text/javascript">
    $youziku.load("body", "5ccc3fcb7d0544039ca5b8a560c39288", "PingFangSCM");
    /*$youziku.load("#id1,.class1,h1", "5ccc3fcb7d0544039ca5b8a560c39288", "PingFangSCM");*/
    /*．．．*/
    $youziku.draw();
  </script>
  <style>
    .filebutton{
      /* margin-top:60px; */
      /* display: block; */
      margin-left: 130px;
      padding:10.7px 20px;
      /* padding-left: 140px; */
      /* padding-right:130px; */
      /* border:2px solid red; */
      border-radius: 3px;
      font-size: 14px;
      color: white;
      background-color: #1e88e5;
    }
    #img_wrapper{
      width: 150px;
      height: 150px;
      margin: 0 auto;
      margin-top: 25px;
      border-radius: 150px;
      box-shadow: 0 0 6px black;
    }
    #xmTanImg{
      width: 100%;
      height: 100%;
      border-radius: 150px;
      object-fit: cover;
    }
    #gotodenglu:hover{
      transition:0.3s all;
      font-size:22px;
    }
    #window{
      position:fixed;
      margin:0 auto;
      left:0;
      right:0;
    }
  </style>
  </head>

  <body>
    <section class="slider-contaner">
      <div id="window" style="height:530px; width: 360px; padding:20px;padding-right: 20px; padding-left:20px;background-color:#ffffff; border-radius:4px; overflow-x: hidden;position: absolute;top:80px;z-index: 13;">
          <form method="post" action="register.jsp" enctype="multipart/form-data">
            <div style="text-align: center;font-size:35px;height: 50px;">用户注册</div>

            <hr class="hr15" />
            <input name="username" type="text" placeholder="New UserName" required="required" autofocus/>

            <hr class="hr15" />
            <input name="password1" type="password" placeholder="New Password" required="required">
            <hr class="hr15" />
            <input name="password2" type="password" placeholder="Confirm Password" required="required">
            <hr class="hr15" style="height:20px;"/>
                <label class="filebutton" for="xFile"><span>头像上传</span></label>
                <input type="file" name="file" id="xFile" style="margin:0; padding:0;display:none;position:absolute; clip:rect(0 0 0 0);" onchange="xmTanUploadImg(this)" accept="image/*"/>
                <div id="img_wrapper"><img id="xmTanImg" src="images/moren.png"/></div>
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
            <br>
            <div style="clear: both"></div>
            <input type="submit" value="Register" style="width:360px;height: 36px;" />
            <hr class="hr15" /> 注册完成？点此处返回<a id="gotodenglu" href="index.jsp">登录</a>
          </form>



      </div>

      <ul class="slider">
        <li class="slider-item slider-item1">
          <div id="wrapper"></div></li>
        <li class="slider-item slider-item2">
            <div id="wrapper"></div></li>
        <li class="slider-item slider-item3">
            <div id="wrapper"></div></li>
        <li class="slider-item slider-item4">
            <div id="wrapper"></div></li>
        <li class="slider-item slider-item5">
            <div id="wrapper"></div></li>
      </ul>
    </section>
  </body>
</html>
