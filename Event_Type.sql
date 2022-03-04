CREATE PROCEDURE anthony_insert_eventType
@EvtName varchar(50),
@EvtDescr varchar(500)

AS
BEGIN TRANSACTION H1
INSERT INTO tblEVENT_TYPE(EventTypeName, EventTypeDescr)
VALUES (@EvtName, @EvtDescr)

COMMIT TRANSACTION H1
GO

EXECUTE anthony_insert_eventType
@EvtName = 'Purchase property',
@EvtDescr = 'The buyer choose to purchase a property, which mean that the money will be payed upfront in full.'
go

EXECUTE anthony_insert_eventType
@EvtName = 'Rent property',
@EvtDescr = 'The renter choose to rent a property, which means that the rent will be payed every month at a specific deadline, the rent for that month must be payed in full'
go

EXECUTE anthony_insert_eventType
@EvtName = 'Become Lister',
@EvtDescr = 'The person must provide their person details and contact infromation when listing a property. Each become lister event must only correspond with one property'
go

EXECUTE anthony_insert_eventType
@EvtName = 'List for purchase',
@EvtDescr = 'The property is listed for purchasing.'

Select *
from tblEVENT_TYPE
go
