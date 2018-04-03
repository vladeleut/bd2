--01
CREATE TABLE carro(
    id_carro number(3) not null,
    placa varchar2(8) not null,
    marca varchar2(20) not null,
    modelo varchar2(30) not null,
    cor varchar2(20), 
    ano_fabric number(4),
    data_licenc date,
    multas char(1),
    valor number(9,2),
    km number(8,2),
    id_proprietario number(3),
    constraint carro_pk primary key (id_carro),
    constraint carro_placa_uk unique (placa),
    constraint carro_multas_ck check (placa in ('S','N','s','n'))
);
ALTER TABLE carro DROP constraint carro_multas_ck
ALTER TABLE carro add constraint carro_multas_ck check (multas in ('S','N','s','n'))
desc carro

--02
CREATE TABLE proprietario(
    id_proprietario number(3) not null, 
    nome varchar2(40) not null,
    endereco varchar2(40) not null,
    data_nasc date not null,
    constraint propr_pk primary key (id_proprietario),
    constraint propr_nome_uk unique(nome)
);

--03
alter table carro add constraint carro_proprid_fk foreign key (id_proprietario) references proprietario(id_proprietario)

--04
insert into carro values(1,'BDD-4567','VOLKSWAGEN','GOL','BRANCO',2008,to_date('02/02/2014','dd/mm/yyyy'),'N',24300.00,45340.00,NULL);
insert into carro values(2, 'ABC-9876', 'CHEVROLET', 'COBALT', 'AZUL',2011 , to_date('10/06/2013', 'dd/mm/yyyy'), 'N',36700 ,22340 ,null);
insert into carro values(3, 'XYZ-5544', 'VOLKSWAGEN', 'VOYAGE', 'VERDE',2003 , to_date('', 'dd/mm/yyyy'), 'S',23450 ,55760 , null);
insert into carro values(4, 'GOL-1234', 'CHEVROLET', 'PRISMA', 'PRETO',2005 , to_date('07/01/2014', 'dd/mm/yyyy'), 'N',18200 ,33000 ,null );

select * from carro;
desc proprietario;

--05
insert into proprietario values (10, 'João Pedro', 'R. S Carlos, 234', to_date('17/05/1976','dd/mm/yyyy'));
insert into proprietario values (20, 'Ingrid da Silva', 'R. das Plantas, 76', to_date('12/03/1985','dd/mm/yyyy'));
insert into proprietario values (30, 'Paulo dos Santos', 'Av. Praia, 14', to_date('09/12/1981','dd/mm/yyyy'));
insert into proprietario values (40, 'Fábio Machado', 'Rua da Paz, 66', to_date('08/03/1984','dd/mm/yyyy'));
select * from proprietario order by id_proprietario desc;

--06
commit;

select * from carro;
select id_proprietario, nome from proprietario where nome like 'João%';

--07
update carro set id_proprietario = 10 where id_carro=1 or id_carro = 3;
update carro set id_proprietario = 20 where id_carro=2;
update carro set id_proprietario = 30 where id_carro = 4;

--08
select * from carro;
commit;

--09
alter table proprietario add cpf varchar2(20);
--10
alter table proprietario add cidade varchar2(30);
--11
alter table proprietario add salario number(8,2) default '0';
select * from proprietario;
--12
alter table proprietario modify cidade varchar2(30) default 'São Carlos';

select * from proprietario;
--13
alter table proprietario modify cpf varchar2(14);
--14
alter table proprietario drop column salario;

--15
insert into proprietario (id_proprietario, nome, endereco, data_nasc) values (50, 'Chico Mineiro', 'Av. do Beco, 22', to_date('07/06/1957','dd/mm/yyyy'));
select cidade from proprietario;
--16
update proprietario set cidade='São Carlos';
--17
commit;

--18
alter table proprietario add constraint propr_cpf_uk unique (cpf);
--19
alter table proprietario add constraint propr_nasc_ck check (data_nasc > to_date('01/01/1900','dd/mm/yyyy'));
--20
delete from proprietario where nome like 'Ingrid%';
--21
delete from proprietario where nome like 'Chico%';
--22
commit;

--23
alter table carro drop constraint carro_proprid_fk;
alter table carro add constraint carro_proprid_fk foreign key (id_proprietario) references proprietario(id_proprietario) on delete set null;

--24
select * from proprietario;
select * from carro;
delete from proprietario where nome like 'Ingrid%';
select * from proprietario;
select * from carro;

--25
commit;

--26
alter table carro drop constraint carro_proprid_fk;
alter table carro add constraint carro_proprid_fk foreign key (id_proprietario) references proprietario(id_proprietario) on delete cascade;

-27
select * from proprietario;
select * from carro;
delete from proprietario where nome like 'João Pedro%';
select * from proprietario;
select * from carro;

--28
commit;


