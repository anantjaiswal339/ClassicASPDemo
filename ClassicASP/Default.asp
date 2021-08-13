<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title></title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <%        
        set conn = Server.CreateObject("ADODB.Connection")
        'conn.open = "Driver={MySQL ODBC 8.0 Unicode Driver};Server=MYSQL6003.site4now.net;Database=db_a662bf_classic;User=a662bf_classic;Password=classic@123;Option=3;PORT=3306;"
        set Cmd = Server.CreateObject("ADODB.Command")
        dim db_connection
        db_connection = "ODBCConnection32"

        '-------------------------------------------------------
        conn.open(db_connection)
        '-------------------------------------------------------
        set rs = Server.CreateObject("ADODB.RecordSet")    
        sql = "select * from Student"
        set model = Conn.execute(sql)

    %>

    <%
    set studentId = Request.QueryString("StudentId")
    if studentId <> "" then
       sSQL = "SELECT * FROM Student where StudentId = " & studentId       
       set student = Conn.execute(sSQL)
      
       if not(student.bof and student.eof) then            
            FirstName = student("FirstName")
            LastName = student("LastName")
            Mobile = student("Mobile")
            Age =student("Age")
            StudentId=student("StudentId")
       end if
end if


     %>
    <script type="text/javascript">

        function FormSubmit() {
            if (ValidateForm() == false)
                return false;

            var firstName = $("#txtFirstName").val();
            var lastName = $("#txtLastName").val();
            var age = $("#txtAge").val();
            var mobile = $("#txtMobile").val();            
            $.ajax({
                type: "POST",
                url: "PostStudent.asp?StudentId=" + $("#hdnStudentId").val(),
                data: { FirstName: firstName, LastName: lastName, Age: age, Mobile: mobile },
                success: function (response) {                    
                    alert(response);
                    location.href = "Default.asp";
                },
                error: function (response) {                    
                }
            });
        }

        function StudentDelete(studentId) {
            if (confirm("Are you sure want to delete?")) {
                $.ajax({
                    type: "POST",
                    url: "DeleteStudent.asp",
                    data: { StudentId: studentId },
                    success: function (response) {                        
                        alert(response);
                        location.href = "Default.asp";
                    },
                    error: function (response) {
                        debugger
                    }
                });
            }
        }

        function ValidateForm() {
            if ($("#txtFirstName").val() == "") {
                alert("Enter First Name.");
                return false;
            }
            if (isNaN($("#txtAge").val())) {
                alert("Age must be numeric.");
                return false;
            }
            if (isNan($("#txtMobile").val())) {
                alert("Mobile Number must be numeric.");
                return false;
            }
            else
                return true;
        }

    </script>

</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h3>Add Student</h3>
                <form class="form-horizontal">
                    <input type="hidden" id="hdnStudentId" value="<%=StudentId%>" />
                    <div class="form-group">
                        <label class="control-label col-sm-2">First Name:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="txtFirstName" name="firstName" value="<%=FirstName%>" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2">Last Name:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="txtLastName" name="lastName" value="<%=LastName%>" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2">Age:</label>
                        <div class="col-sm-10">
                            <input type="number" class="form-control" id="txtAge" name="age" value="<%=Age%>" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2">Mobile:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="txtMobile" name="mobile" value="<%=Mobile%>" />
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">                            
                            <button type="button" class="btn btn-primary" onclick="FormSubmit()">Add</button>
                            <a href="Default.asp" class="btn btn-danger">Cancel</a>
                        </div>
                    </div>
                </form>

            </div>

            <div class="col-md-12">
                <h3>Student List</h3>
                <table class="table table-responsive">
                    <tr>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Age</th>
                        <th>Mobile</th>
                        <th>Action</th>
                    </tr>
                    <%            
                    while not model.eof
                    %>
                    <tr>
                        <td><%=model("FirstName")%></td>
                        <td><%=model("LastName")%></td>
                        <td><%=model("Age")%></td>
                        <td><%=model("Mobile")%></td>
                        <td>
                            <a href="#" onclick="return StudentDelete(<%=model("StudentId")%>)" class="news">Delete</a>
                            <a href="Default.asp?StudentId=<%=model("StudentId")%>" class="news_frm">Edit</a>
                        </td>
                    </tr>
                    <%
                    model.movenext
                    wend
                    %>
                </table>

            </div>
        </div>
    </div>

</body>

</html>
