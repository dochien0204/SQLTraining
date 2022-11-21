use Northwind
go

--Exercise 1
select lower(lastname + ' ' + firstname) as 'Full name',
			titleOfCourtesy
from employees;

--Exercise 2
select UPPER(lastname + ' ' + firstname) as 'Full name'
from employees;

--Exercise 3
select employeeid, lastname, firstname, title, city, country
from employees
where country = 'USA';

--Exercise 4
select customerid, companyname, contactname, contacttitle, country
from customers
where country = 'UK';

--Exercise 5
select customerid, companyname, address, city, country
from customers
where country = 'Mexico';

--Exercise 6
select customerid, companyname, phone, address, city, country
from customers
where country = 'Sweden';

--Exercise 7
select productId, productName, unitPrice, unitsInStock
from products
where unitsInStock between 5 and 10;

--Exercise 8
select productId, productName, unitprice, reorderlevel, unitsonorder
from products
where UnitsOnOrder between 60 and 100;

--Exercise 9
select Employees.EmployeeID,Employees.LastName, Employees.FirstName, Employees.Title, YEAR(Orders.OrderDate), COUNT(Orders.EmployeeID) as 'total orders'
from employees inner join orders on Employees.EmployeeID = Orders.EmployeeID
where YEAR(OrderDate) = 1996
group by Employees.EmployeeID,Employees.LastName, Employees.FirstName, Employees.Title, YEAR(Orders.OrderDate);

--Exercise 10
select Employees.EmployeeID,Employees.LastName,Employees.FirstName,Employees.City,Employees.Country, COUNT(Orders.EmployeeID) as 'total orders'
from employees inner join orders on Employees.EmployeeID = Orders.EmployeeID
where YEAR(OrderDate) = 1998
group by Employees.EmployeeID,Employees.LastName,Employees.FirstName,Employees.City,Employees.Country;

select * from orders

--Exercise 11
select Employees.EmployeeID, Employees.LastName, Employees.FirstName, Employees.HireDate, Count(Orders.OrderDate) as 'total orders'
from Employees inner join Orders on Employees.EmployeeID = Orders.EmployeeID
where Orders.OrderDate >= '1998/1/1' and Orders.OrderDate <= '1998/7/31'
group by Employees.EmployeeID, Employees.LastName, Employees.FirstName, Employees.HireDate;

--Exercise 12
select Employees.EmployeeID, Employees.LastName, Employees.FirstName, Employees.HireDate, Employees.HomePhone, Count(Orders.OrderDate) as 'total orders'
from Employees inner join Orders on Employees.EmployeeID = Orders.EmployeeID
where Orders.OrderDate >= '1997/1/1' and Orders.OrderDate <= '1997/6/30'
group by Employees.EmployeeID, Employees.LastName, Employees.FirstName, Employees.HireDate, Employees.HomePhone;

--Exercise 13
select Orders.OrderID, DAY(Orders.OrderDate) as 'OrderDay', MONTH(Orders.OrderDate) as 'OrderMonth', YEAR(Orders.OrderDate) as 'OrderYear', Orders.Freight,
		case 
			when (Orders.Freight) >=  100 then '10%'
			else '5%'
		end as 'tax', 
		case
			when (Orders.Freight) >= 100 then (10*Orders.Freight + Orders.Freight)
			else (10*Orders.Freight + Orders.Freight)
		end as 'Freight with tax'
from Orders
where Orders.OrderDate between '1996/8/1' and '1996/8/5';

--Exercise 14
select Employees.LastName + ' ' + Employees.FirstName as 'Full name',
		Employees.TitleOfCourtesy,
		case
			when (Employees.TitleOfCourtesy = 'Mr.') then 'Male'
			when (Employees.TitleOfCourtesy = 'Mrs.' or Employees.TitleOfCourtesy = 'Ms.') then 'Female'
		end as 'Sex'
from Employees;

--Exercise 15
select Employees.LastName + ' ' + Employees.FirstName as 'Full name',
		Employees.TitleOfCourtesy,
		case
			when (Employees.TitleOfCourtesy = 'Mr.' or Employees.TitleOfCourtesy = 'Dr.') then 'M'
			when (Employees.TitleOfCourtesy = 'Mrs.' or Employees.TitleOfCourtesy = 'Ms.') then 'F'
		end as 'Sex' 
		
from Employees
order by case
			when (Employees.TitleOfCourtesy = 'Mr.' or Employees.TitleOfCourtesy = 'Dr.') then 'M'
			when (Employees.TitleOfCourtesy = 'Mrs.' or Employees.TitleOfCourtesy = 'Ms.') then 'F'
			end desc;

