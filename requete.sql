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
