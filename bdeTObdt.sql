Prompt ** BDT TO BDE **
Prompt ** BDT TO BDE  : Insertions des données **

Prompt ** BDT TO BDE  : Insertions des données : Table f_bdt_date **
insert into f_bdt_date(dDate,dTemperature)
select distinct vDate, ttemp
from f_bde_ventes v, f_bde_temp t
where v.vDate = t.tDate;

Prompt ** BDT TO BDE  : Insertions des données : Table f_bdt_product **
insert into f_bdt_product (pref, pprice, ptype, pcity, pcitypop, psector, psectorsur)
select p.pref, p.pprice, p.ptype, p.pcity, city.cpop, p.psector, s.ssup
from f_bde_product p, f_bde_city city, f_bde_sector s
where p.pcity = city.cname and p.psector = s.sname;

Prompt ** BDT TO BDE  : Insertions des données : Table f_bdt_card **
insert into f_bdt_card (cnum, csector, csectorsur, coccupation, chouse)
select card.cnumber, card.csector, s.SSUP, card.COCCUPATION, card.CHOUSE
from f_bde_card card, f_bde_sector s
where card.csector = s.sname;

Prompt ** BDT TO BDE  : Insertions des données : Table f_bdt_clerk **
insert into f_bdt_clerk(cnum, cexp, cstore, ccity, ccitypop, csector, csectorsur)
select clerk.CNUM, clerk.CYEAR, clerk.CSTORE, st.SCITY, city.CPOP, st.SSECTOR, sector.SSUP
from f_bde_clerk clerk, f_bde_sector sector, f_bde_city city, f_bde_store st
where clerk.cstore = st.sref and st.SCITY = city.CNAME and st.SSECTOR = sector.SNAME;


Prompt ** BDT TO BDE  : Insertions des données : Table f_bdt_ventes **
insert into f_bdt_ventes(vnumber, vproduit, vclerk, vclient, vdate)
select vnumber, vproduit, vclerk, vclient, vdate
from f_bde_ventes;

A FAIRE TABLE EXCEPTIONS ET CONTRAINTES 
