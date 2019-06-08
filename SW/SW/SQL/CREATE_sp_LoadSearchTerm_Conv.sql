CREATE PROCEDURE [dbo].[sp_LoadSearchTerm_Conv]
AS

---Load SearchTerm_Conversion table

DECLARE @ST_COUNT		INT
DECLARE @Current_ST		INT
DECLARE @ST				VARCHAR (500)
DECLARE @ST_CharTotal	INT
DECLARE @ST_CurrentChar	INT

SET @ST_COUNT = (SELECT MAX(SearchTerm_ID) FROM SoftWriters.dbo.SearchTerm)
SET @Current_ST = 1

SET @ST = (SELECT SearchTerm FROM SoftWriters.dbo.SearchTerm WHERE @Current_ST = SearchTerm_ID)
SET @ST_CurrentChar = 1

SET @ST_CharTotal = LEN(@ST)

TRUNCATE TABLE SoftWriters.dbo.SearchTerm_Conversion

WHILE @Current_ST <= @ST_COUNT
BEGIN

SET @ST = (SELECT SearchTerm FROM SoftWriters.dbo.SearchTerm WHERE @Current_ST = SearchTerm_ID)
SET @ST_CharTotal = LEN(@ST)
SET @ST_CurrentChar = 1

	WHILE @ST_CurrentChar <= @ST_CharTotal
	BEGIN
		INSERT INTO SoftWriters.dbo.SearchTerm_Conversion (SearchTerm_ID,SearchTerm_ASCII)
		SELECT @Current_ST,
			CASE
				WHEN ASCII(SUBSTRING(UPPER(@ST),@ST_CurrentChar,1)) = 49 THEN 91
				WHEN ASCII(SUBSTRING(UPPER(@ST),@ST_CurrentChar,1)) = 50 THEN 92
				WHEN ASCII(SUBSTRING(UPPER(@ST),@ST_CurrentChar,1)) = 51 THEN 93
				WHEN ASCII(SUBSTRING(UPPER(@ST),@ST_CurrentChar,1)) = 52 THEN 94
				WHEN ASCII(SUBSTRING(UPPER(@ST),@ST_CurrentChar,1)) = 48 THEN 58
				ELSE ASCII(SUBSTRING(UPPER(@ST),@ST_CurrentChar,1))
			END

		SELECT @ST_CurrentChar = @ST_CurrentChar + 1
	END


SELECT @Current_ST = @Current_ST + 1

END


