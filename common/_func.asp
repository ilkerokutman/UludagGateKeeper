<%


Function randomDateForTest()
	Randomize
	Dim randomDay : randomDay = Int(365 * Rnd)
	Dim randomHour : randomHour = Int(12 * Rnd)+8
	Dim randomMinute : randomMinute = Int(59 * Rnd)
	Dim randomSecond : randomSecond = Int(59 * Rnd)
	Dim rDate : rDate = dbDateTime(dbDate(DateAdd("d", 0 - randomDay, Date())) & "T" & randomHour & ":" & randomMinute & ":" & randomSecond)
	randomDateForTest = rDate
End Function


Function bitToInt(b)
Dim r
	if IsNull(b) Then r = 0
	if IsEmpty(b) Then r = 0
	if Len(b) = 0 Then r = 0
    if b = "False" Or b = "false" Then r = 0
    if b = "True" Or b = "true" Then r = 1
    if b = False Then r = 0
    if b = True Then r = 1
	if b = 1 Then r = 1
	if b = 0 Then r = 0
    if r = 1 Or r = 0 Then
    Else
    r = 0
    End if
    bitToInt = r
End Function
'######################################################################################################################################
Function xmlStripper(xmlBody, tagName)
	Dim nodeVal : nodeVal = ""
	if InStr(xmlBody, "<" & tagName & ">") > 0 And InStr(xmlBody, "</" & tagName & ">") > 0 Then
		Dim arr1, arr2
		arr1 = Split(xmlBody, "<" & tagName & ">")
		arr2 = Split(arr1(1), "</" & tagName & ">")
		nodeVal = arr2(0)
	Else
		nodeVal = "-"
	End if
	xmlStripper = nodeVal
End Function
'######################################################################################################################################
Function checkApiKey(apiKey)
	Dim res : res = false
	Dim rs
	Set rs = ba.Execute("EXEC [Api].[spGetApiKey]")
		if Not rs.eof Then
			if (rs(0) = apiKey) Then res = true
		End if
	Set rs = Nothing
	checkApiKey = res
End Function
'######################################################################################################################################
Function retUsrId(accessToken)
	Dim frs, fSQL, fRetVal
    Set frs = ba.Execute("EXEC [Api].[spCheckUser] @accessToken='" & accessToken & "' ")
        if Not frs.eof Then fRetVal = frs(0).Value
    Set frs = Nothing
    retUsrId = fRetVal
End Function
'######################################################################################################################################
Function sendSms(strNumber, strMessage)
  Dim xmlhttp, smsUrl
  smsUrl = "http://servis.3gmesaj.com/websms/services/SendSmsGet.aspx?user=tbb_bursasistem&password=Tm2b9D1&to=" & strNumber & "&text=" & strMessage & "&origin=BURSABAROSU"
  Set xmlhttp = Server.CreateObject("MSXML2.ServerXMLHTTP")
  xmlhttp.setTimeouts 30,500,1000,1000
  xmlhttp.Open "GET", smsUrl, false
  On Error Resume Next
  xmlhttp.Send
  If Err.Number Then
    sendSms = "SMS Gonderilemedi"
    Err.Clear
  Else
    sendSms = xmlhttp.ResponseText
  End If
  On Error Goto 0
  Set xmlhttp = nothing
End Function
'######################################################################################################################################

'######################################################################################################################################
'######################################################################################################################################

'######################################################################################################################################
Function TaskDate(d)
	if Not IsDate(d) Then Exit Function
	TaskDate = Day(d) & " " & MonthName(Month(d)) 
	if Hour(d)>0 Or Minute(d)>0 Then
	TaskDate = TaskDate & " " & Hour(d) & ":" & Right("0" & Minute(d),2)
	End If
End Function
'######################################################################################################################################
function tarihyaz(d)
	if Not IsDate(d) Then Exit Function
	tarihyaz = Replace(Replace(inputtarih(d), Date(), "Bugün"), (DateAdd("d",-1,Date())), "Dün") ''& " " & inputsaat(d)
