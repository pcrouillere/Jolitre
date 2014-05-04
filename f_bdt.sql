Prompt ** BDT : Creation Des Tables **
Prompt ** BDT : Creation Des Tables - Table Date **

CREATE OR REPLACE type f_bdt_date_type as object (
dDate varchar(13),
dTemperature varchar(3),
member function getdDate return Date,
member function getdTemperature return varchar, 
member function getJourDeSemaine return varchar,
member function getSemaine return varchar,
member function getMois return varchar,
member function getAnnee return varchar
);
/
create table f_bdt_date of f_bdt_date_type;

Prompt ** BDT : Creation Des Tables - Table vente **
CREATE OR REPLACE type f_bdt_ventes_type as object (
vNumber Varchar(30),
vProduit Varchar(30),
vClerk Varchar (30),
vClient Varchar(30),
vDate Varchar(13),
member function getvDate return Date,
member function getvNumber return varchar, 
member function getvProduit return varchar,
member function getvClerk return varchar,
member function getvClient return varchar
);
/
create table f_bdt_ventes of f_bdt_ventes_type;

Prompt ** BDT : Creation Des Tables - Table Clerk **
CREATE OR REPLACE type f_bdt_clerk_type as object (
cNum number(3),
cExp number(3),
cStore varchar(50),
cCity varchar(50),
cCityPop varchar(50),
cSector varchar(50),
cSectorSur varchar(50),
member function getcNum return number,
member function getcExp return number,
member function getcStore return varchar,
member function getcCity return varchar,
member function getcCityPop return varchar,
member function getcSector return varchar,
member function getcSectorSur return varchar,
member function getcBestClerk return varchar,
member function getcBestStore return varchar
);
/
create table f_bdt_clerk of f_bdt_clerk_type;

Prompt ** BDT : Creation Des Tables - Table Product **
CREATE OR REPLACE type f_bdt_product_type as object (
pRef varchar(15),
pPrice number(5),
pType varchar(50),
pCity varchar(50),
pCityPop varchar(50),
pSector varchar(50),
pSectorSur varchar(50),
member function getpRef return varchar,
member function getpPrice return varchar,
member function getpType return varchar,
member function getpCity return varchar,
member function getpCityPop return varchar,
member function getpSector return varchar,
member function getpSectorSur return varchar,
member function getpBestSeller return varchar
);
/
create table f_bdt_product of f_bdt_product_type;

Prompt ** BDT : Creation Des Tables - Table Card **
CREATE OR REPLACE type f_bdt_card_type as object (
cNum varchar(10),
cSector varchar(50),
cSectorSur varchar(50),
cOccupation varchar(50),
cHouse varchar(50),
member function getcNum return varchar,
member function getcSector return varchar,
member function getcSectorSur return varchar,
member function getcOccupation return varchar,
member function getcHouse return varchar,
member function getHighSpender return varchar
);
/
create table f_bdt_card of f_bdt_card_type;