----***** ALIASES *****----

CREATE TABLE calisanlar3
(
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50) 
);
INSERT INTO calisanlar3 VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO calisanlar3 VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO calisanlar3 VALUES(345678901, 'Mine Bulut', 'Izmir');

select * from calisanlar3

-- EGER IKI SUTUNUN VERILERINI BIRLESTIRMEK ISTERSEK CONCAT SEMBOLU || KULLANIRIZ
SELECT calisan_id as id, calisan_isim||' '||calisan_dogdugu_sehir AS calisan_bilgisi from calisanlar3
--arasina bosluk koymak icin ||' '||

--2:yol
SELECT calisan_id as id, concat (calisan_isim,' ',calisan_dogdugu_sehir) AS calisan_bilgisi from calisanlar3


---- IS NULL CONDITION -----
-- Arama yapilan field’da NULL degeri almis kayitlari getirir

CREATE TABLE insanlar1
(
ssn char(9),
isim varchar(50),
adres varchar(50)
);

INSERT INTO insanlar1 VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO insanlar1 VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO insanlar1 VALUES(345678901, 'Mine Bulut', 'Izmir');
INSERT INTO insanlar1 (ssn, adres) VALUES(456789012, 'Bursa');
INSERT INTO insanlar1 (ssn, adres) VALUES(567890123, 'Denizli');

SELECT * FROM insanlar1 

-- Name sutununda null olan degerleri listeleyelim
SELECT isim FROM insanlar1 WHERE isim IS NULL

-- Insanlar1 tablosunda sadece null olmayan degerleri listeleyiniz
SELECT isim FROM insanlar1 WHERE isim IS NOT NULL

-- Insanlar toplasunda null değer almış verileri no name olarak değiştiriniz
UPDATE insanlar1
SET isim='No Name'
WHERE isim IS NULL

----  ORDER BY CLAUSE ----
/*
Tablolardaki verileri sıralamak için ORDER BY komutu kullanırız
Büyükten küçüğe yada küçükten büyüğe sıralama yapabiliriz
Default olarak küçükten büyüğe sıralama yapar ASC
Eğer BÜYÜKTEN KÜÇÜĞE sıralmak istersek ORDER BY komutundan sonra DESC komutunu kullanırız
*/
drop table if exists insanlar
CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO insanlar VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO insanlar VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

select * from insanlar

--Insanlar tablosundaki datalari adres’e gore siralayin
SELECT * FROM insanlar ORDER BY adres; --naturel order yapar
SELECT * FROM insanlar ORDER BY soyisim; 

--Insanlar tablosundaki ismi Mine olanlari SSN sirali olarak listeleyin
select * from insanlar where isim='Mine' order by ssn; 

--NOT : Order By komutundan sonra field(sutun) ismi yerine field numarasi da kullanilabilir
--Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin 
select * from insanlar where soyisim='Bulut' order by 4

--Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin
select * from insanlar order by ssn DESC

--Insanlar tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyin
select * from insanlar order by isim ASC,soyisim DESC;

--İsim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız
/*
Eger sutun uzunluguna gore siralamak istersek LENGTH komutu kullaniriz
Ve yine uzunlugu buyukten kucuge siralamak istersek  sonuna DESC komutunu ekleriz
*/

select isim,soyisim from insanlar order by length (soyisim) desc;

--Tüm isim ve soyisim değerlerini aynı sutunda çağırarak her bir sütun değerini uzunluğuna göre sıralayınız
select isim||' '||soyisim AS isim_soyisim from insanlar order by length (isim||soyisim)

select isim||' '||soyisim AS isim_soyisim from insanlar order by length (isim)+length (soyisim) --2:yol

select CONCAT(isim,' ',soyisim) AS isim_soyisim from insanlar order by length (isim) + length (soyisim) --3

select CONCAT(isim,' ',soyisim) AS isim_soyisim from insanlar order by length (CONCAT(isim,soyisim)) --4


---- GROUP BY ----
--Group By komutu sonuçları bir veya daha fazla sütuna göre gruplamak için SELECT komutuyla birlikte kullanılır
CREATE TABLE manav
(
isim varchar(50),
Urun_adi varchar(50),
Urun_miktar int
);

INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);

select * from manav

-- Isme gore alinan toplam urunleri listeleyin
select sum(urun_miktar) from manav --boyle yazarsak tek bir sonuc dondurur

select isim,sum(urun_miktar) as aldigi_toplam_urun from manav
group by isim;

 --Isme gore alinan toplam urunleri bulun ve bu urunleri buyukten kucuge listeleyiniz
select isim,sum(urun_miktar) as aldigi_toplam_urun from manav
group by isim
order by aldigi_toplam_urun desc

-- Urun ismine gore urunu alan toplam kisi sayisi
select urun_adi,count(isim) from manav
group by urun_adi;