--Exercise 16
select Employees.LastName + ' ' + Employees.FirstName as 'Full name',
		Employees.TitleOfCourtesy,
		case
			when (Employees.TitleOfCourtesy = 'Mr.') then 'Male'
			when (Employees.TitleOfCourtesy = 'Mrs.' or Employees.TitleOfCourtesy = 'Ms.') then 'Female'
			else 'Unknow'
		end as 'Sex' 
		
from Employees
order by Sex;

--Exercise 17
select Employees.LastName + ' ' + Employees.FirstName as 'Full name',
		Employees.TitleOfCourtesy,
		case
			when (Employees.TitleOfCourtesy = 'Mr.') then 1
			when (Employees.TitleOfCourtesy = 'Mrs.' or Employees.TitleOfCourtesy = 'Ms.') then 0
			else 2
		end as 'Sex' 	
from Employees
order by Sex;

--Exercise 18
select Employees.LastName + ' ' + Employees.FirstName as 'Full name',
		Employees.TitleOfCourtesy,
		case
			when (Employees.TitleOfCourtesy = 'Mr.') then 'M'
			when (Employees.TitleOfCourtesy = 'Mrs.' or Employees.TitleOfCourtesy = 'Ms.') then 'F'
			else 'N/A'
		end as 'Sex' 	
from Employees
order by Sex;

--Exercise 21
select Categories.CategoryID, Categories.CategoryName, Products.ProductID, Products.ProductName,
		DAY(Orders.OrderDate) as 'day', MONTH(Orders.OrderDate) as 'month', YEAR(Orders.OrderDate) as 'year', ([Order Details].Quantity * [Order Details].UnitPrice) as 'Revenue'
from Categories inner join Products on Categories.CategoryID = Products.CategoryID
				inner join [Order Details] on [Order Details].ProductID = Products.ProductID
				inner join Orders on Orders.OrderID = [Order Details].OrderID
where Orders.OrderDate >= '1996/7/1' and Orders.OrderDate <= '1996/7/5'
order by Categories.CategoryID, Products.ProductID desc

--Exercise 22
select Employees.EmployeeID, Employees.LastName, Employees.FirstName, Orders.OrderID, Orders.OrderDate,
		Orders.RequiredDate, Orders.ShippedDate
from Employees inner join Orders on Employees.EmployeeID = Orders.EmployeeID
where Orders.ShippedDate - Orders.RequiredDate > 7
order by Employees.EmployeeID

--Exercise 23
select Employees.LastName + ' ' + Employees.FirstName as 'CompanyName', Employees.HomePhone
from Employees
UNION
select Customers.CompanyName , Customers.Phone
from Customers
where Customers.CompanyName like 'W%'
order by CompanyName desc

--Exercise 24
select Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle
from Customers inner join Orders on Customers.CustomerID = Orders.CustomerID
where Orders.OrderID = 10643

--Exercise 25
select Products.ProductID, Products.ProductName, SUM([Order Details].Quantity) as 'Total Ordered'
from [Order Details] inner join Products on [Order Details].ProductID = Products.ProductID
group by Products.ProductID, Products.ProductName
having SUM([Order Details].Quantity) >= 1200

--Exercise 26
select Products.ProductID, Products.ProductName, Products.SupplierID, Categories.CategoryID, SUM([Order Details].Quantity) as 'Total Ordered'
from [Order Details] inner join Products on [Order Details].ProductID = Products.ProductID
						inner join Categories on Products.CategoryID = Categories.CategoryID
group by Products.ProductID, Products.ProductName, Products.SupplierID, Categories.CategoryID
having SUM([Order Details].Quantity) >= 1400

--Exercise 27
select
p.CategoryID, Categories.CategoryName, count(*) 'totals'
from Products p inner join Categories on p.CategoryID = Categories.CategoryID
group by p.CategoryID, Categories.CategoryName
HAVING count(*) = (select max(item.mycount) from (select Products.CategoryID, COUNT(Products.CategoryID) mycount
												from Products
												group by Products.CategoryID) item)

--Exercise 28
select
Categories.CategoryID, Categories.CategoryName, count(*) 
from Products p inner join Categories on p.CategoryID = Categories.CategoryID
group by Categories.CategoryID, Categories.CategoryName
HAVING count(*) = (select min(item.mycount) from (select Products.CategoryID, COUNT(Products.CategoryID) mycount
												from Products
												group by Products.CategoryID) item)

--Exercise 29
select ((select count(*) from Employees) +
		(select count(*) from Customers)) as 'total records'


