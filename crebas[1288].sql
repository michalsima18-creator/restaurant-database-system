/*==============================================================*/
/* DBMS name:      ORACLE Version 10g                           */
/* Created on:     05.12.2018 11:12:56                          */
/*==============================================================*/


alter table POLOZKA_1
   drop constraint FK_POLOZKA__POLOZKA_1_JIDLO;

alter table POLOZKA_1
   drop constraint FK_POLOZKA__POLOZKA_2_UCET;

alter table POLOZKA_2
   drop constraint FK_POLOZKA__POLOZKA_3_UCET;

alter table POLOZKA_2
   drop constraint FK_POLOZKA__POLOZKA_4_PITI;

alter table UCET
   drop constraint FK_UCET_NA_POBOCC_POBOCKA;

alter table UCET
   drop constraint FK_UCET_OBJEDNAVA_ZAKAZNIK;

alter table ZAMESTNANEC
   drop constraint FK_ZAMESTNA_PRACUJE_POBOCKA;

drop index POLOZKA_1_FK;

drop index POLOZKA_2_FK;

drop index POLOZKA_3_FK;

drop index POLOZKA_4_FK;

drop index NA_POBOCCE_FK;

drop index OBJEDNAVA_FK;

drop index PRACUJE_FK;

drop table JIDLO cascade constraints;

drop table PITI cascade constraints;

drop table POBOCKA cascade constraints;

drop table POLOZKA_1 cascade constraints;

drop table POLOZKA_2 cascade constraints;

drop table UCET cascade constraints;

drop table ZAKAZNIK cascade constraints;

drop table ZAMESTNANEC cascade constraints;

/*==============================================================*/
/* Table: JIDLO                                                 */
/*==============================================================*/
create table JIDLO  (
   ID_JIDLA             INTEGER                         not null
      constraint CKC_ID_JIDLA_JIDLO check (ID_JIDLA >= 1),
   NAZEV                VARCHAR2(30)                    not null,
   TYP_CHODU            VARCHAR2(2)                     not null,
   CENA                 INTEGER                         not null
      constraint CKC_CENA_JIDLO check (CENA >= 1),
   ALERGENY             VARCHAR2(20)                    not null,
   constraint PK_JIDLO primary key (ID_JIDLA)
);

/*==============================================================*/
/* Table: PITI                                                  */
/*==============================================================*/
create table PITI  (
   ID_PITI              INTEGER                         not null
      constraint CKC_ID_PITI_PITI check (ID_PITI >= 1),
   NAZEV                VARCHAR2(30)                    not null,
   CENA                 INTEGER                         not null
      constraint CKC_CENA_PITI check (CENA >= 1),
   ALKOHOL              VARCHAR2(3)                     not null
      constraint CKC_ALKOHOL_PITI check (ALKOHOL in ('Ano','Ne')),
   constraint PK_PITI primary key (ID_PITI)
);

/*==============================================================*/
/* Table: POBOCKA                                               */
/*==============================================================*/
create table POBOCKA  (
   ID_POBOCKY           INTEGER                         not null
      constraint CKC_ID_POBOCKY_POBOCKA check (ID_POBOCKY >= 1),
   NAZEV                VARCHAR2(30)                    not null,
   ULICE                VARCHAR2(40)                    not null,
   PSC                  INTEGER                         not null,
   MESTO                VARCHAR2(20)                    not null,
   constraint PK_POBOCKA primary key (ID_POBOCKY)
);

/*==============================================================*/
/* Table: POLOZKA_1                                             */
/*==============================================================*/
create table POLOZKA_1  (
   ID_JIDLA             INTEGER                         not null,
   ID_UCET              INTEGER                         not null,
   POCET_JIDLA          INTEGER                         not null
      constraint CKC_POCET_JIDLA_POLOZKA_ check (POCET_JIDLA >= 1),
   constraint PK_POLOZKA_1 primary key (ID_JIDLA, ID_UCET)
);

