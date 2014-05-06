drop view v_cityname;


Create Or Replace View V_Cityname(Nbcity, Cname) As Select Count(*), City.Cname From F_Bde_City City Group By City.Cname;
Drop Table T_V_cityname;
Create Table T_V_Cityname(
Nbcity Number,
Cname Varchar(20));
Insert Into T_V_Cityname(Nbcity, Cname) Select V.Nbcity, V.Cname From V_Cityname v;

Create Or Replace View V_Sectorname (Nbsector, Sname) As Select Count(*), S.Sname From F_Bde_Sector S Group By S.Sname;
Drop Table T_V_sectorname;
Create Table T_V_sectorname(
Nbsector Number,
Sname Varchar(20));
Insert Into T_V_sectorname(Nbsector, Sname) Select V.Nbsector, V.Sname From V_sectorname v;

CREATE OR REPLACE VIEW v_prodRank(theRank, prod)
AS SELECT theRank, prod FROM
(SELECT v.vProduit AS prod, RANK() OVER (ORDER BY count(*) DESC) AS theRank
FROM f_bdt_ventes v, f_bdt_product p
WHERE v.vProduit=p.pRef
Group By V.Vproduit);
Drop Table T_V_prodrank;
Create Table T_V_Prodrank(
theRank Number,
Prod Varchar(20));
Insert Into T_V_prodrank(theRank, Prod) Select p.theRank, p.prod from v_prodRank p;


CREATE OR REPLACE VIEW v_clientRank
(theRank, cl)
AS SELECT theRank, cl FROM
(
SELECT client.cnum AS cl, RANK() OVER (ORDER BY count(*) DESC) AS theRank
FROM f_bdt_ventes v, f_bdt_card client
WHERE v.vClient=client.cNum
GROUP BY client.cNum
);
drop table t_v_clientrank;
Create Table T_V_clientrank(
theRank Number,
Cl Varchar(20));
Insert Into T_V_Clientrank(Therank, Cl) Select P.Therank, P.Cl From V_Clientrank P;


Create Or Replace View V_Clientnb(Cnum, Cnb)
As Select Ca.Cnumber, Count(*) From F_Bde_Card Ca Group By Ca.Cnumber;
Drop Table T_V_clientnb;
Create Table T_V_Clientnb(
Cnum Varchar(20),
Cnb Number);
Insert Into T_V_Clientnb(Cnum,Cnb) Select Cl.Cnum, Cl.Cnb From V_Clientnb Cl;


CREATE OR REPLACE VIEW v_clerkRank
(theRank, clerk, st)
AS SELECT theRank, clerk, st FROM
(
SELECT clerk.cnum AS clerk, clerk.cstore AS st, RANK() OVER (ORDER BY count(*) DESC) AS theRank
FROM f_bdt_ventes v, f_bdt_clerk clerk
WHERE v.vClerk=clerk.cNum
GROUP BY clerk.cNum, clerk.cstore
);
drop table t_v_clerkrank;
Create Table T_V_clerkrank(
theRank Number,
Cl Varchar(20),
St Varchar(20));
Insert Into T_V_Clerkrank(Therank, Cl, st) Select P.Therank, P.Clerk, p.st From V_Clerkrank P;

CREATE OR REPLACE VIEW v_storeRank
(theRank, st)
AS SELECT theRank, st FROM
(
SELECT v.st AS st, RANK() OVER (ORDER BY count(*) DESC) AS theRank
FROM v_clerkRank v
GROUP BY v.st
);
Drop Table T_V_Storerank;
Create Table T_V_storerank(
theRank Number,
St Varchar(20));
Insert Into T_V_Clerkrank(Therank, St) Select P.Therank,  P.St From V_storeRank P;
