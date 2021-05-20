<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
Option Explicit
Response.Buffer = True
Response.Expires = -1
Response.ExpiresAbsolute = Now() - 2
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.CacheControl = "No-Store"
Session.LCID = 1055
Response.ContentType = "application/json"
Response.Charset = "utf-8"
%>
<!--#include file = "../common/_sqla.asp"-->
<!--#include file = "../common/_func.asp"-->
<!--#include file = "../common/_JSON.asp"-->
<!--#include file = "../common/_vbsJson.asp"-->
<!--#include file = "../common/_classes.asp"-->
<%
Dim lngBytesCount
Dim jsonString
Dim ob
Dim j2
Dim rs
Dim data




Set data = Server.CreateObject("Scripting.Dictionary")
Dim jStatus : jStatus = 200
Dim jSuccess : jSuccess = True
Dim jMessage : jMessage = ""
Dim Results
Set Results = Server.CreateObject("Scripting.Dictionary")

Dim personId, controlPointId, accessDateTime

Set rs = ba.Execute("SELECT TOP 1 id FROM Person ORDER BY NEWID()")
    if Not rs.eof Then personId = rs("id").value
Set rs = Nothing

Set rs = ba.Execute("SELECT TOP 1 id FROM ControlPoints ORDER BY NEWID()")
    if Not rs.eof Then controlPointId = rs("id").value
Set rs = Nothing


    On Error resume Next
    ba.Execute("INSERT INTO [AccessLogs] (personId, controlPointId, accessDateTime) VALUES ('" & personId & "', '" & controlPointId & "', '" & randomDateForTest() & "')")
    data.add "data", ba.Execute("SELECT TOP 1 id, accessDateTime, personId, controlPointId FROM [AccessLogs] WHERE personId = '" & personId & "' AND controlPointId = '" & controlPointId & "' ORDER BY accessDateTime DESC")
    


data.add "success", jSuccess
data.add "statusCode", jStatus
data.add "processTime", dbDateTime(Now())
data.add "message", Replace(jMessage, """", "\""")
Response.Write((new JSON).toJSON(empty, data, false))
%>
<!--#include file = "../common/_sqlk.asp"-->