/*==============================================================*/
/* Index: POLOZKA_1_FK                                          */
/*==============================================================*/
create index POLOZKA_1_FK on POLOZKA_1 (
   ID_JIDLA ASC
);

/*==============================================================*/
/* Index: POLOZKA_2_FK                                          */
/*==============================================================*/
create index POLOZKA_2_FK on POLOZKA_1 (
   ID_UCET ASC
);

/*==============================================================*/
/* Table: POLOZKA_2                                             */
/*==============================================================*/
create table POLOZKA_2  (
   ID_UCET              INTEGER                         not null,
   ID_PITI              INTEGER                         not null,
   POCET_PITI           INTEGER                         not null
      constraint CKC_POCET_PITI_POLOZKA_ check (POCET_PITI >= 1),
   constraint PK_POLOZKA_2 primary key (ID_UCET, ID_PITI)
);

/*==============================================================*/
/* Index: POLOZKA_3_FK                                          */
/*==============================================================*/
create index POLOZKA_3_FK on POLOZKA_2 (
   ID_UCET ASC
);

/*==============================================================*/
/* Index: POLOZKA_4_FK                                          */
/*==============================================================*/
create index POLOZKA_4_FK on POLOZKA_2 (
   ID_PITI ASC
);

/*==============================================================*/
/* Table: UCET                                                  */
/*==============================================================*/
create table UCET  (
   ID_UCET              INTEGER                         not null
      constraint CKC_ID_UCET_UCET check (ID_UCET >= 1),
   XNAME                VARCHAR2(10)                    not null,
   ID_POBOCKY           INTEGER                         not null,
   DATUM_NAVSTEVY       DATE                            not null,
   constraint PK_UCET primary key (ID_UCET)
);

/*==============================================================*/
/* Index: OBJEDNAVA_FK                                          */
/*==============================================================*/
create index OBJEDNAVA_FK on UCET (
   XNAME ASC
);

/*==============================================================*/
/* Index: NA_POBOCCE_FK                                         */
/*==============================================================*/
create index NA_POBOCCE_FK on UCET (
   ID_POBOCKY ASC
);

/*==============================================================*/
/* Table: ZAKAZNIK                                              */
/*==============================================================*/
create table ZAKAZNIK  (
   XNAME                VARCHAR2(10)                    not null,
   JMENO                VARCHAR2(30)                    not null,
   PRIJMENI             VARCHAR2(40)                    not null,
   STAV_KONTA           INTEGER                         not null
      constraint CKC_STAV_KONTA_ZAKAZNIK check (STAV_KONTA >= 0),
   DATUM_NAROZENI       DATE                            not null,
   constraint PK_ZAKAZNIK primary key (XNAME)
);

/*==============================================================*/
/* Table: ZAMESTNANEC                                           */
/*==============================================================*/
create table ZAMESTNANEC  (
   ID_ZAMESTNANCE       INTEGER                         not null
      constraint CKC_ID_ZAMESTNANCE_ZAMESTNA check (ID_ZAMESTNANCE >= 1),
   ID_POBOCKY           INTEGER                         not null,
   JMENO                VARCHAR2(30)                    not null,
   PRIJMENI             VARCHAR2(40)                    not null,
   POZICE               VARCHAR2(30)                    not null,
   PLAT                 INTEGER                         not null
      constraint CKC_PLAT_ZAMESTNA check (PLAT >= 12000),
   TELEFON              INTEGER                         not null,
   constraint PK_ZAMESTNANEC primary key (ID_ZAMESTNANCE)
);

/*==============================================================*/
/* Index: PRACUJE_FK                                            */
/*==============================================================*/
create index PRACUJE_FK on ZAMESTNANEC (
   ID_POBOCKY ASC
);

alter table POLOZKA_1
   add constraint FK_POLOZKA__POLOZKA_1_JIDLO foreign key (ID_JIDLA)
      references JIDLO (ID_JIDLA);

