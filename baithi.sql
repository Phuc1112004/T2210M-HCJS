create table Customer(
	CustomerID int not null primary key identity(1,1),
	Name nvarchar(50),
	City nvarchar(50),
	Country nvarchar(50),
	Phone nvarchar(15),
	Email nvarchar(50)
);

create table CustomerAccount(
	AccountNumber char(9) not null primary key,
	CustomerID int not null foreign key references Customer(CustomerID),
	Balance money not null,
	MinAccount money,
);

create table CustomerTransaction(
	TransactionID int not null primary key identity(1,1),
	AccountNumber char(9) foreign key references CustomerAccount(AccountNumber),
	TransactionDate smalldatetime,
	Amount money,
	DepositorWithdraw bit,
);

/* */
insert into Customer(Name,City,Country,Phone,Email)
values ('Trinh Van Phuc','Ha Noi','Viet Nam','0385225687','abc@gmail.com'),
		('Nguyen Van Bao','Ha Noi','Viet Nam','0123456789','xyz@gmail.com'),
		 ('Tran Duc Anh','Ha Noi','Viet Nam','0123456789','qwe@gmail.com');

select * from Customer;


/* */
insert into CustomerAccount(AccountNumber,CustomerID,Balance,MinAccount)
values  ('123456789',1,'2000000','10000'),
		('123453456',2,'19000000','10000'),
		('123451234',3,'10000000','10000');
select * from CustomerAccount


insert into CustomerTransaction(AccountNumber,TransactionDate,Amount,DepositorWithdraw)
values('123456789','2018-02-04','200000',1),
		('123453456', '20202-09-27','200000', 1),
		('123451234', '2021-10-12','200000', 1);


/* 4 */
select * from Customer where City = 'Ha Noi';

/* 5 */
select A.Name, A.phone , A.Email, C.AccountNumber, C.Balance from customer A
inner join customerAccount C on A.CustomerID = C.CustomerID;
/* 6 */
alter table CustomerTransaction
add check ( Amount >0 and Amount <= 100000);
/* 7*/

create view CustomerTransaction
as
select C.Name, CA.AccountNumber, CT.TransactionDate, CT.Amount, CT.DepositorWithdraw
from Customer C
join CustomerAccount CA
	on C.CustomerID = CA.CustomerID
join CustomerTransaction CT
	on CA.AccountNumber = CT.AccountNumber;
go