end function
'######################################################################################################################################
function tarihsaat(d)
	if Not IsDate(d) Then Exit Function
	tarihsaat = Day(d) & "." & MonthName(Month(d)) & "." & Year(d) & " " & WeekDayName(WeekDay(d)) & " " & Hour(d) & ":" & Right("00" & Minute(d),2)
end function
'######################################################################################################################################
function inputtarih(d)
	if Not IsDate(d) Then Exit Function
	inputtarih = Right("0" & Day(d), 2) & "." & Right("0" & Month(d), 2) & "." & Year(d)
end function
'######################################################################################################################################
function inputsaat(d)
	if Not IsDate(d) Then Exit Function
	inputsaat = Right("0" & Hour(d), 2) & ":" & Right("0" & Minute(d), 2)
end function
'######################################################################################################################################
function to_unix_timestamp(s)
	to_unix_timestamp = DateDiff("s", "01/01/1970 00:00:00", s)
end function
'######################################################################################################################################
function from_unix_timestamp(s)
	from_unix_timestamp = DateAdd("s", s, "01/01/1970 00:00:00")
end function
'######################################################################################################################################
Function isEmailValid(email) 
	Dim regEx
	Set regEx = New RegExp 
	regEx.Pattern = "^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w{2,}$" 
	isEmailValid = regEx.Test(trim(email)) 
End Function 
'######################################################################################################################################
Function Req(item) 	
	Req = "" 
	If Request.QueryString(item).Count > 0 Then 
	Req = Request.QueryString(item) 
	ElseIf Request.Form(item).Count > 0 Then 
	Req = Request.Form(item) 
	End If 
End Function 
'######################################################################################################################################
Function RF(item)
	RF=""
	RF=Temizle(Trim(Request.Form(item)))
End Function
'######################################################################################################################################
Function RQ(item)
	RQ=""
	RQ=Temizle(Trim(Request.QueryString(item)))
End Function
'######################################################################################################################################
Function RegExResults(strTarget, strPattern)
	Dim regEx
    Set regEx = New RegExp
    regEx.Pattern = strPattern
    regEx.Global = true
    Set RegExResults = regEx.Execute(strTarget)
    Set regEx = Nothing
End Function
'######################################################################################################################################

Function ReplaceSpecialChar(strInput)
	Dim objRegExp
	Set objRegExp = New Regexp
	objRegExp.IgnoreCase = True
	objRegExp.Global = True
	objRegExp.Pattern = "/[^a-zA-Z0-9]+/"
	'//Replace all character matches with an Empty String
	ReplaceSpecialChar = objRegExp.Replace(strInput, "-")  
	Set objRegExp = Nothing
End Function

Function isURL(strURL)
	Dim Slug, re, re2
	'Everything to lower case
	Slug = lcase(strURL)
	' Replace - with empty space
	Slug = Replace(Slug, "-", " ")
	' Replace unwanted characters with space
	Set re = New RegExp
	re.Pattern = "[^a-z0-9\s-]"
	re.Global = True
	Slug = re.Replace(Slug, " ")
	' Replace multple white spaces with single space
	Set re2 = New RegExp
	re2.Pattern = "\s+"
	re2.Global = True
	Slug = re2.Replace(Slug, " ")
	Slug = Trim(Slug)
	' Replace white space with -
	Slug = Replace(Slug," ", "-")
	isURL = Slug
End Function
'######################################################################################################################################
Function urlYap(deger)
	deger = ReplaceSpecialChar(deger)
	deger = Kucult(deger)
	deger = trsil(deger)
	deger = LCase(deger)
	deger = Replace(deger, " ", "-")
	deger = Replace(deger, ".", "-")
	Do Until Right(deger, 1) <> "-"
		deger = Left(deger, Len(deger)-1)
	Loop
	urlYap = deger
