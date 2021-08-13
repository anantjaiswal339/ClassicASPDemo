<%  
    set studentId = Request.Form("StudentId")
    
    set conn = Server.CreateObject("ADODB.Connection")    
    dim db_connection
    db_connection = "ODBCConnection32"    
    conn.open(db_connection)
        
    sSQL= "DELETE FROM Student WHERE StudentId=" & studentId
    Response.Write("Student Deleted Successfully")
    
    conn.execute(sSQL)

    'conn.Execute "Exec StudentInsert"
%>