alter table POLOZKA_1
   add constraint FK_POLOZKA__POLOZKA_2_UCET foreign key (ID_UCET)
      references UCET (ID_UCET);

alter table POLOZKA_2
   add constraint FK_POLOZKA__POLOZKA_3_UCET foreign key (ID_UCET)
      references UCET (ID_UCET);

alter table POLOZKA_2
   add constraint FK_POLOZKA__POLOZKA_4_PITI foreign key (ID_PITI)
      references PITI (ID_PITI);

alter table UCET
   add constraint FK_UCET_NA_POBOCC_POBOCKA foreign key (ID_POBOCKY)
      references POBOCKA (ID_POBOCKY);

alter table UCET
   add constraint FK_UCET_OBJEDNAVA_ZAKAZNIK foreign key (XNAME)
      references ZAKAZNIK (XNAME);

alter table ZAMESTNANEC
   add constraint FK_ZAMESTNA_PRACUJE_POBOCKA foreign key (ID_POBOCKY)
      references POBOCKA (ID_POBOCKY);

INSERT INTO "SIMM14"."ZAKAZNIK" (XNAME, JMENO, PRIJMENI, STAV_KONTA, DATUM_NAROZENI) VALUES ('novj15', 'Jan', 'Novák', '0', TO_DATE('05.12.97', 'DD.MM.RR'));
INSERT INTO "SIMM14"."ZAKAZNIK" (XNAME, JMENO, PRIJMENI, STAV_KONTA, DATUM_NAROZENI) VALUES ('suca16', 'Adam', 'Suchý', '100', TO_DATE('18.07.98', 'DD.MM.RR'));
INSERT INTO "SIMM14"."ZAKAZNIK" (XNAME, JMENO, PRIJMENI, STAV_KONTA, DATUM_NAROZENI) VALUES ('pokt17', 'Tomáš', 'Pokorný', '1000', TO_DATE('21.03.99', 'DD.MM.RR'));

INSERT INTO "SIMM14"."POBOCKA" (ID_POBOCKY, NAZEV, ULICE, PSC, MESTO) VALUES ('1', 'Italská', 'Nám. W. Churchilla 4', '13067', 'Praha 3');
INSERT INTO "SIMM14"."POBOCKA" (ID_POBOCKY, NAZEV, ULICE, PSC, MESTO) VALUES ('2', 'Volha', 'K Verneráku 940/45', '14800', 'Praha 4');
INSERT INTO "SIMM14"."POBOCKA" (ID_POBOCKY, NAZEV, ULICE, PSC, MESTO) VALUES ('3', 'Jarov', 'Jeseniova 208', '13000', 'Praha 3');

INSERT INTO "SIMM14"."JIDLO" (ID_JIDLA, NAZEV, CENA, ALERGENY) VALUES ('1', 'tìstoviny', '50', '1,2');
INSERT INTO "SIMM14"."JIDLO" (ID_JIDLA, NAZEV, CENA, ALERGENY) VALUES ('2', 'svíèková', '60', '3,4');
INSERT INTO "SIMM14"."JIDLO" (ID_JIDLA, NAZEV, CENA, ALERGENY) VALUES ('3', 'pizza', '100', '5,6');

INSERT INTO "SIMM14"."PITI" (ID_PITI, NAZEV, CENA, ALKOHOL) VALUES ('1', 'Cola', '30', 'Ne');
INSERT INTO "SIMM14"."PITI" (ID_PITI, NAZEV, CENA, ALKOHOL) VALUES ('2', 'Pivo', '25', 'Ano');
INSERT INTO "SIMM14"."PITI" (ID_PITI, NAZEV, CENA, ALKOHOL) VALUES ('3', 'Káva', '40', 'Ne');

