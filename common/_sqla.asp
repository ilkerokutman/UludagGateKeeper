<%
Dim ba, baServer, baDB, baUser, baPass
baServer = "{SERVER_ADDRESS},{SERVER_PORT}"
baDB = "{DATABASE_NAME}"
baUser = "{USERNAME}"
baPass = "{PASSWORD}"
Set ba = Server.Createobject("Adodb.Connection")
ba.Open "Provider=SQLNCLI11;Server=" & baServer & ";Database=" & baDB & ";Uid=" & baUser & ";Pwd=" & baPass & ";"
%>
