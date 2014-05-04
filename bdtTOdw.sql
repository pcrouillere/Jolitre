Prompt **BDT TO DW : Desactivation des contraintes **

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

Prompt **BDT TO DW : Insertions des données **
Prompt **BDT TO DW : Insertions des données : Table f_dw_date **
insert into f_dw_date(dDate, dTemperature, dJourSemaine, dSemaine, dMois, dAnnee)
SELECT distinct d.getdDate(), d.getdTemperature(), d.getJourDeSemaine(), d.getSemaine(), d.getMois(), d.getAnnee()  
from f_bdt_date d;

Prompt **BDT TO DW : Insertions des données : Table f_dw_product **
insert into f_dw_product(pref, pprice, ptype, pcity, pcitypop, psector, psectorsur, pbestseller)
select distinct p.getpref(), p.getpprice(), p.getptype(), p.getcity(), p.getpsector(), p.getpsectorsur(), p.getpbestseller()
from F_BDT_PRODUCT p;

Prompt **BDT TO DW : Insertions des données : Table f_dw_clerk **

Prompt **BDT TO DW : Insertions des données : Table f_dw_card **

Prompt **BDT TO DW : Insertions des données : Table f_dw_ventes **


Prompt **BDT TO DW : Réactivation des contraintes et tables exceptions **
Prompt **BDT TO DW : Insertions des données pour gérer les erreurs **
** NR  pour les produits et la date si elle ne l est pas déjà **

CREATE UNIQUE INDEX f_dw_clerk_idk on f_dw_clerk(cNum);
Alter table f_dw_clerk add constraint f_dw_clerk_pk PRIMARY KEY (cNum);
CREATE UNIQUE INDEX f_dw_product_idk on f_dw_product(pRef);
Alter table f_dw_product add constraint f_dw_product_pk PRIMARY KEY (pRef);
CREATE UNIQUE INDEX f_dw_card_idk on f_dw_card(cNum);
Alter table f_dw_card add constraint f_dw_card_pk PRIMARY KEY (cNum);
CREATE UNIQUE INDEX f_dw_date_idk on f_dw_date(dDate);
Alter table f_dw_date add constraint f_dw_date_pk PRIMARY KEY (dDate);

ALTER TABLE f_dw_ventes
ADD CONSTRAINT f_dw_ventes_fkdat FOREIGN KEY (vDate) REFERENCES f_dw_date(dDate);
ALTER TABLE f_dw_ventes
ADD CONSTRAINT f_dw_ventes_fkclient FOREIGN KEY (vCard) REFERENCES f_dw_card(cNum);
ALTER TABLE f_dw_ventes
ADD CONSTRAINT f_dw_ventes_fkproduct FOREIGN KEY (vProduit) REFERENCES f_dw_product(pRef);