--Exercise 30
select Orders.EmployeeID, Employees.FirstName, Employees.LastName, Employees.Title, COUNT(*) as 'total orders'
from Employees inner join Orders on Orders.EmployeeID = Employees.EmployeeID
group by Orders.EmployeeID, Employees.FirstName, Employees.LastName, Employees.Title
having count(*) = (select min(orders.mycount) from (select Orders.EmployeeID, COUNT(Orders.OrderDate) as 'mycount'
											from Orders
											group by Orders.EmployeeID) orders)
select * from [Order Details]

--Exercise 31
select Orders.EmployeeID, Employees.FirstName, Employees.LastName, Employees.Title, COUNT(*) as 'total orders'
from Employees inner join Orders on Orders.EmployeeID = Employees.EmployeeID
group by Orders.EmployeeID, Employees.FirstName, Employees.LastName, Employees.Title
having count(*) = (select max(orders.mycount) from (select Orders.EmployeeID, COUNT(Orders.OrderDate) as 'mycount'
											from Orders
											group by Orders.EmployeeID) orders)

--Exercise 32
select Products.ProductID, Products.ProductName, Products.SupplierID, Products.CategoryID, MAX(Products.UnitsInStock)
from Products
group by Products.ProductID, Products.ProductName, Products.SupplierID, Products.CategoryID
having MAX(Products.UnitsInStock) = (select MAX(Products.UnitsInStock)
									from Products)


--Exercise 33
select Products.ProductID, Products.ProductName, Products.SupplierID, Products.CategoryID, MAX(Products.UnitsInStock)
from Products
group by Products.ProductID, Products.ProductName, Products.SupplierID, Products.CategoryID
having MAX(Products.UnitsInStock) = (select min(Products.UnitsInStock)
									from Products)

									
--Exercise 34
select Products.ProductID, Products.ProductName, Products.SupplierID, Products.CategoryID, MAX(Products.UnitsOnOrder) 'UnitsOnOrder'
from Products
group by Products.ProductID, Products.ProductName, Products.SupplierID, Products.CategoryID
having MAX(Products.UnitsOnOrder) = (select MAX(Products.UnitsOnOrder)
									from Products);

--Exercise 35
select Products.ProductID, Products.ProductName, Products.SupplierID, Products.CategoryID, MAX(Products.ReorderLevel) 'UnitsOnOrder'
from Products
group by Products.ProductID, Products.ProductName, Products.SupplierID, Products.CategoryID
having MAX(Products.ReorderLevel) = (select MAX(Products.ReorderLevel)
									from Products)

--Exercise 36
select Orders.EmployeeID, Employees.LastName, Employees.FirstName, COUNT(*) as 'Delayed Orders'
from Employees inner join Orders on Employees.EmployeeID = Orders.EmployeeID
where Orders.RequiredDate < Orders.ShippedDate
group by Orders.EmployeeID, Employees.LastName, Employees.FirstName
having COUNT(*) = (select max(item.mycount) from (select Employees.EmployeeID ,COUNT(*) as 'mycount' from Employees inner join Orders on Employees.EmployeeID = Orders.EmployeeID
					where Orders.RequiredDate < Orders.ShippedDate
					group by Employees.EmployeeID) as item)

--Exercise 37
select Orders.EmployeeID, Employees.LastName, Employees.FirstName, COUNT(*) as 'Delayed Orders'
from Employees inner join Orders on Employees.EmployeeID = Orders.EmployeeID
where Orders.RequiredDate < Orders.ShippedDate
group by Orders.EmployeeID, Employees.LastName, Employees.FirstName
having COUNT(*) = (select min(item.mycount) from (select Employees.EmployeeID ,COUNT(*) as 'mycount' from Employees inner join Orders on Employees.EmployeeID = Orders.EmployeeID
					where Orders.RequiredDate < Orders.ShippedDate
					group by Employees.EmployeeID) as item)

--Exercise 38
select Products.ProductID, Products.ProductName, item.mycount from (
select [Order Details].ProductID, SUM([Order Details].QUANTITY) as 'mycount', ROW_NUMBER() OVER (order by SUM([Order Details].QUANTITY) desc) ROWNUM
from [Order Details]
group by [Order Details].ProductID ) item inner join Products on item.ProductID = Products.ProductID
where ROWNUM between 1 and 3
order by item.mycount asc

--Exercise 39
select Products.ProductID, Products.ProductName, item.mycount as 'Total Orders' from (
select [Order Details].ProductID, SUM([Order Details].QUANTITY) as 'mycount', ROW_NUMBER() OVER (order by SUM([Order Details].QUANTITY) desc) ROWNUM
from [Order Details]
group by [Order Details].ProductID ) item inner join Products on item.ProductID = Products.ProductID
where ROWNUM between 1 and 5
order by item.mycount asc

