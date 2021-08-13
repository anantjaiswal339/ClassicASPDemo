<%  
    set studentId = request.QueryString("StudentId")
    set firstName = Request.Form("FirstName")
    set lastName = Request.Form("LastName")
    set age = Request.Form("Age")
    set mobile = Request.Form("Mobile")    

    set conn = Server.CreateObject("ADODB.Connection")    
    dim db_connection
    db_connection = "ODBCConnection32"

    '-------------------------------------------------------
    conn.open(db_connection)
    '-------------------------------------------------------

    'Set the command
    DIM cmd
    SET cmd = Server.CreateObject("ADODB.Command")
    SET cmd.ActiveConnection = conn


    'Prepare the stored procedure
    'cmd.CommandText = "StudentInsert"
    'cmd.CommandType = 4  'adCmdStoredProc

    ''cmd.Parameters.Append cmd.CreateParameter("@FirstName",adVarchar,adParamInput,20, lastName)
    ''cmd.Parameters.Append cmd.CreateParameter("@LastName",adVarchar,adParamInput,20,lastName)
    'cmd.Parameters.Append cmd.CreateParameter("@Age",adTinyInt,adParamInput,4,age)
    'cmd.Parameters.Append cmd.CreateParameter("@Mobile",adVarchar,adParamInput,15,mobile)
    
    'Execute the stored procedure
    'cmd.Execute

    'conn.Close
    
    if studentId <> "" then
        sSQL= "Update Student SET LastName='" & lastName & "' ,FirstName='" & firstName & "', Mobile='" & mobile & "',Age=" & age & " where StudentId=" & studentId
        Response.Write("Student Update Successfully")
    else
        sSQL= "INSERT INTO Student (FirstName,LastName,Mobile,Age) values('" &(firstName)& "','"&(lastName) & "','"&(mobile)&"','"&(age)&"')"
        Response.Write("Student Added Successfully")
    end if
    conn.execute(sSQL)

    'conn.Execute "Exec StudentInsert"
%>