End Function
'######################################################################################################################################
Function trsil(deger)
	deger = replace(deger, "Ü","U", 1, -1, 1)
	deger = replace(deger, "Ş","S", 1, -1, 1)
	deger = replace(deger, "Ğ","G", 1, -1, 1)
	deger = replace(deger, "İ","i", 1, -1, 1)
	deger = replace(deger, "Ç","C", 1, -1, 1)
	deger = replace(deger, "Ö","O", 1, -1, 1)
	deger = replace(deger, "ü","u", 1, -1, 1)
	deger = replace(deger, "ğ","g", 1, -1, 1)
	deger = replace(deger, "ı","i", 1, -1, 1)
	deger = replace(deger, "ş","s", 1, -1, 1)
	deger = replace(deger, "ö","o", 1, -1, 1)
	deger = replace(deger, "ç","c", 1, -1, 1)
	trsil = deger
End Function
'######################################################################################################################################
Function Temizle(strVeri)
	On Error resume Next
	If strVeri = "" Then Exit Function
	strVeri = Replace(strVeri, "<", "&lt;")
	strVeri = Replace(strVeri, ">", "&gt;")
	strVeri = Replace(strVeri, "[", "&#091;")
	strVeri = Replace(strVeri, "]", "&#093;")
	strVeri = Replace(strVeri, """", "", 1, -1, 1)
	strVeri = Replace(strVeri, "=", "&#061;", 1, -1, 1)
	strVeri = Replace(strVeri, "'", "''", 1, -1, 1)
	strVeri = Replace(strVeri, " select ", " sel&#101;ct ", 1, -1, 1)
	strVeri = Replace(strVeri, " join ", " jo&#105;n ", 1, -1, 1)
	strVeri = Replace(strVeri, " union ", " un&#105;on ", 1, -1, 1)
	strVeri = Replace(strVeri, " where ", " wh&#101;re ", 1, -1, 1)
	strVeri = Replace(strVeri, " insert ", " ins&#101;rt ", 1, -1, 1)
	strVeri = Replace(strVeri, " delete ", " del&#101;te ", 1, -1, 1)
	strVeri = Replace(strVeri, " update ", " up&#100;ate ", 1, -1, 1)
	strVeri = Replace(strVeri, " like ", " lik&#101; ", 1, -1, 1)
	strVeri = Replace(strVeri, " drop ", " dro&#112; ", 1, -1, 1)
	strVeri = Replace(strVeri, " create ", " cr&#101;ate ", 1, -1, 1)
	strVeri = Replace(strVeri, " modify ", " mod&#105;fy ", 1, -1, 1)
	strVeri = Replace(strVeri, " rename ", " ren&#097;me ", 1, -1, 1)
	strVeri = Replace(strVeri, " alter ", " alt&#101;r ", 1, -1, 1)
	strVeri = Replace(strVeri, " cast ", " ca&#115;t ", 1, -1, 1)
	Temizle = Trim(strVeri)
End Function
'######################################################################################################################################
Function dbDatetime2(dt) 	'database datetime formatı
	dt = Replace(dt, "T", " ")
	if InStr(dt, "+") > 0 Then 
		Dim tmpDt : tmpDt = Split(dt, "+")
		dt = tmpDt(0)
	End if
	dbDatetime2 = year(dt) &""& right("0" & month(dt), 2) &""& right("0" & day(dt),2) & "" &right("0" & Hour(dt), 2)&""&right("0" & Minute(dt), 2)&""&right("0" & Second(dt), 2)
End Function 
'######################################################################################################################################
Function dbDatetime(dt) 	'database datetime formatı
	dt = Replace(dt, "T", " ")
	if InStr(dt, "+") > 0 Then 
		Dim tmpDt : tmpDt = Split(dt, "+")
		dt = tmpDt(0)
	End if
	dbDatetime = year(dt) &"-"& right("0" & month(dt), 2) &"-"& right("0" & day(dt),2) & "T" &right("0" & Hour(dt), 2)&":"&right("0" & Minute(dt), 2)&":"&right("0" & Second(dt), 2)
End Function 
'######################################################################################################################################
Function dbDate(dt) 	'database date formatı
	dbDate = year(dt) &"-"& right("0" & month(dt), 2) &"-"& right("0" & day(dt),2)
End Function 
'######################################################################################################################################
function ilkbuyuk(str)		' ilk harf büyük gerisi küçük
    if isnull(str) then exit function
	On Error resume Next
		Dim ilkharf, kalanharf
			ilkharf=left(str,1)
		  ilkharf = Replace(ilkharf, "a", "A") 
		  ilkharf = Replace(ilkharf, "b", "B") 
		  ilkharf = Replace(ilkharf, "c", "C") 
		  ilkharf = Replace(ilkharf, "ç", "Ç") 
		  ilkharf = Replace(ilkharf, "d", "D") 
		  ilkharf = Replace(ilkharf, "e", "E") 
		  ilkharf = Replace(ilkharf, "f", "F") 
		  ilkharf = Replace(ilkharf, "g", "G") 
		  ilkharf = Replace(ilkharf, "ğ", "Ğ") 
		  ilkharf = Replace(ilkharf, "h", "H") 
		  ilkharf = Replace(ilkharf, "ı", "I") 
		  ilkharf = Replace(ilkharf, "i", "İ") 
		  ilkharf = Replace(ilkharf, "j", "J") 
		  ilkharf = Replace(ilkharf, "k", "K") 
		  ilkharf = Replace(ilkharf, "l", "L") 
		  ilkharf = Replace(ilkharf, "m", "M") 
		  ilkharf = Replace(ilkharf, "n", "N") 
		  ilkharf = Replace(ilkharf, "o", "O") 
		  ilkharf = Replace(ilkharf, "ö", "Ö") 
		  ilkharf = Replace(ilkharf, "p", "P") 
		  ilkharf = Replace(ilkharf, "q", "Q") 
		  ilkharf = Replace(ilkharf, "r", "R") 
		  ilkharf = Replace(ilkharf, "s", "S") 
		  ilkharf = Replace(ilkharf, "ş", "Ş") 
		  ilkharf = Replace(ilkharf, "t", "T") 
		  ilkharf = Replace(ilkharf, "u", "U") 
		  ilkharf = Replace(ilkharf, "ü", "Ü") 
		  ilkharf = Replace(ilkharf, "v", "V") 
		  ilkharf = Replace(ilkharf, "w", "W") 
		  ilkharf = Replace(ilkharf, "x", "X") 
		  ilkharf = Replace(ilkharf, "y", "Y") 
		  ilkharf = Replace(ilkharf, "z", "Z") 
			kalanharf=right(str,len(str)-1)
		  kalanharf = Replace(kalanharf, "A", "a") 
		  kalanharf = Replace(kalanharf, "B", "b") 
		  kalanharf = Replace(kalanharf, "C", "c") 
		  kalanharf = Replace(kalanharf, "Ç", "ç") 
		  kalanharf = Replace(kalanharf, "D", "d") 
		  kalanharf = Replace(kalanharf, "E", "e") 
		  kalanharf = Replace(kalanharf, "F", "f") 
		  kalanharf = Replace(kalanharf, "G", "g") 
		  kalanharf = Replace(kalanharf, "Ğ", "ğ") 
		  kalanharf = Replace(kalanharf, "H", "h") 
		  kalanharf = Replace(kalanharf, "I", "ı") 
		  kalanharf = Replace(kalanharf, "İ", "i") 
		  kalanharf = Replace(kalanharf, "J", "j") 
		  kalanharf = Replace(kalanharf, "K", "k") 
		  kalanharf = Replace(kalanharf, "L", "l") 
		  kalanharf = Replace(kalanharf, "M", "m") 
		  kalanharf = Replace(kalanharf, "N", "n") 
		  kalanharf = Replace(kalanharf, "O", "o") 
		  kalanharf = Replace(kalanharf, "Ö", "ö") 
		  kalanharf = Replace(kalanharf, "P", "p") 
		  kalanharf = Replace(kalanharf, "Q", "q") 
		  kalanharf = Replace(kalanharf, "R", "r") 
		  kalanharf = Replace(kalanharf, "S", "s") 
		  kalanharf = Replace(kalanharf, "Ş", "ş") 
		  kalanharf = Replace(kalanharf, "T", "t") 
		  kalanharf = Replace(kalanharf, "U", "u") 
		  kalanharf = Replace(kalanharf, "Ü", "ü") 
		  kalanharf = Replace(kalanharf, "V", "v") 
		  kalanharf = Replace(kalanharf, "W", "w") 
		  kalanharf = Replace(kalanharf, "X", "x") 
		  kalanharf = Replace(kalanharf, "Y", "y") 
		  kalanharf = Replace(kalanharf, "Z", "z") 
			ilkbuyuk = ilkharf&kalanharf
End function
'######################################################################################################################################
Function Buyut(strBaslik) 	' hepsini büyük harfe çevirir
	strBaslik = Replace(strBaslik, "a", "A") 
	strBaslik = Replace(strBaslik, "b", "B") 
	strBaslik = Replace(strBaslik, "c", "C") 
	strBaslik = Replace(strBaslik, "ç", "Ç") 
	strBaslik = Replace(strBaslik, "d", "D") 
	strBaslik = Replace(strBaslik, "e", "E") 
	strBaslik = Replace(strBaslik, "f", "F") 
	strBaslik = Replace(strBaslik, "g", "G") 
	strBaslik = Replace(strBaslik, "ğ", "Ğ") 
	strBaslik = Replace(strBaslik, "h", "H") 
	strBaslik = Replace(strBaslik, "ı", "I") 
	strBaslik = Replace(strBaslik, "i", "İ") 
	strBaslik = Replace(strBaslik, "j", "J") 
	strBaslik = Replace(strBaslik, "k", "K") 
	strBaslik = Replace(strBaslik, "l", "L") 
	strBaslik = Replace(strBaslik, "m", "M") 
	strBaslik = Replace(strBaslik, "n", "N") 
	strBaslik = Replace(strBaslik, "o", "O") 
	strBaslik = Replace(strBaslik, "ö", "Ö") 
	strBaslik = Replace(strBaslik, "p", "P") 
	strBaslik = Replace(strBaslik, "q", "Q") 
	strBaslik = Replace(strBaslik, "r", "R") 
	strBaslik = Replace(strBaslik, "s", "S") 
	strBaslik = Replace(strBaslik, "ş", "Ş") 
	strBaslik = Replace(strBaslik, "t", "T") 
	strBaslik = Replace(strBaslik, "u", "U") 
	strBaslik = Replace(strBaslik, "ü", "Ü") 
	strBaslik = Replace(strBaslik, "v", "V") 
	strBaslik = Replace(strBaslik, "w", "W") 
	strBaslik = Replace(strBaslik, "x", "X") 
	strBaslik = Replace(strBaslik, "y", "Y") 
	strBaslik = Replace(strBaslik, "z", "Z") 
	Buyut = strBaslik 
End Function 
'######################################################################################################################################
Function Kucult(strBaslik) 	' hepsini büyük harfe çevirir
	strBaslik = Replace(strBaslik, "A", "a") 
	strBaslik = Replace(strBaslik, "B", "b") 
	strBaslik = Replace(strBaslik, "C", "c") 
	strBaslik = Replace(strBaslik, "Ç", "ç") 
	strBaslik = Replace(strBaslik, "D", "d") 
	strBaslik = Replace(strBaslik, "E", "e") 
	strBaslik = Replace(strBaslik, "F", "f") 
	strBaslik = Replace(strBaslik, "G", "g") 
	strBaslik = Replace(strBaslik, "Ğ", "ğ") 
	strBaslik = Replace(strBaslik, "H", "h") 
	strBaslik = Replace(strBaslik, "I", "ı") 
	strBaslik = Replace(strBaslik, "İ", "i") 
	strBaslik = Replace(strBaslik, "J", "j") 
	strBaslik = Replace(strBaslik, "K", "k") 
	strBaslik = Replace(strBaslik, "L", "l") 
	strBaslik = Replace(strBaslik, "M", "m") 
	strBaslik = Replace(strBaslik, "N", "n") 
	strBaslik = Replace(strBaslik, "O", "o") 
	strBaslik = Replace(strBaslik, "Ö", "ö") 
	strBaslik = Replace(strBaslik, "P", "p") 
	strBaslik = Replace(strBaslik, "Q", "q") 
	strBaslik = Replace(strBaslik, "R", "r") 
	strBaslik = Replace(strBaslik, "S", "s") 
	strBaslik = Replace(strBaslik, "Ş", "ş") 
	strBaslik = Replace(strBaslik, "T", "t") 
	strBaslik = Replace(strBaslik, "U", "u") 
	strBaslik = Replace(strBaslik, "Ü", "ü") 
	strBaslik = Replace(strBaslik, "V", "v") 
	strBaslik = Replace(strBaslik, "W", "w") 
	strBaslik = Replace(strBaslik, "X", "x") 
	strBaslik = Replace(strBaslik, "Y", "y") 
	strBaslik = Replace(strBaslik, "Z", "z") 
	Kucult = strBaslik 
End Function 
'######################################################################################################################################
Function generatePassword(passwordLength,rakam,harf)
	'Declare variables
	Dim sDefaultChars
	Dim iCounter
	Dim sMyPassword
	Dim iPickedChar
	Dim iDefaultCharactersLength
	Dim iPasswordLength
	'Initialize variables
	sDefaultChars=""
	if rakam=1 then sDefaultChars=sDefaultChars&"0123456789"
	if harf=1 then sDefaultChars=sDefaultChars&"abcdefghijklmnopqrstuvxyzABCDEFGHIJKLMNOPQRSTUVXYZ"
	'sDefaultChars="abcdefghijklmnopqrstuvxyzABCDEFGHIJKLMNOPQRSTUVXYZ0123456789"
	iPasswordLength=passwordLength
	iDefaultCharactersLength = Len(sDefaultChars)
	Randomize'initialize the random number generator
	'Loop for the number of characters password is to have
	For iCounter = 1 To iPasswordLength
	'Next pick a number from 1 to length of character set
	iPickedChar = Int((iDefaultCharactersLength * Rnd) + 1)
	'Next pick a character from the character set using the random number iPickedChar
	'and Mid function
	sMyPassword = sMyPassword & Mid(sDefaultChars,iPickedChar,1)
	Next
	generatePassword = sMyPassword
End Function
'######################################################################################################################################
Function RevertHtml(html)
	html = Replace(html, "&Uuml;", "Ü")
	html = Replace(html, "&Ccedil;", "Ç")
	html = Replace(html, "&Ouml;", "Ö")
	html = Replace(html, "&uuml;", "ü")
	html = Replace(html, "&ccedil;", "ç")
	html = Replace(html, "&ouml;", "ö")
	html = Replace(html, "<tr></tr>", "")
	html = Replace(html, "<br>", "<br>" & chr(13) & chr(10))
	html = Replace(html, "</td><tr", "</td></tr")
	RevertHtml = html
End Function
'######################################################################################################################################
function arraySort( arToSort, sortBy, compareType )

    Dim c, d, e, smallestValue, smallestIndex, tempValue

    For c = 0 To uBound( arToSort, 2 ) - 1

    smallestValue = arToSort( sortBy, c )
    smallestIndex = c

    For d = c + 1 To uBound( arToSort, 2 )
    if compareType = "Text" then
    if strComp( arToSort( sortBy, d ), smallestValue ) < 0 Then
    smallestValue = arToSort( sortBy, d )
    smallestIndex = d
    End if

    elseif compareType = "Date" then
    if not isDate( smallestValue ) then
    arraySort = arraySort( arToSort, sortBy, false)
    exit function

    else
    if dateDiff( "d", arToSort( sortBy, d ), smallestValue ) > 0 Then
    smallestValue = arToSort( sortBy, d )
    smallestIndex = d
    End if

    end if
    elseif compareType = "Number" then
    if cint( arToSort( sortBy, d ) ) < cint(smallestValue) Then
    smallestValue = arToSort( sortBy, d )
    smallestIndex = d
    End if
    end if

    Next

    if smallestIndex <> c Then 'swap
    For e = 0 To uBound( arToSort, 1 )
    tempValue = arToSort( e, smallestIndex )
    arToSort( e, smallestIndex ) = arToSort( e, c )
    arToSort( e, c ) = tempValue
    Next
    End if

    Next

    arraySort = arToSort 
end function
'######################################################################################################################################
Function CleanSQL(str)
    If str = "" Then Exit Function
    'str = Replace(str, "<", "&lt;")
	'str = Replace(str, ">", "&gt;")
	str = Replace(str, "[", "&#091;")
	str = Replace(str, "]", "&#093;")
	'str = Replace(str, """", "", 1, -1, 1)
	'str = Replace(str, "=", "&#061;", 1, -1, 1)
	str = Replace(str, "'", "`", 1, -1, 1)
	str = Replace(str, " select ", " sel&#101;ct ", 1, -1, 1)
	str = Replace(str, " join ", " jo&#105;n ", 1, -1, 1)
	str = Replace(str, " union ", " un&#105;on ", 1, -1, 1)
	str = Replace(str, " where ", " wh&#101;re ", 1, -1, 1)
	str = Replace(str, " insert ", " ins&#101;rt ", 1, -1, 1)
	str = Replace(str, " delete ", " del&#101;te ", 1, -1, 1)
	str = Replace(str, " update ", " up&#100;ate ", 1, -1, 1)
	str = Replace(str, " like ", " lik&#101; ", 1, -1, 1)
	str = Replace(str, " drop ", " dro&#112; ", 1, -1, 1)
	str = Replace(str, " create ", " cr&#101;ate ", 1, -1, 1)
	str = Replace(str, " modify ", " mod&#105;fy ", 1, -1, 1)
	str = Replace(str, " rename ", " ren&#097;me ", 1, -1, 1)
	str = Replace(str, " alter ", " alt&#101;r ", 1, -1, 1)
	str = Replace(str, " cast ", " ca&#115;t ", 1, -1, 1)
	CleanSQL = Trim(str)
End Function
'######################################################################################################################################
Function retSQLVal(sqlQuery)
    Dim frs, fSQL, fRetVal
    Set frs = ba.Execute(sqlQuery)
        if Not frs.eof Then fRetVal = frs(0).Value
    Set frs = Nothing
    retSQLVal = fRetVal
End Function
'######################################################################################################################################
Function sortArrayMulti(byref ArrTmp, ordPlace, so) 
    ''so: sortorder "ASC" or "DESC"
    Dim j, i, k, orderVal, x
    Redim arrRet(Ubound(ArrTmp, 1), Ubound(ArrTmp, 2))
    for j = 0 To Ubound(ArrTmp, 2)
        orderVal = ArrTmp(ordPlace, j)
        if j = 0 Then
            for i = 0 to Ubound(ArrTmp, 1)
                arrRet(i, j) = ArrTmp(i, j)
            next
        else
            for k = 0 to Ubound(arrRet, 2)
                if isEmpty(arrRet(0, k)) then
                    for i = 0 to Ubound(arrRet, 1)
                        arrRet(i, k) = ArrTmp(i, j)
                    next
                    exit for
                else
                    if so = "ASC" then
                        if orderVal <= arrRet(ordPlace, k) then
                            for x = Ubound(arrRet, 2) to k + 1 step -1
                                for i = 0 to Ubound(arrRet, 1)
                                    arrRet(i, x) = arrRet(i, x - 1)
                                next
                            next
                            for i = 0 to Ubound(arrRet, 1)
                                arrRet(i, k) = ArrTmp(i, j)
                            next
                            exit for
                        end if
                    else
                        if orderVal >= arrRet(ordPlace, k) then
                            for x = Ubound(arrRet, 2) to k + 1 step -1
                                for i =  Ubound(arrRet, 1) to 0 step -1
                                    arrRet(i, x) = arrRet(i, x - 1)
                                next
                            next
                            for i = 0 to Ubound(arrRet, 1)
                                arrRet(i, k) = ArrTmp(i, j)
                            next
                            exit for
                        end if
                    end if
                end if
            next
        end if
    next
    sortArrayMulti = arrRet
End Function
'######################################################################################################################################
Function IIf( expr, truepart, falsepart )
   IIf = falsepart
   If expr Then IIf = truepart
End Function
'######################################################################################################################################
Function TryToInt(x)
    if IsNull(x) Or IsEmpty(x) Then x = 0
    TryToInt = CInt(x)
End Function
'######################################################################################################################################
Function DateDiff2(t1, t2, intyear, intmonth, intday)
    Dim result : result = ""
    Dim f, tt
    if IsDate(t1) And IsDate(t2) Then
        if CDate(t1) <= CDate(t2) Then
            tt = t1
            For f = 0 To DateDiff("yyyy", t1, t2)
                intyear = intyear + 1
            Next
            intyear = intyear - 1

            if CDate(dbDate(DateAdd("yyyy", intyear, t1))) > CDate(t2) Then
                intyear = intyear - 1
            end if
            tt = DateAdd("yyyy", intyear, t1)
            



            For f = 0 To DateDiff("m",  DateAdd("yyyy", intyear, t1), t2)
                intmonth = intmonth + 1
            Next
            intmonth = intmonth - 1
            if CDate(DateAdd("m", intmonth, tt)) > CDate(t2) Then intmonth = intmonth - 1
            tt = DateAdd("m", intmonth, tt)
            

            For f = 0 To DateDiff("d",  tt, t2)
                intday = intday + 1
            Next
            intday = intday - 1

    
            if intyear > 0 Then result = " " & intyear & " yıl"
            if intmonth > 0 Then result = result & " " & intmonth & " ay" 
            if intday > 0 Then result = result & " " & intday & " gün"
            'result = intyear & " yil " & intmonth & " ay " & intday & " gun "

        End if
    End if
    DateDiff2 = Trim(result)
End Function
'######################################################################################################################################
Function fineDateDiff(t1, t2)
    Dim result, intyear, intmonth, intday, f
    result = ""
    if IsDate(t1) And IsDate(t2) Then
        if CDate(t1) <= CDate(t2) Then
            f =t1
            Do Until DateDiff("d", f, t2) < 0
                if DateDiff("d", (DateAdd("yyyy", 1, f)) , t2) => 0 Then
                    f = DateAdd("yyyy", 1, f)
                    intyear = intyear + 1
                Else
                    if DateDiff("d", DateAdd("m", 1, f), t2) => 0 Then
                        f = DateAdd("m", 1, f)
                        intmonth = intmonth + 1
                    Else
                        if DateDiff("d", DateAdd("d", 1, f), t2) => 0 Then
                            f = DateAdd("d", 1, f)
                            intday = intday + 1
                        Else    
                            Exit Do
                        End if
                    End if
                End if
            Loop
           
            if intyear > 0 Then result = " " & intyear & " yıl"
            if intmonth > 0 Then result = result & " " & intmonth & " ay" 
            if intday > 0 Then result = result & " " & intday & " gün"
        End if
    End if
    fineDateDiff = result
End Function
'######################################################################################################################################
Function fineDateDiff_ESKI(t1, t2)
    Dim result, intyear, intmonth, intday, f
    result = ""
    if IsDate(t1) And IsDate(t2) Then
        if CDate(t1) <= CDate(t2) Then
            
            For f = 0 To DateDiff("yyyy", t1, t2)
                intyear = intyear + 1
            Next
            intyear = intyear - 1
            if DateDiff("d", DateAdd("yyyy", intyear, t1),  t2) < 0 Then
                intyear = intyear - 1
            End if
            For f = 0 To DateDiff("m",  DateAdd("yyyy", intyear, t1), t2)
                intmonth = intmonth + 1
            Next
            
            intmonth = intmonth - 1
            For f = 0 To DateDiff("d",  DateAdd("m", intmonth, DateAdd("yyyy", intyear, t1)), t2)
                intday = intday + 1
            Next
            intday = intday - 1

    
            if intyear > 0 Then result = " " & intyear & " yıl"
            if intmonth > 0 Then result = result & " " & intmonth & " ay" 
            if intday > 0 Then result = result & " " & intday & " gün"
        End if
    End if
    fineDateDiff = result
End Function
'######################################################################################################################################
%>