INSERT INTO "SIMM14"."OBJEDNAVKA" (ID_OBJEDNAVKY, XNAME, ID_POBOCKY, DATUM_NAVSTEVY) VALUES ('1', 'novj15', '1', TO_DATE('05.12.18', 'DD.MM.RR'));
INSERT INTO "SIMM14"."OBJEDNAVKA" (ID_OBJEDNAVKY, XNAME, ID_POBOCKY, DATUM_NAVSTEVY) VALUES ('2', 'suca16', '2', TO_DATE('05.05.18', 'DD.MM.RR'));
INSERT INTO "SIMM14"."OBJEDNAVKA" (ID_OBJEDNAVKY, XNAME, ID_POBOCKY, DATUM_NAVSTEVY) VALUES ('3', 'pokt17', '3', TO_DATE('15.10.18', 'DD.MM.RR'));

INSERT INTO "SIMM14"."POLOZKA_1" (ID_JIDLA, ID_UCET, POCET_JIDLA) VALUES ('1', '1', '5');
INSERT INTO "SIMM14"."POLOZKA_1" (ID_JIDLA, ID_UCET, POCET_JIDLA) VALUES ('2', '2', '3');
INSERT INTO "SIMM14"."POLOZKA_1" (ID_JIDLA, ID_UCET, POCET_JIDLA) VALUES ('3', '3', '1');

INSERT INTO "SIMM14"."POLOZKA_2" (ID_OBJEDNAVKY, ID_PITI, POCET_PITI) VALUES ('1', '1', '6');
INSERT INTO "SIMM14"."POLOZKA_2" (ID_OBJEDNAVKY, ID_PITI, POCET_PITI) VALUES ('2', '2', '4');
INSERT INTO "SIMM14"."POLOZKA_2" (ID_OBJEDNAVKY, ID_PITI, POCET_PITI) VALUES ('3', '3', '2');


grant select on JIDLO to Student;
grant select, insert, update, delete on JIDLO to DB4IT218;

grant select on PITI to Student;
grant select, insert, update, delete on PITI to DB4IT218;

grant select on POBOCKA to Student;
grant select, insert, update, delete on POBOCKA to DB4IT218;

grant select on POLOZKA_1 to Student;
grant select, insert, update, delete on POLOZKA_1 to DB4IT218;

grant select on POLOZKA_2 to Student;
grant select, insert, update, delete on POLOZKA_2 to DB4IT218;

grant select on UCET to Student;
grant select, insert, update, delete on UCET to DB4IT218;

grant select on ZAKAZNIK to Student;
grant select, insert, update, delete on ZAKAZNIK to DB4IT218;

grant select on ZAMESTNANEC to Student;
grant select, insert, update, delete on ZAMESTNANEC to DB4IT218;



create or replace TRIGGER Datum_Zakaznik
BEFORE INSERT OR UPDATE ON ZAKAZNIK
FOR EACH ROW
BEGIN
IF (:NEW.DATUM_NAROZENI > SYSDATE - 5475 ) THEN
RAISE_APPLICATION_ERROR(-20000, 'Zákazníkovi nemùže být ménì než 15 let.');
END IF;
END;


-----------------


create or replace TRIGGER Datum_Navstevy
BEFORE INSERT OR UPDATE ON UCET
FOR EACH ROW
BEGIN
IF (:NEW.DATUM_NAVSTEVY > SYSDATE ) THEN
RAISE_APPLICATION_ERROR(-20000, 'Úèet nemùže být z budoucnosti.');
END IF;
END;



-----------------



create or replace 
trigger Narozeni_Navsteva
BEFORE INSERT OR UPDATE ON UCET
FOR EACH ROW
DECLARE narozeni date;
BEGIN
SELECT DATUM_NAROZENI
INTO   narozeni
FROM   ZAKAZNIK
WHERE  XNAME = :new.XNAME;

IF (:NEW.DATUM_NAVSTEVY < narozeni + 5475) THEN
RAISE_APPLICATION_ERROR(-20000, 'Zákazník v dobì vystavení úètu eštì nebylo 15 a tak nemùže být zákazníkem.');
END IF;
END;