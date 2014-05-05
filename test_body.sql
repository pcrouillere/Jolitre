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
    WHEN OTHERS THEN
      RETURN 1;
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

select p.getvDate() from f_bdt_ventes p where rownum < 10;
select p.getvNumber() from f_bdt_ventes p where rownum < 10;
select p.getvProduit() from f_bdt_ventes p where rownum < 10;
select p.getvClerk() from f_bdt_ventes p where rownum < 10;
select p.getvClient() from f_bdt_ventes p where rownum < 100;

CREATE OR REPLACE TYPE BODY f_bdt_clerk_type IS
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
	select count(*) into nb from f_bde_city city where city.Cname = cCity;
	if nb = 0 THEN
		RETURN 'NR';
	elsif nb = 1 THEN
		RETURN cCity;
	else
		RETURN 'Multiple-Ville';
  END IF;
END;
member function getcCityPop return varchar IS
NB number(7);
BEGIN
	select count(*) into nb from f_bde_city city where city.Cname = cCity;
	if nb = 0 THEN
		RETURN 'NR';
	elsif nb = 1 THEN
		RETURN cCityPop;
	else
		RETURN 'Multiple-Ville';
  END IF;
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
  END IF;
END;
member function getcSectorSur return varchar IS
NB number(7);
BEGIN
	select count(*) into nb from f_bde_sector s where s.sname = cSector;
	if nb = 0 THEN
		RETURN 'NR';
	elsif nb = 1 THEN
		RETURN cSectorSur;
	else
		RETURN 'Multiple-Sector';
  END IF;
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

select p.getcNum() from f_bdt_clerk p where rownum < 10;
select p.getcExp() from f_bdt_clerk p where rownum < 10;
select p.getcStore() from f_bdt_clerk p where rownum < 10;
select p.getcCity() from f_bdt_clerk p where rownum < 10;
select p.getcCityPop() from f_bdt_clerk p where rownum < 10;
select p.getcSector() from f_bdt_clerk p where rownum < 10;
select p.getcSectorSur() from f_bdt_clerk p where rownum < 10;
select p.getcBestClerk() from f_bdt_clerk p where rownum < 10;

CREATE OR REPLACE TYPE BODY f_bdt_card_type IS
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
  END IF;
END;
member function getcSectorSur return varchar IS
NB number(7);
BEGIN
	select count(*) into nb from f_bde_sector s where s.sname = cSector;
	if nb = 0 THEN
		RETURN 'NR';
	elsif nb = 1 THEN
		RETURN cSectorSur;
	else
		RETURN 'Multiple-Sector';
  END IF;
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

select p.getcNum() from f_bdt_card p where rownum < 10;
select p.getcSector() from f_bdt_card p where rownum < 10;
select p.getcSectorSur() from f_bdt_card p where rownum < 10;
select p.getcOccupation() from f_bdt_card p where rownum < 10;
select p.getcHouse() from f_bdt_card p where rownum < 10;
select p.getHighSpender() from f_bdt_card p where rownum < 10;


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
BEGIN
	select count(*) into nb from f_bde_city city where city.Cname = pCity;
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
BEGIN
	select count(*) into nb from f_bde_city city where city.Cname = pCity;
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
BEGIN
	select count(*) into nb from f_bde_sector s where s.sname = pSector;
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
BEGIN
	select count(*) into nb from f_bde_sector s where s.sname = pSector;
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

select * from f_bdt_product where pprice=55;
select p.getpBestSeller() from f_bdt_product p where rownum <10;
select * from f_bdt_product p where p.getpCity()='Multiple-Ville';

select count(*) from f_bde_product;
select distinct count(*) from f_bdt_product p;
select p.getpRef() from f_bdt_product p;
select p.getpPrice() from f_bdt_product p;
select p.getpType() from f_bdt_product p;
select p.getpCity() from f_bdt_product p;
select p.getpCityPop() from f_bdt_product p;
select p.getpSector() from f_bdt_product p;
select p.getpSector() from f_bdt_product p;
select p.getpBestSeller() from f_bdt_product p;

member function getpRef return varchar,
member function getpPrice return varchar,
member function getpType return varchar,
member function getpCity return varchar,
member function getpCityPop return varchar,
member function getpSector return varchar,
member function getpSectorSur return varchar,
member function getpBestSeller return varchar


drop table test;
create table test(
t1 varchar(50),
t2 varchar(50),
t3 varchar(50),
t4 varchar(50),
t5 varchar(50),
t6 varchar(50),
t7 varchar(50)
);