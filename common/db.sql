--SELECT * FROM Definitions.Bar

--SELECT AccessToken FROM Web.AccessTokens WHERE isValid=1

SELECT userId AS id FROM Web.AccessTokens WHERE accessToken='ACCESSTOKENHERE' AND isValid=1 AND DATEDIFF(MINUTE, GETDATE(), validTru) > 0