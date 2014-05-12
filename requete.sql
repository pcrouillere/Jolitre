Prompt ** Demande Client : Ventes Par Jour De La Semaine **
Select D.dJourSemaine, Count(V.Vnumber) as VENTE 
From F_Dw_Date D, F_Dw_Ventes V
Where V.Vdate = D.Ddate And V.Vdate <> To_Date('1111-01-01','yyyy-mm-dd')
Group By D.dJourSemaine
Order By Vente


Prompt ** Demande Client : Ventes Par Mois De L Annee **
Select D.dMois, Count(V.Vnumber) as VENTE 
From F_Dw_Date D, F_Dw_Ventes V
Where V.Vdate = D.Ddate And V.Vdate <> To_Date('1111-01-01','yyyy-mm-dd')
Group By D.dMois
Order By Vente

Prompt ** Demande Client : Ventes en fonction des magasins **
Select cl.cstore, count(v.vnumber) as vente
from f_dw_ventes v, f_dw_clerk cl
WHERE v.vclerk = cl.cnum and v.vclerk <> 0
group by cl.cstore
order by vente;

Prompt ** Demande Client : Ventes en fonction des secteurs **
Select cl.csector, count(v.vnumber) as vente
from f_dw_ventes v, f_dw_clerk cl
WHERE v.vclerk = cl.cnum and v.vclerk <> 0
group by cl.csector
order by vente;

Prompt ** Demande Client : Ventes en fonction des villes **
Select cl.ccity, cl.ccitypop, count(v.vnumber) as vente
from f_dw_ventes v, f_dw_clerk cl
WHERE v.vclerk = cl.cnum and v.vclerk <> 0
group by cl.ccity, cl.ccitypop
order by vente;

Prompt ** Demande Client : Ventes en fonctions de produit **
select p.pref, count(v.vnumber) as vente
from f_dw_ventes v, f_dw_product p
where v.vproduit = p.pref
group by p.pref
order by vente;

Prompt ** Demande Client : Ventes en fonctions des types produit **
select p.ptype, count(v.vnumber) as vente
from f_dw_ventes v, f_dw_product p
where v.vproduit = p.pref
group by p.ptype
order by vente;

Prompt ** Demande client : ventes en fonctions des types et des occupations **
select p.pprice, ca.coccupation, count(*)
from f_dw_ventes v, f_dw_card ca, f_dw_product p
where v.vproduit = p.pref and v.vclerk = ca.cnum and ca.cnum <> -1
group by cube(p.pprice, ca.coccupation);