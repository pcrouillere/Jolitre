drop table test;
create table test(
t1 date,
t2 varchar(50),
t3 varchar(50),
t4 varchar(50),
t5 varchar(50),
t6 varchar(50),
t7 varchar(50)
);

insert into test(t1,t2, t3, t4, t5, t6)
select distinct d.getdDate(), d.getdTemperature(), d.getJourDeSemaine(), d.getSemaine(), d.getMois(), d.getAnnee()
from f_bdt_date d
where rownum < 10;


member function getdDate return Date,
member function getdTemperature return varchar, 
member function getJourDeSemaine return varchar,
member function getSemaine return number,
member function getMois return number,
member function getAnnee return number


insert into test(t1,t2, t3, t4, t5, t6, t7)
select clerk.CNUM, clerk.CYEAR, clerk.CSTORE, st.SCITY, city.CPOP, st.SSECTOR, sector.SSUP
from f_bde_clerk clerk, f_bde_sector sector, f_bde_city city, f_bde_store st
where clerk.cstore = st.sref and st.SCITY = city.CNAME and st.SSECTOR = sector.SNAME;

select count(*) from f_bde_product;
select count(*) from f_bde_ventes;
select count(*) from f_bde_clerk;