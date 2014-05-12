Prompt ** BDT : Creation Des Fonctions **
Prompt ** BDT : Creation Des Fonctions : Table f_bdt_card **
CREATE OR REPLACE TYPE BODY f_bdt_card_type IS
member function getcNum return varchar IS
NB number(7);
Begin
select cnb into nb from t_v_clientnb nb where nb.cnum = self.cnum;
	If nb = 1 Then
    Return self.cnum;
  Else
    return -1;
  END IF;
END;
member function getcSector return varchar IS
NB_c number(7);
NB number(7);
Begin
select cnb into nb_c from t_v_clientnb nb where nb.cnum = self.cnum;
select nbSector into nb from t_v_sectorName v where v.Sname = cSector;
	If nb_c = 1 Then
    if nb = 0 THEN
      RETURN 'NR';
    elsif nb = 1 THEN
      RETURN cSector;
    else
      RETURN 'Multiple-Sector';
    END IF;
  Else
    return 'CM';
  END IF;
END;
member function getcSectorSur return varchar IS
NB number(7);
NB_c number(7);
Begin
select nbSector into nb from t_v_sectorName v where v.Sname = cSector;
select cnb into nb_c from t_v_clientnb nb where nb.cnum = self.cnum;
	If nb_c = 1 Then
    if nb = 0 THEN
      RETURN 'NR';
    elsif nb = 1 THEN
      RETURN cSectorSur;
    else
      RETURN 'Multiple-Sector';
    END IF;
    Else
    return 'CM';
  END IF;
END;
member function getcOccupation return varchar IS
NB_c number(7);
BEGIN
select cnb into nb_c from t_v_clientnb nb where nb.cnum = self.cnum;
	If nb_c = 1 Then
    return cOccupation;
  Else
    return 'CM';
  END IF;
END;
member function getcHouse return varchar IS
NB_c number(7);
BEGIN
select cnb into nb_c from t_v_clientnb nb where nb.cnum = self.cnum;
	If nb_c = 1 Then
    return cHouse;
  Else
    return 'CM';
  END IF;
END;
member function getHighSpender return varchar IS
  theRank INTEGER;
  NB_c number(7);
BEGIN
select cnb into nb_c from t_v_clientnb nb where nb.cnum = self.cnum;
SELECT theRank INTO theRank FROM t_v_clientRank v WHERE v.cl=SELF.cNum;
	If nb_c <> 1 Then
    return 0;
  else
      IF theRank < 100 THEN
        RETURN 1;
      ELSE
         RETURN 0;
      END IF;
  end if;
END;
End;
/


Prompt ** BDT : Creation Des Fonctions : Table f_bdt_date **
CREATE OR REPLACE TYPE BODY f_bdt_date_type IS
MEMBER FUNCTION getdDate RETURN DATE is
BEGIN
 IF REGEXP_LIKE(dDate,'^[0-9]{4}\-[0-9]{2}\-[0-9]{2}$') THEN
   RETURN TO_DATE(dDate,'yyyy-mm-dd');
 ELSE
   RETURN TO_DATE('1111-01-01','yyyy-mm-dd');
 END IF;
END;
MEMBER FUNCTION getdTemperature RETURN VARCHAR
IS
BEGIN
  IF dTemperature = ' ' THEN
    RETURN 'NR';
  ELSIF dTemperature < '40' THEN
    RETURN '1 - 39';
  ELSIF dTemperature < '60' THEN
     RETURN '40 - 59';
  ELSE
      RETURN '+60';
  END IF;
END;
MEMBER FUNCTION getJourDeSemaine RETURN varchar
IS
BEGIN
  RETURN TO_CHAR(self.getdDate(),'day');
END;
MEMBER FUNCTION getSemaine RETURN varchar
IS
BEGIN
  RETURN TO_CHAR(self.getdDate(),'IW');
END;
MEMBER FUNCTION getMois RETURN varchar
IS
BEGIN
  RETURN TO_CHAR(self.getdDate(),'mm');
END;
MEMBER FUNCTION getAnnee RETURN varchar
IS
BEGIN
  RETURN TO_CHAR(self.getdDate(),'IYYY');
END;
END;
/
Prompt ** BDT : Creation Des Fonctions : Table f_bdt_product **
CREATE OR REPLACE TYPE BODY f_bdt_product_type IS
member function getpRef RETURN varchar
IS
BEGIN
  RETURN pRef;
