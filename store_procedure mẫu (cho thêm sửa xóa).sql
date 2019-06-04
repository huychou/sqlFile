USE [csdl];
GO
/****** Object:  StoredProcedure [dbo].[Tên_của_store]    Script Date: 6/1/2018 9:36:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SProc_Name]
	@DataAction nvarchar(10), --biến thể hiện loại action (thông thường có Insert, Udate, Delete)
	@Thuoctinh_1 kieu_thuoctinh_1
	@Thuoctinh_2 kieu_thuoctinh_2
	@Thuoctinh_3 kieu_thuoctinh_3
	--
AS
 if @DataAction='INSERT'
 begin
	insert into Bảng 
	(
		[Thuoctinh_1_bang],[Thuoctinh_2_bang],--...
	)
	values
	(
		@@Thuoctinh_1, @Thuoctinh_2, @Thuoctinh_3, --...
	)
	end
if @DataAction='Update'
begin
	UPDATE [Bảng] SET
	
		[Thuoctinh_1_bang] = @Thuoctinh_1,
		--...
	WHERE
		[key_bang] = @key
end
if @DataAction='Delete'
begin
	delete from [GAApplicationDetail] where  [key_bang] = @key
end
select @key

