<%
Function BytesToStr(bytes)
    Dim Stream
    Set Stream = Server.CreateObject("Adodb.Stream")
        Stream.Type = 1
        Stream.Open
        Stream.Write bytes
        Stream.Position = 0
        Stream.Type = 2
        Stream.Charset = "utf-8"
        BytesToStr = Replace(Stream.ReadText, "'", "`")
        Stream.Close
    Set Stream = Nothing
End Function

Class Result
    public success
    public error
    public message
    public statusCode

    public function reflect()
        set reflect = Server.CreateObject("Scripting.Dictionary")
        with reflect
            .add "success", success
            .add "error", error
            .add "message", message
            .add "statusCode", statusCode
        end with
    end function
End Class

Class AttachmentItem
    
End Class

Class PostItem
    Private NameVar

    Public Property Get Name()
        Name = NameVar
    End Property

    Public Property Set Name(nameParam)
        NameVar = nameParam
    End Property
End Class


%>