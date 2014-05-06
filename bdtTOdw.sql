Prompt ** BDT TO DW : Desactivation des contraintes **
ALTER TABLE f_dw_ventes DISABLE CONSTRAINT f_dw_ventes_fkdat; 
ALTER TABLE f_dw_ventes DISABLE CONSTRAINT f_dw_ventes_fkclient;
ALTER TABLE f_dw_ventes DISABLE CONSTRAINT f_dw_ventes_fkproduct;

Alter table f_dw_clerk DISABLE CONSTRAINT f_dw_clerk_pk;
DROP INDEX f_dw_clerk_idk;
Alter table f_dw_product DISABLE CONSTRAINT f_dw_product_pk;
Drop INDEX f_dw_product_idk;
Alter table f_dw_card DISABLE CONSTRAINT f_dw_card_pk;
Drop INDEX f_dw_card_idk;
Alter table f_dw_date DISABLE CONSTRAINT f_dw_date_pk;
Drop INDEX f_dw_date_idk;

Prompt **BDT TO DW : Insertions des donn�es **
Prompt **BDT TO DW : Insertions des donn�es : Table f_dw_date **
insert into f_dw_date(dDate, dTemperature, dJourSemaine, dSemaine, dMois, dAnnee)
SELECT distinct d.getdDate(), d.getdTemperature(), d.getJourDeSemaine(), d.getSemaine(), d.getMois(), d.getAnnee()  
from f_bdt_date d;

Prompt **BDT TO DW : Insertions des donn�es : Table f_dw_product **
insert into f_dw_product(pref, pprice, ptype, pcity, pcityPop, psector, psectorsur, pbestseller)
select distinct p.getpref(), p.getpprice(), p.getptype(), p.getpcity(), p.getpcitypop(), p.getpSector(), p.getpSectorSur(), p.getpBestSeller()
from f_bdt_product p;

Prompt **BDT TO DW : Insertions des donn�es : Table f_dw_clerk **
insert into f_dw_clerk(cnum, cexp, cstore, ccity, ccitypop, csector, csectorsur, cbestclerk, cbeststore) 
select distinct cl.getcNum(), cl.getcExp(), cl.getcStore(), cl.getcCity(), cl.getcCityPop(), cl.getcSector(), cl.getcSectorSur(), cl.getcBestClerk(), cl.getcBestStore()
from f_bdt_clerk cl;

Prompt **BDT TO DW : Insertions des donn�es : Table f_dw_card **
Insert Into F_Dw_Card(Cnum, Csector, Csectorsur, Coccupation, Chouse, Chighspenser)
select distinct car.getcNum(), car.getcSector(), car.getcSectorSur(), car.getcOccupation(), car.getcHouse(), car.getHighSpender()
from f_bdt_card car;

Prompt **BDT TO DW : Insertions des donn�es : Table f_dw_ventes **
insert into f_dw_ventes(vnumber, vproduit, vclerk, vcard, vdate)
select v.getvNumber(), v.getvProduit(), v.getvClerk(), v.getvClient(), v.getvDate()
from f_bdt_ventes v;


Prompt **BDT TO DW : R�activation des contraintes et tables exceptions **
Prompt **BDT TO DW : Insertions des donn�es pour g�rer les erreurs **
INSERT INTO f_dw_product(pref, pprice, ptype, pcity, pcitypop, psector, psectorsur, pbestseller) values ('NR', null, null, null, null, null, null, null);
insert into f_dw_clerk(cnum, cexp, cstore, ccity,ccitypop,csector,csectorsur,cbestclerk,cbeststore) values(0, null, null, null, null, null, null, null, null);
insert into f_dw_date(ddate,dtemperature,djoursemaine,dsemaine,dmois,dannee) values (TO_DATE('1111-01-01','yyyy-mm-dd'), null, null, null, null, null);
Prompt ** cr�ation des index **
CREATE UNIQUE INDEX f_dw_clerk_idk on f_dw_clerk(cNum);
CREATE UNIQUE INDEX f_dw_product_idk on f_dw_product(pRef);
CREATE UNIQUE INDEX f_dw_card_idk on f_dw_card(cNum);
CREATE UNIQUE INDEX f_dw_date_idk on f_dw_date(dDate);

Prompt ** activation des cle primaires**
Alter table f_dw_clerk enable constraint f_dw_clerk_pk;
Alter table f_dw_product enable constraint f_dw_product_pk;
Alter table f_dw_card enable constraint f_dw_card_pk;
Alter table f_dw_date enable constraint f_dw_date_pk;

Prompt ** activation des clefs etrang�res ** 
ALTER TABLE f_dw_ventes enable CONSTRAINT f_dw_ventes_fkdat;
ALTER TABLE f_dw_ventes enable CONSTRAINT f_dw_ventes_fkclient;
ALTER TABLE f_dw_ventes enable CONSTRAINT f_dw_ventes_fkproduct;
