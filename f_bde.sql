Prompt ** Directory **
Create Or Replace Directory Nf26p030data As '/home/nf26/dune/30/';
Create Or Replace Directory Nf26p030temp As '/volsme/user1x/uvs/nf26/nf26p030/Documents/30/test';

Prompt ** BDE : Creation Des Tables Et Insertions Des Données **
Prompt ** BDE : Table F_BDE_VENTES**
Create Table F_Bde_Ventes(
Vnumber Varchar(30),
Vproduit Varchar(30),
Vclerk Varchar (30),
Vclient Varchar(30),
Vdate Varchar(13))
Organization External(
Type Oracle_Loader
Default Directory Nf26p030data
Access Parameters (
Records Delimited By Newline
Characterset Utf8
Badfile Nf26p030temp:'bad'
Logfile Nf26p030temp:'log'
Fields Terminated By ';'
Optionally enclosed by '"'
)
Location ('DuneCorp'))
Reject LImit 0;

Prompt ** Bde : Table F_Bde_City**
Create Table F_Bde_City(
Cname Varchar(50),
Cpop Varchar(30),
cSector Varchar (30))
Organization External(
Type Oracle_Loader
Default Directory Nf26p030data
Access Parameters (
Records Delimited By Newline
Characterset Utf8
Badfile Nf26p030temp:'bad'
Logfile Nf26p030temp:'log'
Fields Terminated By ';'
Optionally enclosed by '"'
)
Location ('ArrakisCities_gov'))
Reject LImit 0;

Prompt ** Bde : Table F_Bde_Sector**
Create Table F_Bde_Sector(
Sname Varchar(50),
sSup number(3))
Organization External(
Type Oracle_Loader
Default Directory Nf26p030data
Access Parameters (
Records Delimited By Newline
Characterset Utf8
Badfile Nf26p030temp:'bad'
Logfile Nf26p030temp:'log'
Fields Terminated By ';'
Optionally enclosed by '"'
)
Location ('ArrakisSectors_gov'))
Reject LImit 0;

Prompt ** Bde : Table F_Bde_Card**
Create Table F_Bde_Card(
Cnumber Varchar(10),
Cadress Varchar(50),
Csector Varchar(50),
Coccupation Varchar(50),
cHouse varchar(50))
Organization External(
Type Oracle_Loader
Default Directory Nf26p030data
Access Parameters (
Records Delimited By Newline
Characterset Utf8
Badfile Nf26p030temp:'bad'
Logfile Nf26p030temp:'log'
Fields Terminated By ';'
Optionally enclosed by '"'
)
Location ('Card'))
Reject LImit 0;

Prompt ** Bde : Table F_Bde_Clerk**
Create Table F_Bde_Clerk(
Cnum Number(3),
Cyear Number(3),
Cstore Varchar(50))
Organization External(
Type Oracle_Loader
Default Directory Nf26p030data
Access Parameters (
Records Delimited By Newline
Characterset Utf8
Badfile Nf26p030temp:'bad'
Logfile Nf26p030temp:'log'
Fields Terminated By ';'
Optionally enclosed by '"'
)
Location ('Clerk.csv'))
Reject LImit 0;

Prompt ** Bde : Table F_Bde_Product**
Create Table F_Bde_Product(
Pref Varchar(15),
Pprice Number(5),
Ptype Varchar(50),
Pcity Varchar(50),
psector varchar(50))
Organization External(
Type Oracle_Loader
Default Directory Nf26p030data
Access Parameters (
Records Delimited By Newline
Characterset Utf8
Badfile Nf26p030temp:'bad'
Logfile Nf26p030temp:'log'
Fields Terminated By ';'
Optionally enclosed by '"'
)
Location ('Jolitres'))
Reject LImit 0;


Prompt ** Bde : Table F_Bde_Store**
Create Table F_Bde_Store(
Sref Varchar(15),
scity varchar(50),
ssector Varchar(50))
Organization External(
Type Oracle_Loader
Default Directory Nf26p030data
Access Parameters (
Records Delimited By Newline
Characterset Utf8
Badfile Nf26p030temp:'bad'
Logfile Nf26p030temp:'log'
Fields Terminated By ';'
Optionally enclosed by '"'
)
Location ('Store.csv'))
Reject LImit 0;

Prompt ** Bde : Table F_Bde_Temp**
Create Table F_Bde_Temp(
Tdate Varchar(15),
ttemp varchar(3))
Organization External(
Type Oracle_Loader
Default Directory Nf26p030data
Access Parameters (
Records Delimited By Newline
Characterset Utf8
Badfile Nf26p030temp:'bad'
Logfile Nf26p030temp:'log'
Fields Terminated By ';'
Optionally enclosed by '"'
)
Location ('Temperature.txt'))
Reject LImit 0;

prompt ** Verification **
Select Count(*) From F_Bde_Ventes;
Select Count(*) From F_Bde_City;
Select Count(*) From F_Bde_Card;
Select Count(*) From F_Bde_Clerk;
Select Count(*) From F_Bde_Product;
select count(*) from f_bde_temp;