CREATE TABLE ogrenciler5
(
ogrenci_no char(7),
	isim varchar(20),
	soyisim varchar(25),
	not_ort real, --Ondalikli sayilar icin kullanilir(double gibi)
	kayit_tarih date
);

--VAROLAN BIR TABLODAN YENI BIR TABLO OLUSTURMA
Create Table NOTLAR
AS
SELECT isim,not_ort FROM ogrenciler1;

select * from notlar;

INSERT INTO notlar VALUES ('Fatma',95.5);

create table talebeler
(
isim varchar(10),
notlar real
	);
	INSERT INTO notlar VALUES ('Fatma',95.5);
	INSERT INTO notlar VALUES ('Ali',75.5);
	INSERT INTO notlar VALUES ('Adem',65.5);
	INSERT INTO notlar VALUES ('Zehra',55.5);
	INSERT INTO notlar VALUES ('Gunay',75.5);
	INSERT INTO notlar VALUES ('Sumeyye',95.5);
	select * from notlar;
	
	select isim from talebeler;
	
--CONSTRAINT
--UNIQUE
--NOT NULL

CREATE TABLE ogrenciler7
(
ogrenci_no char(7) unique, --Tekrarsiz olmasini istiyorsak
	isim varchar(20) not null, --not null i constraint olarak kabul etmez,isimin bos gecmesini istemiyorsam
	soyisim varchar(25),
	not_ort real, --Ondalikli sayilar icin kullanilir(double gibi)
	kayit_tarih date
);
	select * from ogrenciler7;
	
	INSERT INTO ogrenciler7 VALUES ('1234567','Fatma','Can',75.5,now());
	INSERT INTO ogrenciler7 VALUES ('1234568','Ali','Veli',75.5,now());
	INSERT INTO ogrenciler7 (ogrenci_no,soyisim,not_ort) VALUES ('1234569','Ahmet',85.5); --NOT NULL kisitlamasi oldugu icin bu veri eklenemez
	
	
	-- PRIMARY KEY atamasi
	
CREATE TABLE ogrenciler8
(
ogrenci_no char(7) PRIMARY KEY, 
	isim varchar(20) , 
	soyisim varchar(25),
	not_ort real, 
	kayit_tarih date
);

-- PRIMARY KEY atamasi 2:yol

	
CREATE TABLE ogrenciler9
(
ogrenci_no char(7), 
	isim varchar(20) , 
	soyisim varchar(25),
	not_ort real, 
	kayit_tarih date,
	CONSTRAINT ogr PRIMARY KEY(ogrenci_no)
);
--3:yol
CREATE TABLE ogrenciler10
(
ogrenci_no char(7), 
	isim varchar(20) , 
	soyisim varchar(25),
	not_ort real, 
	kayit_tarih date,
	PRIMARY KEY(ogrenci_no)
);

-- FOREIGN KEY
/*
Practice 4:
“tedarikciler3” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”, “iletisim_isim” field’lari olsun ve “tedarikci_id” yi Primary Key yapin.
“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve
“tedarikci_id” yi Foreign Key yapin.
*/
create table tedarikciler3
(
tedarikci_id char(5) PRIMARY KEY,
	tedarikci_ismi varchar(20),
	iletisim_isim varchar(20)
);

CREATE TABLE urunler
(
tedarikci_id char(5),
urun_id char(5),
FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3(tedarikci_id)
);

-- Kendimiz isim atadik
CREATE TABLE urunler
(
tedarikci_id char(5),
urun_id char(5),
CONSTRAINT urun_fk FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3(tedarikci_id)
);

 select * from tedarikciler3;
 
 select * from urunler;
 
 /*
 “calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama” field’lari olsun.
 “id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın.
“adresler” isminde baska bir tablo olusturun.Icinde “adres_id”, “sokak”, “cadde” ve “sehir” 
fieldlari olsun. “adres_id” field‘i ile Foreign Key oluşturun.
*/
CREATE TABLE calisanlar
(
id varchar(15) PRIMARY KEY,
isim varchar(30) UNIQUE,
maas int NOT NULL,
ise_baslama date
);
CREATE TABLE adresler
(
adres_id varchar(30),
sokak varchar(30),
cadde varchar(30),
sehir varchar(30),
FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14');--UNIQUE CONS.kabul etmez
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12');--NOT NULL CONS.kabul etmez
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14');--UNIQUE CONS.kabul etmez
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14');--int (string girilmez)
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14');--PRIMARY KEY
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14');--PRIMARY KEY
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14');--PRIMARY KEY

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');

-- FK'ye null değeri atanabilir.
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');

SELECT * FROM calisanlar1;
SELECT * FROM adresler;

--CHECK CONSTRAINT
CREATE TABLE calisanlar1
(
id varchar(15) PRIMARY KEY,
isim varchar(30) UNIQUE,
maas int CHECK (maas>10000),
ise_baslama date
);

INSERT INTO calisanlar1 VALUES('10002', 'Mehmet Yılmaz' ,19000, '2018-04-14');


--DQL -- WHERE KULLANIMI
SELECT * FROM calisanlar;
select  isim from calisanlar;

-- Calisanlar tablosundan maasi 5000 den buyuk olan isimleri listeleyin
SELECT isim,maas FROM calisanlar WHERE maas>5000;

-- Calisanlar tablosundan ismi Veli Han olan tum verileri listeleyin
SELECT * FROM calisanlar WHERE isim='Veli Han';

-- Calisanlar tablosundan maasi 5000 olan tum verileri listeleyin
SELECT * FROM calisanlar WHERE maas=5000;

--DML -- DELETE KOMUTU
--DELETE FROM calisanlar; --Eger Parent tablo baska bir child tablo ile iliskili ise once child tablo silinmelidir
--DELETE FROM adresler;
select * from adresler;

-- Adresler tablosundan sehri Antep olan verileri silelim
DELETE FROM adresler WHERE sehir='Antep';

-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.
CREATE TABLE ogrenciler11
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO ogrenciler11 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler11 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler11 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler11 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler11 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler11 VALUES(127, 'Mustafa Bak', 'Ali', 99);