/*
--------------------------------------------------------------------
© 2017 sqlservertutorial.net All Rights Reserved
--------------------------------------------------------------------
Name   : BikeStores
Link   : http://www.sqlservertutorial.net/load-sample-database/
Version: 1.0
--------------------------------------------------------------------
*/
-- create schemas

create database BikeStoresDW
go

use BikeStoresDW
go

create table DimProducto(
    ProductoKey INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT not null,
    product_name VARCHAR (255) NOT NULL,
    brand_name VARCHAR(255) NOT NULL,
    category_name NVARCHAR(255) NOT NULL,
    model_year SMALLINT NOT NULL
);
GO

create table DimSucursal(
    SucursalKey INT IDENTITY(1,1) PRIMARY KEY,       
    store_id    INT NOT NULL,           
    store_name  VARCHAR (255) NOT NULL,
    phone       VARCHAR (25),
    email       VARCHAR (255),
    street      VARCHAR (255),
    city        VARCHAR (255),
    state       VARCHAR (10),
    zip_code    VARCHAR (5)
);
GO


create table DimUsuarios(
    CustomerKey  INT IDENTITY(1,1) PRIMARY KEY, 
    customer_id  INT NOT NULL,
    full_name    VARCHAR(255) not null,
    email        VARCHAR (255) NOT NULL,
    phone        VARCHAR (25),
    street       VARCHAR (255),
    city         VARCHAR (50),
    state        VARCHAR (25),
    zip_code     VARCHAR (5),
    start_date   DATETIME NOT NULL, 
    end_date     DATETIME NULL, 
    is_current   BIT DEFAULT 1
);
GO


create table DimEmpleados(
staffKey         INT IDENTITY(1,1) PRIMARY KEY,        
staff_id         INT NOT NULL,        
full_name        VARCHAR(255) NOT NULL,
email            VARCHAR (255) NOT NULL UNIQUE,
phone            VARCHAR (25),
active           tinyint NOT NULL,
start_date       DATETIME NOT NULL, 
end_date         DATETIME NULL,
is_current       BIT DEFAULT 1
);
GO

create table DimOrden(
OrderKey        INT IDENTITY(1,1) PRIMARY KEY,
order_id        INT NOT NULL,
order_status    tinyint NOT NULL
);
GO


CREATE TABLE   DimDate
	(	DateKey INT primary key, 
		Date DATE,
		FullDateUK CHAR(10), -- Date in dd-MM-yyyy format
		FullDateUSA CHAR(10),-- Date in MM-dd-yyyy format
		DayOfMonth VARCHAR(2), -- Field will hold day number of Month
		DaySuffix VARCHAR(4), -- Apply suffix as 1st, 2nd ,3rd etc
		DayName VARCHAR(9), -- Contains name of the day, Sunday, Monday 
		DayOfWeekUSA CHAR(1),-- First Day Sunday=1 and Saturday=7
		DayOfWeekUK CHAR(1),-- First Day Monday=1 and Sunday=7
		DayOfWeekInMonth VARCHAR(2), --1st Monday or 2nd Monday in Month
		DayOfWeekInYear VARCHAR(2),
		DayOfQuarter VARCHAR(3),
		DayOfYear VARCHAR(3),
		WeekOfMonth VARCHAR(1),-- Week Number of Month 
		WeekOfQuarter VARCHAR(2), --Week Number of the Quarter
		WeekOfYear VARCHAR(2),--Week Number of the Year
		Month VARCHAR(2), --Number of the Month 1 to 12
		MonthName VARCHAR(9),--January, February etc
		MonthOfQuarter VARCHAR(2),-- Month Number belongs to Quarter
		Quarter CHAR(1),
		QuarterName VARCHAR(9),--First,Second..
		Year CHAR(4),-- Year value of Date stored in Row
		YearName CHAR(7), --CY 2012,CY 2013
		MonthYear CHAR(10), --Jan-2013,Feb-2013
		MMYYYY CHAR(6),
		FirstDayOfMonth DATE,
		LastDayOfMonth DATE,
		FirstDayOfQuarter DATE,
		LastDayOfQuarter DATE,
		FirstDayOfYear DATE,
		LastDayOfYear DATE,
		IsHolidayUSA BIT,-- Flag 1=National Holiday, 0-No National Holiday
		IsWeekday BIT,-- 0=Week End ,1=Week Day
		HolidayUSA VARCHAR(50),--Name of Holiday in US
		IsHolidayUK BIT Null,-- Flag 1=National Holiday, 0-No National Holiday
		HolidayUK VARCHAR(50) Null --Name of Holiday in UK
	)
GO


create table DimInventario(
 InventoryKey	INT IDENTITY(1,1) PRIMARY KEY, 
 store_id		INT NOT NULL,
product_id		INT NOT NULL,
quantity		INT NOT NULL,
);
GO


create table FactVentas( 
    VentasKey   INT IDENTITY(1,1) PRIMARY KEY,
OrderKey        INT NOT NULL,
ProductoKey     INT NOT NULL,
ClienteKey      INT NOT NULL,
EmpleadoKey     INT NOT NULL,
SucursalKey     INT NOT NULL,
OrderDateKey    INT NOT NULL,
RequiredDateKey INT NOT NULL,
ShippedDateKey  INT NOT NULL,
-- Todos los de arriba son claves foraneas

quantity        INT NOT NULL,
list_price      DECIMAL (10, 2) NOT NULL, 
discount        DECIMAL (4, 2) NOT NULL DEFAULT 0,
monto_bruto     DECIMAL(12, 2) NOT NULL,
monto_descuento DECIMAL(12, 2) NOT NULL,
monto_neto      DECIMAL(12, 2) NOT NULL,
FOREIGN KEY (OrderKey) REFERENCES DimOrden(OrderKey),
FOREIGN KEY (ClienteKey) REFERENCES DimUsuarios(CustomerKey),
FOREIGN KEY (EmpleadoKey) REFERENCES DimEmpleados(staffKey),
FOREIGN KEY (SucursalKey) REFERENCES DimSucursal(SucursalKey),
FOREIGN KEY (OrderDateKey) REFERENCES DimDate(DateKey),
FOREIGN KEY (RequiredDateKey) REFERENCES DimDate(DateKey),
FOREIGN KEY (ShippedDateKey) REFERENCES DimDate(DateKey)
);
GO

