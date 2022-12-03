--SUBQUERIES
DROP TABLE if exists calisanlar2

CREATE TABLE calisanlar2
(
id int,
isim VARCHAR(50),
sehir VARCHAR(50),
maas int,
isyeri VARCHAR(20)
);
CREATE TABLE markalar (
marka_id int,
marka_isim VARCHAR(20),
calisan_sayisi int
);
INSERT INTO calisanlar2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);
INSERT INTO markalar VALUES(103, 'Nike', 19000); --Bunu getirmez,cunku bagli degil,isyeri sutununda yok

select * from calisanlar2
select * from markalar

-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini 
--ve bu markada calisanlarin isimlerini ve maaşlarini listeleyin.
SELECT isim,maas,isyeri FROM calisanlar2
WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE calisan_sayisi>15000); --Calistirirken iki satiri beraber calistirmamiz gerek

-- marka_id’si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz.
SELECT isim,maas,sehir FROM calisanlar2
WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE marka_id>101);

--ÖDEV- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.


-- AGGREGATE METHOD

-- Calisanlar tablosundan en yuksek maası listeleyelim
SELECT max(maas) AS maksimum_maas FROM calisanlar2; 
/*
    Eğer bir sutuna geçici olarak bir isim vermek istersek AS komutunu yazdıktan sonra
vermek istediğimiz ismi yazarız
*/

-- Calisanlar tablosundan en dusuk maası listeleyelim
SELECT min(maas) AS en_dusuk_maas FROM calisanlar2;

-- Calisanlar tablosundaki maaslarin toplamini listeleyelim
SELECT sum(maas) FROM calisanlar2

-- Maaslarin ortalamasi
SELECT avg(maas) FROM calisanlar2

-- Yuvarlama
SELECT round(avg(maas)) FROM calisanlar2 --sayiyi yuvarladik
SELECT round(avg(maas),2) FROM calisanlar2 --virgulden sonra 2 basamak verir

-- Maaslarin sayisi
SELECT count(maas) FROM calisanlar2 --maas yerine * koyupta yazrsak yine ayni seyi verir
/*
Eger count(*) kullanirsak tablodaki tum satirlari verir
Sutun adı kullanırsak o sutundaki sayıları verir
*/


select * from calisanlar2
select * from markalar

-- AGGREGATE METHODLARDA SUBQUERY
-- Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz
SELECT marka_id,marka_isim,(SELECT count(sehir) as sehir_sayisi FROM calisanlar2 where marka_isim=isyeri)
FROM markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz
CREATE VIEW summaas
AS
SELECT marka_isim,calisan_sayisi,
(SELECT sum(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as toplam_maas
FROM markalar

SELECT * FROM summaas

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin 
--maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.
SELECT marka_isim,calisan_sayisi,
(SELECT max(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as enyuksekmaas,
(SELECT min(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as endusukmaas
FROM markalar

-- VIEW KULLANIMI
/*
Yaptigimiz sorgulari hafizaya alir ve tekrar bizden istenen sorgulama yerine
view'e atadigimiz ismi select komutuyla cagiririz
*/
CREATE VIEW maxminmaas 
AS
SELECT marka_isim,calisan_sayisi,
(SELECT max(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as enyuksekmaas,
(SELECT min(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as endusukmaas
FROM markalar;

SELECT * FROM maxminmaas;
SELECT * FROM summaas;


-- EXISTS CONDITION
CREATE TABLE mart
(   
urun_id int,    
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan 
(   
urun_id int ,
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

SELECT * FROM mart
SELECT * FROM nisan;

  /*
  MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
  URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
  MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız
  */
SELECT urun_id,musteri_isim FROM mart
WHERE exists (SELECT urun_id FROM nisan WHERE mart.urun_id=nisan.urun_id);

  /*
  Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
  NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
  */
SELECT urun_isim,musteri_isim FROM nisan
WHERE exists (SELECT urun_isim FROM mart WHERE mart.urun_isim=nisan.urun_isim);

 /*
ODEV: Her iki ayda ortak satilmayan ürünlerin URUN_ISIM'lerini ve  bu ürünleri
 NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
 */

--***** DML ==> UPDATE **** ----

DROP TABLE  if exists tedarikciler

CREATE TABLE tedarikciler -- parent
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);
INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');


DROP TABLE if exists urunler

CREATE TABLE urunler -- child
(
ted_vergino int, 
urun_id int, 
urun_isim VARCHAR(50), 
musteri_isim VARCHAR(50),
CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino) REFERENCES tedarikciler(vergi_no)
on delete cascade
);    
INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Yılmaz');

SELECT * FROM tedarikciler
select * from urunler

-- vergi_no’su 102 olan tedarikcinin firma ismini 'Vestel' olarak güncelleyeniz.
UPDATE tedarikciler
SET firma_ismi='Vestel' WHERE vergi_no=102;

--vergi_no’su 101 olan tedarikçinin firma ismini 'casper' ve irtibat_ismi’ni 'Ali Veli' olarak güncelleyiniz.
UPDATE tedarikciler
SET firma_ismi='casper',irtibat_ismi='Ali Veli' WHERE vergi_no=101;

--urunler tablosundaki 'Phone' değerlerini 'Telefon' olarak güncelleyiniz.
UPDATE urunler
SET urun_isim='Telefon' WHERE  urun_isim='Phone';

-- urunler tablosundaki urun_id değeri 1004'ten büyük olanların urun_id’sini 1 arttırın.
UPDATE urunler
SET urun_id = urun_id+1 WHERE urun_id>1004;

-- urunler tablosundaki tüm ürünlerin urun_id değerini ted_vergino sutun değerleri ile toplayarak güncelleyiniz
UPDATE urunler
SET urun_id = urun_id + ted_vergino 

--* urunler tablosundan Ali Bak’in aldigi urunun ismini, tedarikci tablosunda irtibat_ismi
--'Adam Eve' olan firmanın ismi (firma_ismi) ile degistiriniz.
--Bu update işlemini yapmadan önce, tabloları eski haline getirmeliyiz
DELETE FROM urunler
DELETE FROM tedarikciler

--SILDIK SONRA TEKRAR INSERT INTO'LARI EKLEDIK

UPDATE urunler
SET urun_isim=(SELECT firma_ismi FROM tedarikciler WHERE irtibat_ismi='Adam Eve')
WHERE musteri_isim='Ali Bak';

-- Urunler tablosunda laptop satin alan musterilerin ismini, firma_ismi Apple’in irtibat_isim'i ile degistirin
UPDATE urunler
SET musteri_isim =(SELECT irtibat_ismi FROM tedarikciler WHERE firma_ismi='Apple')
WHERE urun_isim='Laptop';





