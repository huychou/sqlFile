
---1.viết một hàm để tìm những bảng có cột tên là @param nào đó
CREATE FUNCTION SearchTable ( @tencot NVARCHAR(50) )
	RETURNS table
	AS  
	RETURN 
		SELECT TABLE_NAME
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE COLUMN_NAME = @tencot
GO
----
SELECT * FROM SearchTable('value1')
GO


---2. Làm cách nào để update bảng và chỉ set những giá trị chưa có (is null), những giá trị có rồi ko bị ảnh hưởng?
UPDATE [User]
SET id_r  = 'ab'
WHERE id_r  IS NULL;

GO
---3. Thử đề nghị 1 cách nhanh nhất để kiểm tra xem một column của một bảng có duy nhất hay ko

SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME='duynhat' AND CONSTRAINT_TYPE = 'UNIQUE'
GO

SELECT * 
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tb 
    inner join INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE col 
        on col.CONSTRAINT_NAME = tb.CONSTRAINT_NAME 
WHERE 
    tb.CONSTRAINT_TYPE = 'UNIQUE'
    and tb.TABLE_NAME = 'duynhat'
    and col.COLUMN_NAME = 'tenduynhat'
GO


---4. Viết hàm trả về ngày random, thông số đầu vào là ngày bắt đầu và ngày kết thúc----
CREATE VIEW dbo.GetNewID
AS
SELECT NewId() AS [NewID]
GO


CREATE FUNCTION RandomDate ( @ngaybd DATE, @ngaykt DATE )
	RETURNS DATE 
	AS  
	begin  
		DECLARE @ngaybatky DATE; 

		 SELECT   @ngaybatky = DATEADD(DAY,ABS(CHECKSUM((SELECT [NewId] FROM GetNewID))) % ( 1 + DATEDIFF(DAY,@ngaybd,@ngaykt)),@ngaybd);
   
	   RETURN  @ngaybatky;
	END
GO
----
SELECT dbo.RandomDate('2014-12-1','2014-12-10') AS NgayBatKy
GO

---5. A có một schema hoặc một db, làm cách nào để tìm tất cả các bảng trong schema hoặc csdl đó (ra danh sách). 
SELECT TABLE_NAME 
FROM  db_Test.INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE'
GO

SELECT TABLE_NAME 
FROM  INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'dbo'
GO



---6. Viết một hàm để backup một database bất kỳ 
CREATE PROCEDURE DBbackup

	@tendb VARCHAR(100) = '' 
	AS
	BEGIN

		DECLARE @path VARCHAR(256) 
		DECLARE @fileName VARCHAR(256)
		DECLARE @fileDate VARCHAR(20) 

		SET @path = 'D:\BK'

		-- định dạng filename
		SELECT @fileDate = CONVERT(VARCHAR(20),GETDATE(),112)

			BEGIN
				SET @fileName = @path + @tendb + '_' + @fileDate + '.BAK'
				BACKUP DATABASE @tendb TO DISK = @fileName
			END
	END
GO


EXEC [DBbackup] 'db_Test'


