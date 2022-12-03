CREATE TABLE ogrenciler3
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO ogrenciler3 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler3 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler3 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler3 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Ali', 99);

SELECT * FROM ogrenciler3;
-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.

DELETE FROM ogrenciler3 WHERE isim='Mustafa Bak' or isim='Nesibe Yilmaz';

--Veli ismi Hasan olani silelim
DELETE FROM ogrenciler3 WHERE veli_isim='Hasan';

--TRUNCATE tablodaki verileri siler, ama where ile kullanilmaz
--Bir tablodaki tum verileri geri alamayacagimiz sekilde siler

TRUNCATE TABLE ogrenciler3

--ON DELETE CASCADE
DROP TABLE if exists talebeler --Eger tablo varsa tabloyu siler

CREATE TABLE talebeler
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

DROP TABLE if exists notlar

CREATE TABLE notlar(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
on delete cascade
);

INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

SELECT * FROM talebeler;
SELECT * FROM notlar;

-- Notlar tablosundan talebe_id'si 123 olan datayi silelim
DELETE FROM notlar WHERE talebe_id='123';


/*
    Her defasında önce child tablodaki verileri silmek yerine ON DELETE CASCADE silme özelliği ile
parent tablo dan da veri silebiliriz. Yanlız ON DELETE CASCADE komutu kullanımında parent tablodan sildiğimiz
data child tablo dan da silinir
*/
CREATE TABLE talebe
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

CREATE TABLE not1(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebe(id)
on delete cascade
);

INSERT INTO talebe VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebe VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebe VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebe VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebe VALUES(127, 'Mustafa Bak', 'Can',99);

INSERT INTO not1 VALUES ('123','kimya',75);
INSERT INTO not1 VALUES ('124', 'fizik',65);
INSERT INTO not1 VALUES ('125', 'tarih',90);
INSERT INTO not1 VALUES ('126', 'Matematik',90);

select * from talebe
select * from not1

-- Talebeler tablosundan id'si 126 olan datayi silelim
DELETE FROM talebe WHERE id='126';


-- IN CONDITION
CREATE TABLE musteriler (
urun_id int,
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange'); 
INSERT INTO musteriler VALUES (20, 'John', 'Apple');
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm'); 
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple'); 
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange'); 
INSERT INTO musteriler VALUES (40, 'John', 'Apricot'); 
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

SELECT * FROM musteriler

--Musteriler tablosundan urun ismi orange,apple veya apricot olan tum verileri listeleyelim
SELECT * FROM musteriler WHERE urun_isim='Orange' OR urun_isim='Apple' OR urun_isim='Apricot';

--IN CONDITION
SELECT * FROM musteriler WHERE urun_isim IN ('Orange','Apple','Apricot');

--NOT IN ==>Yazdigimiz verilerin disindakileri getirir
SELECT * FROM musteriler WHERE urun_isim NOT IN ('Orange','Apple','Apricot');

SELECT * FROM musteriler WHERE urun_isim='Orange' AND urun_isim='Apple'; --Hicbir veri getirmez
SELECT * FROM musteriler WHERE urun_isim='Orange' AND urun_id=10 --Burda verileri getirir

-- BETWEEN CONDITION
--Musteriler tablosundan urun_id'si 20 ile 40 arasinda olan tum verileri listeleyelim
SELECT * FROM musteriler WHERE urun_id>=20 and urun_id<=40
SELECT * FROM musteriler WHERE urun_id BETWEEN 20 AND 40;

SELECT * FROM musteriler WHERE urun_id NOT BETWEEN 20 AND 40;--20 ile 40 disindakiler

