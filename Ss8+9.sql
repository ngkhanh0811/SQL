use AdventureWorks2019

--Session 8
--vd1
select LEFT('International', 5)

--vd2
use AdventureWorks2019
select * from HumanResources.Employee
go

--vd3 
use AdventureWorks2019
select LocationID, CostRate from Production.Location
go

--vd4 
use AdventureWorks2019
select Name + ':'+CountryRegionCode+'->' + [Group] from Sales.SalesTerritory
go

--vd5 
use AdventureWorks2019
select name + ':'+CountryRegionCode +'->' +[Group] as NameRegionGroup from Sales.SalesTerritory
go

--vd6
use AdventureWorks2019
select ModifiedDate as 'ChangedDate' from Person.Person
go

--vd7
use AdventureWorks2019
select ProductID, StandardCost, StandardCost * 0.15 as Discount from Production.ProductCostHistory
go

--vd8
use AdventureWorks2019
select distinct StandardCost from Production.ProductCostHistory
go

--vd9
use AdventureWorks2019
select ProductModelID, Name into Production.ProductName from Production.ProductModel
go

--vd10
use AdventureWorks2019
select * from Production.ProductCostHistory where EndDate='2012-05-29 00:00:00'
go

--vd11
use AdventureWorks2019
select * from Person.Address where City = 'Bothell'
go

--vd12
use AdventureWorks2019
select * from HumanResources.Department where DepartmentID<10
go

--vd13
use AdventureWorks2019
select * from Person.Address where AddressID > 900 and City='Seattle'
go

--vd14
use AdventureWorks2019
select * from Person.Address where AddressID > 900 or City='Seattle'
go

--vd15
use AdventureWorks2019
select * from Person.Address where not AddressID=5
go

--vd16
use AdventureWorks2019
select WorkOrderID, sum(ActualResourceHrs) from Production.WorkOrderRouting group by WorkOrderID
go

--vd17
use AdventureWorks2019
select WorkOrderID, sum(ActualResourceHrs) as Sum_ActualResourceHrs from Production.WorkOrderRouting group by WorkOrderID having WorkOrderID < 50
go

--vd18 
use AdventureWorks2019
select * from Sales.SalesTerritory order by SalesLastYear
go

--vd19
create table Person.PhoneBilling (Bill_ID int primary key, MobileNumber bigint unique, CallDetails xml)
go

--vd20
use AdventureWorks2019
insert into Person.PhoneBilling values (100, 9833276605, '<Info><Call>Local</Call><Time>45 minutes</Time><Charges>200</Charges></Info>')
select CallDetails from Person.PhoneBilling
go

--vd21
use AdventureWorks2019
declare @xmlvar xml
select @xmlvar='<Employee name="Joan"/>'

--vd22
create xml schema collection SoccerSchemaCollection 
as N'<xsd : schema xmlns : xds ="http://www.w3.org/2001/Schema">
<xsd : element name = "MatchDetails">
<xsd : complexType>
<xsd : complexContent>
<xsd : restriction base = "xsd : anyType">
<xsd : sequence>
<xsd : element name ="Team" minOccurs="0" maxOccurs="unbounded">
<xsd : complexType>
<xsd : complexContent>
<xsd : restriction base = "xsd : anyType">
<xsd : sequence/>
<xsd : attribute name="country" type "xsd : string"/>
<xsd : attribute name="score" type "xsd : string"/>
<xsd : restrition>
<xsd : complexContent>
<xsd : complexType>
<xsd : sequence>
<xsd : restriction>
<xsd : complexContent>
<xsd : complexType>
<xsd : element>
<xsd : schema>'
go

--vd23
create table SoccerTeam (TeamID int identity not null, TeamInfo xml (SoccerSchemaCollection) )

--vd24
insert into SoccerTeam(TeamInfo) values ('<MatchDetails><TeamCountry="VietNam" score="3"><TeamCountry="Zimbabwe" score="2"</Team></MatchDetails>')

--vd25
declare @team xml (SoccerSchemaColection)
set @team ='<MatchDetails><TeamCountry="VietNam"></TeamCountry></MatchDetails>'
select @team
go

--Session 9
select WorkOrderID, sum(ActualResourceHrs) as TotalHourPerWorkOrder from Production.WorkOrderRouting group by WorkOrderID

