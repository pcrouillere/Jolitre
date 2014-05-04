Prompt ** DW: Drop Table **
drop table f_dw_date;
drop table f_dw_ventes;
drop table f_dw_clerk;
drop table f_dw_product;
drop table f_dw_card;

Prompt ** DW: Creation des tables **
Prompt ** DW: Creation des tables : Table date **
CREATE TABLE f_dw_date(
dDate date,
dTemperature varchar(10),
dJourSemaine varchar(10),
dSemaine varchar(2),
dMois varchar(2),
dAnnee varchar(4)
);

CREATE UNIQUE INDEX f_dw_date_idk on f_dw_date(dDate);
Alter table f_dw_date add constraint f_dw_date_pk PRIMARY KEY (dDate);

Prompt ** DW: Creation des tables : Table clerk **
create table f_dw_clerk (
cNum number(3),
cExp number(3),
cStore varchar(50),
cCity varchar(50),
cCityPop varchar(50),
cSector varchar(50),
cSectorSur varchar(50),
cBestClerk number,
cBestStore number
);
CREATE UNIQUE INDEX f_dw_clerk_idk on f_dw_clerk(cNum);
Alter table f_dw_clerk add constraint f_dw_clerk_pk PRIMARY KEY (cNum);

Prompt ** DW: Creation des tables : Table product **
create table f_dw_product(
pRef varchar(15),
pPrice number(5),
pType varchar(50),
pCity varchar(50),
pCityPop varchar(50),
pSector varchar(50),
pSectorSur varchar(50),
pBestSeller number
);
CREATE UNIQUE INDEX f_dw_product_idk on f_dw_product(pRef);
Alter table f_dw_product add constraint f_dw_product_pk PRIMARY KEY (pRef);

Prompt ** DW: Creation des tables : Table card **
create table f_dw_card (
cNum number,
cSector varchar(50),
cSectorSur varchar(50),
cOccupation varchar(50),
cHouse varchar(50),
cHighSpenser number
);
CREATE UNIQUE INDEX f_dw_card_idk on f_dw_card(cNum);
Alter table f_dw_card add constraint f_dw_card_pk PRIMARY KEY (cNum);

Prompt ** DW: Creation des tables : Table ventes **
create table f_dw_ventes (
vNumber number,
vProduit Varchar(30),
vClerk Varchar (30),
vCard Varchar(30),
vDate Date
);
ALTER TABLE f_dw_ventes
ADD CONSTRAINT f_dw_ventes_fkdat FOREIGN KEY (vDate) REFERENCES f_dw_date(dDate);
ALTER TABLE f_dw_ventes
ADD CONSTRAINT f_dw_ventes_fkclient FOREIGN KEY (vCard) REFERENCES f_dw_card(cNum);
ALTER TABLE f_dw_ventes
ADD CONSTRAINT f_dw_ventes_fkproduct FOREIGN KEY (vProduit) REFERENCES f_dw_product(pRef);