END;
member function getpPrice RETURN varchar IS
BEGIN
	IF pPrice = 0 Then 
		RETURN '-49';
	ELSIF pPrice < 50 THEN
		RETURN '0-49';
	ELSIF pPrice < 100 THEN	
		RETURN '50-100';
	ELSIF pPrice < 150 THEN	
		RETURN '100-149';
	else
		RETURN '150+';
  END IF;
END;
member function getpType RETURN varchar
IS
BEGIN
	if pType is NOT NULL THEN 
		RETURN pType;
	ELSE 
		RETURN 'NR';
  END IF;
END;
member function getpCity RETURN varchar
IS
NB number(7);
Begin
select nbCity into nb from t_v_cityName v where v.Cname = pCity;
  if nb = 0 THEN
    RETURN 'NR';
  elsif nb = 1 THEN
    RETURN pCity;
  else
    RETURN 'Multiple-Ville';
 END IF;
END;
member function getpCityPop RETURN varchar
IS
NB number(7);
Begin
select nbCity into nb from t_v_cityName v where v.Cname = pCity;
  if nb = 0 THEN
    RETURN 'NR';
  elsif nb = 1 THEN
    RETURN pCityPop;
  else
    RETURN 'Multiple-Ville';
 END IF;
END;
member function getpSector RETURN varchar IS
NB number(7);
Begin
select nbSector into nb from t_v_sectorName v where v.Sname = pSector;
	if nb = 0 THEN
		RETURN 'NR';
	elsif nb = 1 THEN
		RETURN pSector;
	else
		RETURN 'Multiple-Sector';
  END IF;
END;
member function getpSectorSur RETURN varchar
IS
NB number(7);
Begin
select nbSector into nb from t_v_sectorName v where v.Sname = pSector;
	if nb = 0 THEN
		RETURN 'NR';
	elsif nb = 1 THEN
		RETURN pSectorSur;
	else
		RETURN 'Multiple-Sector';
  END IF;
END;
member function getpBestSeller RETURN varchar
IS
  theRank INTEGER;
Begin
SELECT theRank INTO theRank FROM t_v_prodRank v WHERE v.prod=SELF.pRef;
    IF theRank < 10 THEN
      RETURN 1;
    ELSE
	     RETURN 0;
   END IF;
   EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
END;
END;
/
Prompt ** BDT : Creation Des Fonctions : Table f_bdt_vente **
CREATE OR REPLACE TYPE BODY f_bdt_ventes_type IS
MEMBER FUNCTION getvNumber RETURN varchar is
BEGIN
	RETURN vNumber;
END;
MEMBER FUNCTION getvDate RETURN DATE is
BEGIN
 IF REGEXP_LIKE(vDate,'^[0-9]{4}\-[0-9]{2}\-[0-9]{2}$') THEN
   RETURN TO_DATE(vDate,'yyyy-mm-dd');
 ELSE
   RETURN TO_DATE('1111-01-01','yyyy-mm-dd');
 END IF;
END;
MEMBER FUNCTION getvClient RETURN varchar IS
	vFk number;
BEGIN
  IF vClient = 0 THEN
    RETURN 0;
  END IF;
  SELECT cl.cNum INTO vFk
    FROM f_dw_card cl
    WHERE cl.cNum=SELF.vClient;  
    RETURN vFk;
  EXCEPTION
    When Others Then
      RETURN -1;
END;
MEMBER FUNCTION getvClerk RETURN VARCHAR IS
	vFk number;
BEGIN
  IF vClerk = 0 THEN
    RETURN 0;
  END IF;
  SELECT cl.cNum INTO vFk
    FROM f_dw_clerk cl
    WHERE cl.cNum=SELF.vClerk;  
    RETURN vFk;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 1;
END;
MEMBER FUNCTION getvProduit RETURN VARCHAR IS
  vFk varchar(30);
BEGIN
  IF vProduit = '0' THEN
    RETURN 'NR';
  END IF;
    SELECT p.pRef INTO vFk
    FROM f_dw_product p
    WHERE p.pRef like SELF.vProduit;  
    RETURN vFk;
  EXCEPTION
      WHEN OTHERS THEN
        RETURN 'NR';
END;
END;
/