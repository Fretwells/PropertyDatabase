CREATE PROCEDURE ww_Insert_Neighborhood
@N_Name varchar(30)
AS

BEGIN TRANSACTION T1
INSERT INTO tblNEIGHBORHOOD (NeighborhoodName)
VALUES (@N_Name)
GO

INSERT INTO tblNEIGHBORHOOD (NeighborhoodName)
VALUES
('U District'),
('Roosevelt'),
('Northlake'),
('Green Lake'),
('Capitol Hill'),
('Pike-Market'),
('Eastlake')
GO

Exec dbo.ww_Insert_Neighborhood
  "Ada"
Go
