SELECT DISTINCt count(*) from f_bde_card;

select distinct count(*) from f_bde_card where LENGTH(cNumber) > 7;
select distinct count(*) from f_bdt_card where LENGTH(cNum) > 7;

select count(*) from t_v_clientnb where cnb <> 1 and LENGTH(cnum) <7;


insert into f_dw_card(cnum)
select distinct car.getcNum()
from f_bdt_card car;


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

insert into test(t3)
select distinct d.getdTemperature()
from f_bdt_date d;

select * from f_bdt_date where dTemperature=' ';
select * from f_bdt_date;

insert into test(t1,t2, t3, t4, t5, t6, t7)
select clerk.CNUM, clerk.CYEAR, clerk.CSTORE, st.SCITY, city.CPOP, st.SSECTOR, sector.SSUP
from f_bde_clerk clerk, f_bde_sector sector, f_bde_city city, f_bde_store st
where clerk.cstore = st.sref and st.SCITY = city.CNAME and st.SSECTOR = sector.SNAME;

select count(*) from f_bde_product;
select count(*) from f_bde_ventes;
select count(*) from f_bde_clerk;


CREATE OR REPLACE VIEW v_cityName
(nbCity, Cname)
AS select count(*), city.Cname from f_bde_city city GROUP BY city.Cname;
