CREATE PROCEDURE ww_Insert_Neighborhood
@N_Name varchar(30)
AS

BEGIN TRANSACTION T1
INSERT INTO tblNEIGHBORHOOD (NeighborhoodName)
VALUES (@N_Name)
GO

Exec dbo.ww_Insert_Neighborhood
  'U District'
GO
Exec dbo.ww_Insert_Neighborhood
  'Roosevelt'
GO
Exec dbo.ww_Insert_Neighborhood
  'Northlake'
GO
Exec dbo.ww_Insert_Neighborhood
  'Green Lake'
GO
Exec dbo.ww_Insert_Neighborhood
  'Capitol Hill'
GO
Exec dbo.ww_Insert_Neighborhood
  'Pike-Market'
GO
Exec dbo.ww_Insert_Neighborhood
  'Eastlake'
GO
Exec dbo.ww_Insert_Neighborhood
  "Ada"
Go
