-- Создаем таблицы "dbo.SKU", "dbo.Family", "dbo.Basket"
create table dbo.SKU (
    ID int not null identity,
    Code as concat('s', ID),
    Name varchar(255),
    constraint PK_SKU primary key (ID),
    constraint UK_SKU_Code unique (Code)
)

create table dbo.Family (
    ID int not null identity,
    SurName varchar(255),
    BudgetValue decimal(18, 2),
    constraint PK_Family primary key (ID)
)

-- "Value" может являться зарезервированным ключевым словом, заменено на "BaseValue"
create table dbo.Basket (
    ID int not null identity,
    ID_SKU int not null,
    ID_Family int not null,
    Quantity int not null,
    BaseValue decimal(18, 2) not null,
    PurchaseDate date default getdate(),
    DiscountValue decimal(18, 2),
    constraint PK_Basket primary key (ID),
    constraint FK_Basket_ID_SKU_SKU foreign key (ID_SKU) references dbo.SKU(ID),
    constraint FK_Basket_ID_Family_Family foreign key (ID_Family) references dbo.Family(ID),
    constraint CK_Basket_Quantity check (Quantity >= 0),
    constraint CK_Basket_BaseValue check (BaseValue >= 0)
)

