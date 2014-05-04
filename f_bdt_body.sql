Prompt ** BDT : Creation Des Fonctions **
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
  IF dTemperature = 0 THEN
    RETURN 'No TEMP';
  ELSIF dTemperature < 40 THEN
    RETURN '1 - 39';
  ELSIF dTemperature < 60 THEN
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
member function getpPrice RETURN number
IS
BEGIN
	IF pPrice = 0 Then 
		RETURN '0';
	ELSIF pPrice < 50 THEN
		RETURN '0-49';
	ELSIF pPrice < 100 THEN	
		RETURN '50-100';
	ELSIF pPrice < 150 THEN	
		RETURN '100-149';
	else
		RETURN '150 et plus';
END;
member function getpType RETURN varchar
IS
BEGIN
	if pType THEN 
		RETURN pType;
	ELSE 
		RETURN 'NR';
END;
member function getpCity RETURN varchar
IS
NB number(7);
BEGIN
	select count(*) into nb from f_bde_city city where city.Cname = pCity
	if nb = 0 THEN
		RETURN 'NR';
	elsif nb = 1 THEN
		RETURN pCity;
	else
		RETURN 'Multiple-Ville';
END;
member function getpCityPop RETURN varchar
IS
NB number(7);
BEGIN
	select count(*) into nb from f_bde_city city where city.Cname = self.getpCity();
	if nb = 0 THEN
		RETURN 'NR';
	elsif nb = 1 THEN
		RETURN pCityPop;
	else
		RETURN 'Multiple-Ville';
END;
member function getpSector RETURN varchar
IS
NB number(7);
BEGIN
	select count(*) into nb from f_bde_sector s where s.sname = pSector;
	if nb = 0 THEN
		RETURN 'NR';
	elsif nb = 1 THEN
		RETURN pSector;
	else
		RETURN 'Multiple-Sector';
END;
member function getpSectorSur RETURN varchar
IS
NB number(7);
BEGIN
	select count(*) into nb from f_bde_sector s where s.sname = self.getpSector();
	if nb = 0 THEN
		RETURN 'NR';
	elsif nb = 1 THEN
		RETURN pSectorSup;
	else
		RETURN 'Multiple-Sector';
END;
member function getpBestSeller RETURN varchar
IS
  theRank INTEGER;
BEGIN
SELECT rank INTO theRank FROM
(
SELECT v.vProduit AS prod, RANK() OVER (ORDER BY count(*) DESC) AS rank
FROM f_bdt_ventes v, f_bdt_product p
WHERE v.vProduit=p.pRef
GROUP BY p.pRef
)
WHERE prod=SELF.pRef;
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
Prompt ** BDT : Creation Des Fonctions : Table f_bdt_card **
CREATE OR REPLACE TYPE BODY f_bdt_card_type IS
IS
BEGIN
END;
member function getcNum return varchar IS
BEGIN
	return cnum;
END;
member function getcSector return varchar IS
NB number(7);
BEGIN
	select count(*) into nb from f_bde_sector s where s.sname = cSector;
	if nb = 0 THEN
		RETURN 'NR';
	elsif nb = 1 THEN
		RETURN cSector;
	else
		RETURN 'Multiple-Sector';
END;
member function getcSectorSur return varchar IS
NB number(7);
BEGIN
	select count(*) into nb from f_bde_sector s where s.sname = self.getcSector();
	if nb = 0 THEN
		RETURN 'NR';
	elsif nb = 1 THEN
		RETURN pSectorSup;
	else
		RETURN 'Multiple-Sector';
END;
member function getcOccupation return varchar IS
BEGIN
	return cOccupation;
END;
member function getcHouse return varchar IS
BEGIN
	return cHouse;
END;
member function getHighSpender return varchar IS
  theRank INTEGER;
BEGIN
SELECT rank INTO theRank FROM
(
SELECT client.cnum AS cl, RANK() OVER (ORDER BY count(*) DESC) AS rank
FROM f_bdt_ventes v, f_bdt_card client
WHERE v.vClient=client.cNum
GROUP BY client.cNum
)
WHERE cl=SELF.cNum;
    IF theRank < 100 THEN
      RETURN 1;
    ELSE
	     RETURN 0;
   END IF;
  EXCEPTION
      WHEN OTHERS THEN
        RETURN 0;
END;
END;

Prompt ** BDT : Creation Des Fonctions : Table f_bdt_clerk **
member function getcNum return number IS
BEGIN
	RETURN cNum;
END;
member function getcExp return number IS
BEGIN
	Return cExp;
END;
member function getcStore return varchar IS
BEGIN
	return cStore;
END;
member function getcCity return varchar IS
NB number(7);
BEGIN
	select count(*) into nb from f_bde_city city where city.Cname = cCity
	if nb = 0 THEN
		RETURN 'NR';
	elsif nb = 1 THEN
		RETURN cCity;
	else
		RETURN 'Multiple-Ville';
END;
member function getcCityPop return varchar IS
NB number(7);
BEGIN
	select count(*) into nb from f_bde_city city where city.Cname = self.getcCity();
	if nb = 0 THEN
		RETURN 'NR';
	elsif nb = 1 THEN
		RETURN cCityPop;
	else
		RETURN 'Multiple-Ville';
END;
member function getcSector return varchar IS
NB number(7);
BEGIN
	select count(*) into nb from f_bde_sector s where s.sname = cSector;
	if nb = 0 THEN
		RETURN 'NR';
	elsif nb = 1 THEN
		RETURN cSector;
	else
		RETURN 'Multiple-Sector';
END;
member function getcSectorSur return varchar IS
NB number(7);
BEGIN
	select count(*) into nb from f_bde_sector s where s.sname = self.getcSector();
	if nb = 0 THEN
		RETURN 'NR';
	elsif nb = 1 THEN
		RETURN pSectorSup;
	else
		RETURN 'Multiple-Sector';
END;
member function getcBestClerk return varchar IS
BEGIN
	return 0;
END;
member function getcBestStore return varchar IS
BEGIN
	return 0;
END;
END;

Prompt ** BDT : Creation Des Fonctions : Table f_bdt_vente **
CREATE OR REPLACE TYPE BODY f_bdt_vente_type IS
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
MEMBER FUNCTION getvClient RETURN NUMBER IS
	vFk number
BEGIN
  IF vClient = 0 THEN
    RETURN 0;
  END IF;
  SELECT cl.cNum INTO vFk
    FROM f_dw_card cl
    WHERE cl.cNum=SELF.vClient;  
    RETURN vFk;

  EXCEPTION
    WHEN OTHERS THEN
      RETURN 1;
END;
MEMBER FUNCTION getvClerk RETURN VARCHAR IS
	vFk number
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
      RETURN 1;END;
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