--vd2
select WorkOrderId, sum(ActualResourceHrs) as TotalHourPerWorkOrder from Production.WorkOrderRouting where WorkOrderID<50 group by WorkOrderID

--vd3
select Class, avg(ListPrice) as 'AverageListPrice' from Production.Product group by Class

--vd4
select [Group], sum(SalesYTD) as 'TotalSales' from Sales.SalesTerritory where [Group] like 'N%' or [Group] like 'E%' group by All[Group]

--vd5
select [Group], sum(SalesYTD) as 'TotalSales' from Sales.SalesTerritory where [Group] like 'P%' group by all [Group] having sum(SalesYTD) < 6000000

--vd6
select Name, CountryRegionCode, sum(SalesYTD) as TotalSales from Sales.SalesTerritory where Name <> 'Australia' and Name <> 'Canada' group by Name, CountryRegionCode with cube

--vd7
select Name, CountryRegionCode, sum(SalesYTD) as TotalSales from Sales.SalesTerritory where Name <> 'Australia' and Name <> 'Canada' group by Name, CountryRegionCode with Rollup

--vd8
select avg(UnitPrice) as AvgUnitPrice, min(OrderQty) as MinQty, max([UnitPriceDiscount]) as MaxDiscount from Sales.SalesOrderDetail;

--vd9
select SalesOrderID, avg(UnitPrice) as AvgPrice from Sales.SalesOrderDetail;

--vd10
select min(OrderDate) as Earliest, max(OrderDate) as Latest from Sales.SalesOrderHeader;

--vd11
select geometry :: Point (251, 1, 4326).STUnion(geometry :: Point (252, 2, 4326) );

--vd12
declare @City1 geography 
set @City1 = geography :: STPolyFromText (
'POLYGON(175.3-41.5, 178.3-37.9, 172.8-34.6, 174.3-41.5))', 4326)
declare @City2 geography
set @City2 = geography :: STPolyFromText (
'POLYGON(169.3-46.6, 174.3-41.6, 172.5-40.7, 166.3-45.8, 169.3-46.6))', 4326)
declare @CombinedCity geography = @City1.STUnion (@City2)
select @CombinedCity

--vd13 
select Geography :: UnionAggregate (SpatialLocation) as AVGLocation from Person.Address where City='London';

--vd14
select Geography :: EnvelopAggregate (SpatialLocation) as Location from Person.Address where City = 'London';

--vd15
declare @CollectionDemo Table (
shape geometry, shapeType nvarchar(50)
)
insert into @CollectionDemo (shape, shapeType) values ('CURVEPOLYGON(
CIRCULARSTRING(2 3, 4 1, 6 3, 4 5, 2 3))', 'Circle'), ('POLYGON((1 1, 4 1, 4 5, 1 5, 1 1))', 'Rectangle)';
select geometry :: CollectionAggregate (shape) from @CollectionDemo;

--vd16
select geography::ConvexHullAggregate (SpatialLocation) as Location from Person.Address where City='London'

--vd17
select DueDate, ShipDate from Sales.SalesOrderHeader where Sales.SalesOrderHeader.OrderDate = (select max (OrderDate) from Sales.SalesOrderHeader)

--vd18
select FirstName , LastName from Person.Person
where Person.Person.BusinessEntityID in (select BusinessEntityID from HumanResources.Employee where JobTitle = 'Research and Development Manager');

--vd19
select FirstName, LastName from Person.Person as A where exists (select * from HumanResources.Employee as B where JobTitle='Research and Development Manager' 
and A.BusinessEntityID=B.BusinessEntityID);

--vd20
select LastName, FirstName from Person.Person where BusinessEntityID in (
select BusinessEntityID from Sales.SalesPerson where TerritoryID in 
(select TerritoryID from Sales.SalesTerritory where Name = 'Canada')
) 

--vd21
select e.BussinessEntityID from Person.BusinessEntityContact e Where e.ContactTypeID in (
select c.ContactTypeID from Person.ContactType c where YEAR (e.ModifiedDate)>=2012
)

--vd22
select A.FirstName, A.LastName, B.JobTitle
from Person.Person A
JOIN 
HumanResources.EmployeeB ON 
A.BusinessEntityID = B.BussinessEntityID;