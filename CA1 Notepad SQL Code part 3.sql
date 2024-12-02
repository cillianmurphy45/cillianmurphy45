Create Table Customer_Details(Customer_ID int NOT NULL PRIMARY KEY,
Customer_Name varchar(20),
Customer_Address varchar(30),
Customer_Telephone_Number varchar(20));

Create Table Order_Details(Order_ID int NOT NULL PRIMARY KEY,
Order_Date DATE,
Customer_ID int, FOREIGN KEY(Customer_ID) REFERENCES Customer_Details(Customer_ID));

Create Table Supplier_Details(Supplier_ID int Not NULL PRIMARY KEY,
Supplier_Name varchar(20),
Supplier_Address varchar(20),
Supplier_Telephone_Number varchar(20));

Create Table Product_Details(Product_ID int Not NULL PRIMARY KEY,
Product_Name varchar(20),
Product_Price varchar(20),
Quantity_In_Stock varchar int,
Supplier_ID int,
FOREIGN KEY(Supplier_ID) REFERENCES Supplier_Details(Supplier_ID));

Create Table Order_Product_Details(Order_ID int,Product_ID int,
Quantity_Ordered int,
PRIMARY KEY(Order_ID,Product_ID),
FOREIGN KEY(Order_ID) REFERENCES Order_Details(Order_ID),
FOREIGN KEY(Product_ID) REFERENCES Product_Details(Product_ID));

# Sample VALUES
INSERT into Customer_Details VALUES(1,"Tim S","12 New Road","04273619");
INSERT into Customer_Details VALUES(2,"John Doe","12 Old Road","04134816");
INSERT into Customer_Details VALUES(3,"Cillian Murphy", "35 Park Street","04291062");
INSERT into Customer_Details VALUES(4,"Mary G","79 Marsh Street","04274356");
INSERT into Customer_Details VALUES(5,"Mark F","15 Cork Road","04275674");

INSERT into Order_Details VALUES(1, "2024-11-11",1);
INSERT into Order_Details VALUES(2, "2024-12-16",2);
INSERT into Order_Details VALUES(3,"2023-12-16",3);
INSERT into Order_Details VALUES(4, "2022-9-20",4);
INSERT into Order_Details VALUES(5, "2021-9-21",5);

insert into Supplier_Details VALUES(1,"Currys","Dundalk Retail Park","04123432");
insert into Supplier_Details VALUES(2,"Harvey Norman","Navan Retail Park","04267545");
insert into Supplier_Details VALUES(3,"Tech Shop","Drogheda Retail Park","04267564");
insert into Supplier_Details VALUES(4,"IT Supplies","Dundalk SC","04123423");
insert into Supplier_Details VALUES(5,"IT Shop", "Navan SC","04234323");

insert into Product_Details VALUES(1,"Computer","500","4",1);
insert into Product_Details VALUES(2,"Laptop","300","6",2);
insert into Product_Details VALUES(3,"Keyboard","50","20",3);
insert into Product_Details VALUES(4,"Mouse","20","25",4);
insert into Product_Details VALUES(5,"Monitor","150","10",5);
insert into Product_Details VALUES(6, "HDMI Cable","20","49",1);
insert into Product_Details VALUES(7, "Powerbank","30","23",2);
insert into Product_Details VALUES(8, "Projector","500","13",3);
insert into Product_Details VALUES(9, "Ethernet Cable","25","70",4);
insert into Product_Details VALUES(10, "Power Outlet","10","100",5);

insert into Order_Product_Details VALUES(1,1,5);
insert into Order_Product_Details VALUES(2,2,7);
insert into Order_Product_Details VALUES(3,3,20);
insert into Order_Product_Details VALUES(4,4,9);
insert into Order_Product_Details VALUES(5,5,10);
insert into Order_Product_Details VALUES(1,6,5);
insert into Order_Product_Details VALUES(1,7,20);
insert into Order_Product_Details VALUES(1,5,5);
insert into Order_Product_Details VALUES(2,6,12);
insert into Order_Product_Details VALUES(2,4,20);
insert into Order_Product_Details VALUES(3,2,10);
insert into Order_Product_Details VALUES(3,1,7);
insert into Order_Product_Details VALUES(4,6,7);
insert into Order_Product_Details VALUES(4,3,5);
insert into Order_Product_Details VALUES(5,3,15);
insert into Order_Product_Details VALUES(5,6,50);


-- # 1 find total quantity ordered by customers
select SUM(Quantity_Ordered) from Order_Product_Details

-- # 2 lists suppliers with an address of dundalk retail park
select * from Supplier_Details where Supplier_Address = "Dundalk Retail Park"

-- # 3 display products that are low in stock (under 10)
select Product_Name, Quantity_In_Stock, Quantity_In_Stock < 10 as low_in_stock from Product_Details

-- # 4 orders placed before the 1st of january 2024
select * from Order_Details where Order_Date < "2024-01-01"

-- # 5 get the max cost of a product
select max(Product_Price) as highest_cost from Product_Details

-- # 6 How many distinct products in each order
select Order_ID, COUNT(DISTINCT Product_ID) as DISTINCT_Products from Order_Product_Details group by Order_ID 

-- # 7 Create Invoice
Select Order_ID, Customer_Name,Customer_Address, Customer_Telephone_Number,Order_Date,Product_Name,Quantity_Ordered,Product_Price * Quantity_Ordered as "Total Price" from Customer_Details join Order_Details USING(Customer_ID) join Order_Product_Details using(Order_ID) join Product_Details using(Product_ID)

-- # 8 Display all customers who have bought “Computer”.
select * from Customer_Details join Order_Details join Product_Details where Product_Name = "Computer"

-- # 9 Calculate Total Revenue of each supplier
SELECT Supplier_ID, Supplier_Name, SUM(Quantity_Ordered * Product_Price) as "Revenue" from Supplier_Details join Product_Details using(Supplier_ID) join Order_Product_Details using(Product_ID) group by Supplier_ID,Supplier_Name

-- # 10 Display all products ordered including supplier details and customer
select Product_Name as "Product", Product_Price as "Price", Supplier_Name as "Supplier", Customer_Name as "Customer", Customer_Address as "Customer Address", Order_Date as "Order Date", Quantity_Ordered as "Quantity Ordered" from Product_Details join Supplier_Details using(Supplier_ID) join Order_Product_Details using(Product_ID) join Order_Details using(Order_ID) join Customer_Details using(Customer_ID)


