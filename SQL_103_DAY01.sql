-- DDL - DATA DEFINITION LANG.
-- CREATE - TABLO OLUSTURMA
CREATE TABLE ogrenciler1
(
ogrenci_no char(7),
	isim varchar(20),
	soyisim varchar(25),
	not_ort real, --Ondalikli sayilar icin kullanilir(double gibi)
	kayit_tarih date
);

--VAROLAN TABLODAN YENI BIR TABLO OLUSTURMA
CREATE TABLE ogrenci_notlari
AS --Benzer tablodaki basliklarla ve data tipleriyle yeni bir tablo olusturmak icin
--   normal tablo olustururken ki parantezler yerine AS kullanip
--   Select komutuyla almak istediginiz verileri aliriz
SELECT isim,soyisim,not_ort FROM ogrenciler1;

--DML - DATA MANUPULATION LANG.
-- INSERT (DATABASE'E VERI EKLEME)

INSERT INTO ogrenciler1 VALUES ('1234567','Said','Ilhan',85.5,now());
INSERT INTO ogrenciler1 VALUES ('1234567','Said','Ilhan',85.5,'2020-12-11');

-- BIR TABLOYA PARCALI VERI EKLEMEK ISTERSEK
INSERT INTO ogrenciler1 (isim,soyisim) VALUES ('Ozlem','Can');

-- DQL - DATA QUERY LANG.
-- SELECT

select * FROM ogrenciler1; --Burdaki * herseyi anlamindadir
